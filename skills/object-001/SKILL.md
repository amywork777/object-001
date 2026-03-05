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
- `/object-001 note <mistake>` — Log a mistake or correction so it's never repeated
- `/object-001 errors` — Show the error/mistake log
- `/object-001 reset` — Reset project state (requires confirmation)

## Error Memory — Read This First

**Before every single action**, read `{baseDir}/../../state/errors.json`.

This file contains logged mistakes, failed approaches, and corrections from past runs.
If an error entry is relevant to what you're about to do — **change your approach**.
Never repeat a logged mistake.

Example: if errors.json says "Vizcom login fails with expired token after 1h — re-authenticate before each step",
then always re-authenticate fresh at the start of each step, don't reuse a token.

### Logging Errors

Whenever something fails, gets retried, or a human flags a mistake with `/object-001 note`,
append to `{baseDir}/../../state/errors.json`:

```json
{
  "id": "uuid",
  "timestamp": "2026-03-05T21:00:00Z",
  "step": "design_explore",
  "type": "agent_error | human_correction | api_failure | bad_output",
  "summary": "One-line description of what went wrong",
  "root_cause": "Why it happened",
  "fix": "What to do differently next time",
  "resolved": true
}
```

Always include `fix` — the whole point is to not repeat it.

---

## State Management

All project state is stored in `{baseDir}/../../state/` as JSON and Markdown files.

### Reading State

Before any action, read `{baseDir}/../../state/project.json` to determine the current step.

### Updating State

After completing work, update `project.json` to reflect:
- Step advancement
- Iteration count changes
- Artifact completion flags

### Step Timing — Always Record

Every step must record its timing in `project.json` under `stepTimings`:

**When starting a step**, set:
```json
"stepTimings": {
  "<stepId>": {
    "startedAt": "<ISO timestamp>",
    "completedAt": null,
    "durationMs": null
  }
}
```

**When completing a step**, fill in:
```json
"stepTimings": {
  "<stepId>": {
    "startedAt": "<when it started>",
    "completedAt": "<ISO timestamp now>",
    "durationMs": <completedAt ms - startedAt ms>
  }
}
```

This is how the dashboard shows per-step timing. Do not skip this.

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

Vizcom is accessed via its **GraphQL API** at the dev environment. No MCP needed.

### Endpoint & Auth

```
API: https://pr-5256.dev.vizcom.com/api/v1/graphql
Login: admin@test.com / test
```

### Step 1: Authenticate

```graphql
mutation {
  login(input: { email: "admin@test.com", password: "test" }) {
    authToken
  }
}
```

Store the token and pass it as `Authorization: Bearer <token>` on all subsequent requests.

### Step 2: Create a new workbench for this project

Always create a **fresh workbench** for OBJECT 001. Never reuse existing files.

First get the team/folder to create it in:

```graphql
{
  currentUser {
    organizations {
      nodes {
        teams {
          nodes {
            id
            name
            rootFolder { id }
          }
        }
      }
    }
  }
}
```

Then create the workbench:

```graphql
mutation {
  createWorkbench(input: {
    workbench: { name: "OBJECT 001", folderId: "<rootFolderId>" }
    startInStudio: false
  }) {
    workbench { id name }
  }
}
```

Save the workbench ID to `{baseDir}/../../state/vizcom.json`.

**Note:** The workbench for this project has already been created:
- ID: `8bffd0a2-c2a8-4b22-9271-85bc87b74ea6`
- Only create a new one if this ID stops working.

### Step 3: Run the agentic chat bar

This is the core of design generation. The `startAgentSession` mutation replicates
exactly what the chat bar does in the Vizcom UI.

```graphql
mutation StartAgent($input: StartAgentSessionInput!) {
  startAgentSession(input: $input) {
    sessionId
    status
    modelId
  }
}
```

Variables:
```json
{
  "input": {
    "workbenchId": "<workbenchId>",
    "prompt": "<your design prompt>",
    "cameraPosition": { "x": 0, "y": 0, "zoom": 1 },
    "agentVersion": "DEV_DESIGNER_V1"
  }
}
```

### Step 4: Poll for completion

```graphql
{
  agentSession(id: "<sessionId>") {
    id
    status
    metadata
    steps {
      nodes {
        id
        seq
        type
        status
        input
        output
        artifacts {
          nodes {
            id
            kind
            payload
            toolName
            elementId
          }
        }
      }
    }
  }
}
```

Poll every 3–5 seconds until `status == "completed"` or `status == "failed"`.

### Step 5: Retrieve generated images

Generated drawings appear in the workbench with thumbnail URLs:

```graphql
{
  workbench(id: "<workbenchId>") {
    drawings {
      nodes {
        id
        name
        thumbnailPath
      }
    }
  }
}
```

Thumbnail URLs follow the pattern:
`https://staging.assets.vizcom.com/customPrompt/<drawingId>`

Save drawing IDs and thumbnail URLs to `{baseDir}/../../state/design-scores.json`.

### Available Agent Actions

The agent (`DEV_DESIGNER_V1`) can autonomously use:
- `TEXT_TO_IMAGE` — generate from text prompt
- `RENDER` — render a sketch into a photorealistic image
- `MODIFY_IMAGE` — modify an existing image

The agent decides which to use based on your prompt.

### Design Step Prompts

**design_explore** — Generate 4 distinct design directions:
```
Design a compact handheld gaming device. Generate 4 distinct design directions:
1. Minimal/modern - clean lines, matte surfaces
2. Ergonomic/curved - comfortable grip, rounded edges
3. Retro-inspired - classic gaming aesthetic, chunky buttons
4. Cyberpunk/bold - aggressive angles, accent lighting details
```

**design_refine** — Iterate on a specific design:
```
Refine this design: [description]. Make it more [direction].
Generate 3 variations exploring [specific aspect].
```

**design_final** — Lock in the chosen design:
```
This is the final design direction. Generate a clean hero render,
a side profile view, and a top-down view suitable for manufacturing reference.
```

## Human Approval Flow

At the `human_approval` step:
1. Read `{baseDir}/../../state/spend-proposal.json`
2. Format a clear message showing: product, renders, manufacturer, cost breakdown, unit count
3. Send to the human via their chat channel
4. Wait for explicit "approved" or "denied" response
5. Update `project.json` artifacts.approvalStatus accordingly
6. Do NOT proceed to manufacture until approved
