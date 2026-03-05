---
name: object-001
description: OBJECT 001 project management — design and manufacture a handheld gaming device
user-invocable: true
---

# OBJECT 001 — Project Control

When the user invokes this skill, manage the OBJECT 001 project.

## Commands

- `/object-001 status` — Show current project state
- `/object-001 run` — Execute the next step in the workflow
- `/object-001 approve` — Approve the spend proposal
- `/object-001 deny <reason>` — Deny the spend proposal
- `/object-001 ledger` — Show the decision log
- `/object-001 reset` — Reset project state (requires confirmation)

## State Management

All project state is stored in `{baseDir}/../../state/` as JSON and Markdown files.

### Reading State

Before any action, read `{baseDir}/../../state/project.json` to determine the current step. The structure is:

```json
{
  "currentStep": "market_research",
  "steps": [
    "market_research",
    "product_decision",
    "design_explore",
    "design_refine",
    "design_final",
    "engineering",
    "find_manufacturers",
    "human_approval",
    "manufacture",
    "ship_launch",
    "complete"
  ],
  "iterations": {
    "productPivots": 0,
    "designRefinements": 0,
    "manufacturerSwitches": 0
  },
  "maxIterations": {
    "productPivots": 2,
    "designRefinements": 3,
    "manufacturerSwitches": 2
  },
  "artifacts": {
    "researchReport": false,
    "productDecision": false,
    "designScores": false,
    "selectedDesign": null,
    "engineeringSpec": false,
    "bom": false,
    "manufacturerQuotes": false,
    "spendProposal": false,
    "approvalStatus": null
  }
}
```

### Updating State

After completing work, update `project.json` to reflect:
- Step advancement
- Iteration count changes
- Artifact completion flags

### Logging Decisions

Append every decision to `{baseDir}/../../state/ledger.json` (array of entries):

```json
{
  "id": "uuid",
  "timestamp": "2026-03-04T12:00:00Z",
  "type": "decision",
  "step": "market_research",
  "summary": "Decided to focus on retro gaming segment",
  "details": {}
}
```

## Vizcom Integration

Use the Vizcom MCP tools for design work:
1. `list_teams` → get your team
2. `create_workbench` → create a workbench for the project
3. `create_drawing` → create drawings within the workbench
4. `modify_image` / `render_sketch` → generate and refine designs
5. `export_image` → export final renders
6. `get_generation_status` → check render progress

Save render metadata to `{baseDir}/../../state/design-scores.json`.

## Human Approval Flow

At the `human_approval` step:
1. Read `{baseDir}/../../state/spend-proposal.json`
2. Format a clear message showing: product, renders, manufacturer, cost breakdown, unit count
3. Send to the human via their chat channel
4. Wait for explicit "approved" or "denied" response
5. Update `project.json` artifacts.approvalStatus accordingly
6. Do NOT proceed to manufacture until approved
