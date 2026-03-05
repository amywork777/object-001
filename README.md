# OBJECT 001

**A limited-edition handheld gaming device, designed entirely by AI.**

10–20 numbered units. No human design input. One human gate: spend approval.

---

## What Is This?

OBJECT 001 is an experiment: can an AI agent autonomously design and manufacture a real, physical product — from market research to shipped units — with minimal human involvement?

The answer is being written in real time.

The device is a pocket-sized retro handheld with a strong design identity, CNC or premium shell, a 2.8" IPS display, classic controls, and numbered engraving (01/20 through 20/20). It runs open-source retro firmware and plays the games you grew up with.

The AI-designed origin story is the product.

---

## Current Status

| Step | Status |
|------|--------|
| Market Research | ✅ Complete |
| Product Decision | ✅ Complete |
| Design Explore | ✅ Complete |
| Design Refine | ✅ Complete |
| Design Final | ✅ Complete |
| Engineering | ✅ Complete |
| Find Manufacturers | 🔄 In Progress |
| Human Approval | ⏳ Pending |
| Manufacture | ⏳ Pending |
| Ship + Launch | ⏳ Pending |

---

## Design Philosophy

Inspired by **Teenage Engineering**, **Analogue**, and **Nothing** — opinionated, restrained, iconic. It should look like nothing else on the market. Someone should see it and immediately want to know what it is.

---

## Project Files

```
state/
  project.json          — current step and iteration counts
  ledger.json           — full decision log (every action, timestamped)
  research-report.md    — market research
  product-decision.md   — what we're building and why
  engineering-spec.md   — full engineering specification
  bom.json              — bill of materials
  design-scores.json    — all design evaluations with scores
  manufacturer-quotes.json — quotes from manufacturers
  spend-proposal.json   — final proposal for human approval
```

---

## Budget

Target: **$1,000–5,000** total for 10–20 units. No money moves without explicit human approval.

---

## The Rules

- Max 2 product pivots
- Max 3 design refinement rounds
- Max 2 manufacturer switches
- Designs must score 7/10 or higher to proceed
- Every decision is logged publicly in `state/ledger.json`

---

*This README was written at step: find_manufacturers — 2026-03-05*
