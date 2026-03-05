# Spend Proposal — OBJECT 001 (20 units)
_Generated: 2026-03-05T23:28:15Z_

## Budget: $1,000–$5,000

---

## Line-Item Cost Breakdown

### Hardware (per unit × 20)

| Line Item | Vendor | Unit Cost | ×20 Total |
|-----------|--------|-----------|-----------|
| CNC 6061-T6 shell (front + back) | PCBWay | $45 | $900 |
| Type II anodize (silver) | PCBWay (included) | — | — |
| Laser engraving "XX/20" on rear | SendCutSend | $3 | $60 |
| ABS burgundy buttons (D-pad, A/B, Start/Select) | Fictiv (soft tool) | $35* | $700 |
| Custom PCB (5-layer) | JLCPCB | $2 | $40 |
| PCBA (populated board, excl. SoC) | JLCPCB | $12 | $240 |
| Radxa CM3 (RK3566, 1GB/16GB) | Radxa | $30 | $600 |
| 2.8" IPS 640×480 display | Waveshare | $12 | $240 |
| 3.7V 2500mAh LiPo battery | Aliexpress | $5 | $100 |
| USB-C port, misc connectors | Aliexpress/Mouser | $2 | $40 |
| Screws, standoffs, internal frame | Aliexpress | $3 | $60 |
| Anti-glare glass lens | Aliexpress | $4 | $80 |
| Packaging (numbered box + card) | Printful/local | $8 | $160 |

*Buttons: $500 soft tooling amortized over 20 units = $25 tooling + $10 parts = $35/unit

### One-Time Costs (not per-unit)

| Line Item | Cost |
|-----------|------|
| Button mold tooling (aluminum soft tool) | $500 |
| PCB design review / gerber prep | $0 (in-house) |
| Shipping (vendors → assembly location) | $80 |
| Misc consumables (flux, thermal paste, test cables) | $40 |

---

## Summary

| Category | Subtotal |
|----------|----------|
| Hardware (20 units × avg $162/unit) | $3,220 |
| One-time tooling + shipping + misc | $620 |
| **Subtotal** | **$3,840** |
| Contingency (10%) | $384 |
| **TOTAL** | **$4,224** |

**Within $1,000–$5,000 budget ✓**
**Headroom remaining: ~$776**

---

## Budget Scenarios

| Scenario | Cost | Notes |
|----------|------|-------|
| **Optimistic** (all quotes come in at low end) | ~$2,900 | Buttons via 3D print ($200 resin), shell at $35 |
| **Base case** (midpoint estimates) | ~$4,224 | As above |
| **Pessimistic** (tooling delays, reshoot shipping) | ~$4,800 | Shell revision needed, second anodize batch |

All three scenarios are within budget.

---

## Risk Flags

1. **Shell tolerances** — CNC prototype should be ordered as a single sample first ($50–80 est.) before full 20-unit run to verify fit with display and PCB
2. **Radxa CM3 stock** — Check availability before committing to shell dimensions; CM3 form factor is fixed
3. **Button tooling** — If Fictiv timeline slips, swap to PCBWay SLA resin buttons for first units (2-day lead time, ~$200 total for 20 sets, paintable)
4. **Display interface** — Confirm Radxa CM3 GPIO pinout matches Waveshare display before PCB layout

---

## Recommended Approval Path

1. ✅ **Approve this proposal** → trigger manufacture step
2. Order PCBWay shell sample (1 unit) + Radxa CM3 (2 units) simultaneously
3. On sample approval: order full 20-unit CNC run + JLCPCB PCB/PCBA
4. Final assembly: self-assembled at SF location (1–2 day session)
5. Ship/launch

**Estimated manufacture-to-ship timeline: 4–6 weeks**
