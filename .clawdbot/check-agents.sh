#!/usr/bin/env bash
# check-agents.sh — Monitor all active OBJECT 001 agent tasks
# Run every 10 minutes via cron or manually
# Deterministic, token-efficient — no AI calls

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TASKS_FILE="$REPO_DIR/.clawdbot/active-tasks.json"
STATE_FILE="$REPO_DIR/state/project.json"
LEDGER_FILE="$REPO_DIR/state/ledger.json"
LOG_FILE="$REPO_DIR/.clawdbot/check.log"

log() {
  echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] $*" | tee -a "$LOG_FILE"
}

notify_telegram() {
  local msg="$1"
  # Use openclaw notify if available
  if command -v openclaw &>/dev/null; then
    openclaw notify --channel telegram --message "$msg" 2>/dev/null || true
  fi
  log "NOTIFY: $msg"
}

log "=== check-agents.sh starting ==="

# Read current tasks
TASKS=$(cat "$TASKS_FILE")
TASK_COUNT=$(echo "$TASKS" | python3 -c "import json,sys; print(len(json.load(sys.stdin)))")

if [ "$TASK_COUNT" -eq 0 ]; then
  log "No active tasks. Done."
  exit 0
fi

log "Checking $TASK_COUNT task(s)..."

# Process each task
python3 - <<'PYEOF'
import json, subprocess, sys, os
from datetime import datetime, timezone

repo_dir = os.environ.get("REPO_DIR", os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
tasks_file = os.path.join(repo_dir, ".clawdbot", "active-tasks.json")
state_file = os.path.join(repo_dir, "state", "project.json")
ledger_file = os.path.join(repo_dir, "state", "ledger.json")

tasks = json.load(open(tasks_file))
state = json.load(open(state_file))
ledger = json.load(open(ledger_file))

updated = False
alerts = []

for task in tasks:
    if task["status"] in ("done", "failed", "cancelled"):
        continue

    session = task["tmuxSession"]
    task_id = task["id"]

    # Check if tmux session is alive
    result = subprocess.run(
        ["tmux", "has-session", "-t", session],
        capture_output=True
    )
    session_alive = result.returncode == 0

    if not session_alive:
        # Session ended — check if step advanced in project.json
        current_step = state.get("currentStep", "unknown")
        last_step = task.get("lastKnownStep", "unknown")

        # Check if ledger has new entries since task start
        started_at = task.get("startedAt", 0) / 1000
        new_entries = [
            e for e in ledger
            if datetime.fromisoformat(e["timestamp"].replace("Z", "+00:00")).timestamp() > started_at
        ]

        if new_entries or current_step != last_step:
            # Work was done
            task["status"] = "done"
            task["completedAt"] = int(datetime.now(timezone.utc).timestamp() * 1000)
            task["stepReached"] = current_step
            task["ledgerEntries"] = len(new_entries)
            updated = True
            alerts.append(f"✅ Task '{task_id}' complete. Step: {current_step}. {len(new_entries)} ledger entries added.")
        else:
            # Session died with no progress
            attempts = task.get("attempts", 1)
            max_attempts = task.get("maxAttempts", 3)

            if attempts < max_attempts:
                task["status"] = "failed"
                task["lastFailure"] = f"Session died with no progress (attempt {attempts}/{max_attempts})"
                updated = True
                alerts.append(f"⚠️ Task '{task_id}' session died with no progress. Attempt {attempts}/{max_attempts}. Manual respawn needed.")
            else:
                task["status"] = "failed"
                task["lastFailure"] = f"Max attempts ({max_attempts}) reached"
                updated = True
                alerts.append(f"❌ Task '{task_id}' FAILED after {max_attempts} attempts. Human attention needed.")
    else:
        # Session is alive — still running
        elapsed_ms = int(datetime.now(timezone.utc).timestamp() * 1000) - task.get("startedAt", 0)
        elapsed_min = elapsed_ms // 60000
        print(f"  ▶ {task_id} running in {session} ({elapsed_min}m elapsed)")

        # Warn if running too long (>2 hours)
        if elapsed_min > 120:
            alerts.append(f"⏱ Task '{task_id}' has been running for {elapsed_min} minutes. May need attention.")

if updated:
    json.dump(tasks, open(tasks_file, "w"), indent=2)
    print("Task registry updated.")

for alert in alerts:
    print(alert)

# Write alerts to stdout for shell to pick up
if alerts:
    with open(os.path.join(repo_dir, ".clawdbot", "pending-alerts.txt"), "w") as f:
        f.write("\n".join(alerts))
else:
    alert_file = os.path.join(repo_dir, ".clawdbot", "pending-alerts.txt")
    if os.path.exists(alert_file):
        os.remove(alert_file)

PYEOF

export REPO_DIR

# Send any pending alerts via Telegram
ALERT_FILE="$REPO_DIR/.clawdbot/pending-alerts.txt"
if [ -f "$ALERT_FILE" ]; then
  while IFS= read -r line; do
    notify_telegram "🤖 OBJECT 001: $line"
  done < "$ALERT_FILE"
fi

log "=== check-agents.sh done ==="
