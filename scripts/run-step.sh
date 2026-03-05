#!/usr/bin/env bash
# run-step.sh — Spawn the right agent for the current OBJECT 001 step
# Usage: ./scripts/run-step.sh
# Reads state/project.json and spawns the appropriate agent automatically

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STATE_FILE="$REPO_DIR/state/project.json"

CURRENT_STEP=$(python3 -c "import json; print(json.load(open('$STATE_FILE'))['currentStep'])")

echo "📍 Current step: $CURRENT_STEP"

case "$CURRENT_STEP" in
  market_research)
    TASK_ID="market-research"
    AGENT="claude"
    MODEL="claude-opus-4-5"
    PROMPT="You are the OBJECT 001 design agent. Read AGENTS.md and SOUL.md. Your current step is market_research. Research the handheld gaming market thoroughly — check Reddit, Hacker News, Anbernic, Miyoo, Analogue, Playdate, Steam Deck. Find gaps. Identify what enthusiasts wish existed. Save a comprehensive report to state/research.md. Update state/project.json currentStep to product_decision when done. Log all decisions to state/ledger.json."
    ;;
  product_decision)
    TASK_ID="product-decision"
    AGENT="claude"
    MODEL="claude-opus-4-5"
    PROMPT="You are the OBJECT 001 design agent. Read AGENTS.md, SOUL.md, and state/research.md. Your current step is product_decision. Decide what to make. Write a product decision doc to state/product-decision.md covering: what it is, why this product, how to build it, estimated cost, units, alternatives rejected. Update state/project.json currentStep to design_explore. Log to state/ledger.json."
    ;;
  design_explore)
    TASK_ID="design-explore"
    AGENT="claude"
    MODEL="claude-opus-4-5"
    PROMPT="You are the OBJECT 001 design agent. Read AGENTS.md, SOUL.md, and state/product-decision.md. Your current step is design_explore. Use Vizcom to generate 8-12 concept renders in different directions. Score each on visual impact, manufacturability, originality, ergonomics, photography potential (1-10 each). Pick top 3. Save all scores to state/design-scores.json. Update state/project.json. Log to state/ledger.json."
    ;;
  design_refine)
    TASK_ID="design-refine"
    AGENT="claude"
    MODEL="claude-opus-4-5"
    PROMPT="You are the OBJECT 001 design agent. Read AGENTS.md, SOUL.md, and state/design-scores.json. Your current step is design_refine. For each top 3 direction, generate 5-6 refined renders plus color/material variants. Score on cohesion, detail quality, material feel, brand-ability. Pick THE ONE (must score 7+). Update state/design-scores.json. Update state/project.json. Log to state/ledger.json."
    ;;
  engineering)
    TASK_ID="engineering"
    AGENT="codex"
    MODEL="gpt-5.3-codex"
    PROMPT="You are the OBJECT 001 engineering agent. Read AGENTS.md and state/product-decision.md and state/design-scores.json. Your current step is engineering. Figure out how to build this device: electronics (transplant vs custom PCB), enclosure (CNC vs 3D print), screen, controls, battery, audio, software. Research component compatibility and pricing on LCSC/DigiKey. Produce state/engineering-spec.md and state/bom.json. Update state/project.json. Log to state/ledger.json."
    ;;
  find_manufacturers)
    TASK_ID="find-manufacturers"
    AGENT="claude"
    MODEL="claude-opus-4-5"
    PROMPT="You are the OBJECT 001 manufacturing agent. Read AGENTS.md, state/engineering-spec.md, and state/bom.json. Your current step is find_manufacturers. Research PCBWay, JLCPCB, Xometry, RapidDirect, and Alibaba CNC shops. Draft RFQ emails with specs, renders, BOM, and qty (10-20 units). Save quotes to state/manufacturer-quotes.json. Update state/project.json. Log to state/ledger.json."
    ;;
  human_approval)
    echo "🛑 This step requires human approval. Run: /object-001 status to review the spend proposal."
    exit 0
    ;;
  *)
    echo "⚠️  No auto-spawn configured for step: $CURRENT_STEP"
    exit 1
    ;;
esac

# Spawn the agent
"$REPO_DIR/scripts/spawn-agent.sh" "$TASK_ID" "$AGENT" "$MODEL" "$PROMPT"
