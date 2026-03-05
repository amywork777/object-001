#!/usr/bin/env bash
# spawn-agent.sh — Launch a coding agent in a tmux session for OBJECT 001
# Usage: ./scripts/spawn-agent.sh <task-id> <agent> <model> <prompt>
# Agents: codex | claude
# Example: ./scripts/spawn-agent.sh market-research claude claude-opus-4-5 "Run market research step"

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TASKS_FILE="$REPO_DIR/.clawdbot/active-tasks.json"

TASK_ID="${1:?Usage: spawn-agent.sh <task-id> <agent> <model> <prompt>}"
AGENT="${2:?Specify agent: codex | claude}"
MODEL="${3:?Specify model}"
PROMPT="${4:?Specify prompt}"

SESSION="obj001-$TASK_ID"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Check if session already exists
if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "⚠️  Session $SESSION already exists. Kill it first or use a different task-id."
  exit 1
fi

# Build agent command
case "$AGENT" in
  codex)
    CMD="codex --model $MODEL -c model_reasoning_effort=high --dangerously-bypass-approvals-and-sandbox \"$PROMPT\""
    ;;
  claude)
    CMD="claude --model $MODEL --dangerously-skip-permissions -p \"$PROMPT\""
    ;;
  *)
    echo "Unknown agent: $AGENT. Use 'codex' or 'claude'."
    exit 1
    ;;
esac

# Create tmux session
tmux new-session -d -s "$SESSION" -c "$REPO_DIR"

# Send agent command to session
tmux send-keys -t "$SESSION" "$CMD" Enter

echo "✅ Spawned $AGENT agent in tmux session: $SESSION"

# Register task in active-tasks.json
TASK_ENTRY=$(cat <<EOF
{
  "id": "$TASK_ID",
  "tmuxSession": "$SESSION",
  "agent": "$AGENT",
  "model": "$MODEL",
  "description": "$PROMPT",
  "repo": "object-001",
  "startedAt": $(date +%s000),
  "status": "running",
  "notifyOnComplete": true,
  "attempts": 1,
  "maxAttempts": 3
}
EOF
)

# Append to active-tasks.json
CURRENT=$(cat "$TASKS_FILE")
if [ "$CURRENT" = "[]" ]; then
  echo "[$TASK_ENTRY]" > "$TASKS_FILE"
else
  # Remove trailing ] and append new entry
  python3 -c "
import json, sys
tasks = json.load(open('$TASKS_FILE'))
new_task = $TASK_ENTRY
tasks.append(new_task)
json.dump(tasks, open('$TASKS_FILE', 'w'), indent=2)
print('Task registered.')
"
fi

echo "📋 Task registered: $TASK_ID"
echo "📺 Attach: tmux attach -t $SESSION"
