#!/usr/bin/env bash
# steer-agent.sh — Send a mid-task redirect to a running agent
# Usage: ./scripts/steer-agent.sh <task-id> "<message>"
# Example: ./scripts/steer-agent.sh market-research "Focus on retro gaming segment, not mobile."

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TASKS_FILE="$REPO_DIR/.clawdbot/active-tasks.json"

TASK_ID="${1:?Usage: steer-agent.sh <task-id> <message>}"
MESSAGE="${2:?Provide a steering message}"

# Look up tmux session for task
SESSION=$(python3 -c "
import json
tasks = json.load(open('$TASKS_FILE'))
for t in tasks:
    if t['id'] == '$TASK_ID' and t['status'] == 'running':
        print(t['tmuxSession'])
        break
")

if [ -z "$SESSION" ]; then
  echo "❌ No running task found with id: $TASK_ID"
  exit 1
fi

# Check session is alive
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "❌ tmux session '$SESSION' is not running"
  exit 1
fi

# Send message to the agent
tmux send-keys -t "$SESSION" "$MESSAGE" Enter

echo "✅ Steered agent in $SESSION: $MESSAGE"

# Log to ledger
python3 - <<EOF
import json
from datetime import datetime, timezone

ledger_file = "$REPO_DIR/state/ledger.json"
ledger = json.load(open(ledger_file))
ledger.append({
    "id": "steer-$(date +%s)",
    "timestamp": datetime.now(timezone.utc).isoformat().replace("+00:00", "Z"),
    "type": "steer",
    "step": "runtime",
    "summary": "Human steered agent: $TASK_ID",
    "details": {
        "taskId": "$TASK_ID",
        "session": "$SESSION",
        "message": "$MESSAGE"
    }
})
json.dump(ledger, open(ledger_file, "w"), indent=2)
print("Logged to ledger.")
EOF
