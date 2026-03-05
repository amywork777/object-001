# .clawdbot — Agent Swarm Control

OBJECT 001 task registry and monitoring scripts.

## Files

- `active-tasks.json` — live task registry (running, done, failed)
- `check-agents.sh` — monitoring script (run every 10 min)
- `check.log` — monitoring log
- `cron.log` — cron output log
- `pending-alerts.txt` — alerts queued for Telegram (auto-deleted after send)

## Scripts (in /scripts)

| Script | Usage |
|--------|-------|
| `spawn-agent.sh` | Launch a new agent in a tmux session |
| `run-step.sh` | Auto-spawn the right agent for the current project step |
| `steer-agent.sh` | Send a mid-task redirect to a running agent |

## Quick Commands

```bash
# Start the next project step automatically
./scripts/run-step.sh

# Spawn a specific agent manually
./scripts/spawn-agent.sh <task-id> <codex|claude> <model> "<prompt>"

# Steer a running agent
./scripts/steer-agent.sh <task-id> "Focus on X, not Y."

# Check all agent status
./.clawdbot/check-agents.sh

# Attach to a running session
tmux attach -t obj001-<task-id>

# Send keys without attaching
tmux send-keys -t obj001-<task-id> "your message" Enter
```

## Task Status Flow

```
running → done      (session ended + ledger entries added)
running → failed    (session died, no progress, < max attempts)
failed  → [respawn] (manual: run spawn-agent.sh again)
```

## Definition of Done (OBJECT 001)

- Step advanced in `state/project.json`
- New entries in `state/ledger.json`
- Relevant state file created/updated (research.md, bom.json, etc.)
- For `human_approval` step: spend proposal sent and explicitly approved
