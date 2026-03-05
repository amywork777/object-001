# Spend Proposal v3 — OBJECT 001 (20 units)
_Revised: 2026-03-05T23:35:00Z — minimum viable version_

## Key Cuts from v2
- **Shell**: PCBWay → direct Aliexpress CNC shop (same spec, half the price)
- **Compute**: RK3566 module ($400) → Raspberry Pi Zero 2W ($300) — runs RetroPie, proven retro gaming firmware, no custom BSP needed
- **PCB**: Full PCBA ($240) → simple breakout board only ($50) — Pi Zero 2W handles everything via GPIO
- **Display**: Switch to SPI variant, $8/unit vs $12

---

## Line-Item Costs (×20 units)

| Line Item | Vendor | ×20 Total |
|-----------|--------|-----------|
| CNC 6061-T6 shell + anodize | Aliexpress CNC | $400 |
| Laser "XX/20" engraving | Aliexpress add-on | $40 |
| Burgundy ABS buttons | Aliexpress | $40 |
| Simple breakout PCB | JLCPCB | $50 |
| Raspberry Pi Zero 2W | Aliexpress / Pi supplier | $300 |
| 2.8" IPS display (SPI) | Aliexpress | $160 |
| 3.7V 2500mAh LiPo + charger module | Aliexpress | $100 |
| Misc hardware (screws, USB-C, lens) | Aliexpress | $60 |
| Packaging (kraft box + numbered sticker) | Local | $30 |
| Shipping | — | $60 |
| Contingency (10%) | — | $124 |
| **TOTAL** | | **$1,364** |

---

## Budget Comparison

| Version | Total | Savings vs Prior |
|---------|-------|-----------------|
| v1 (original) | $4,224 | — |
| v2 (lean) | $2,174 | −$2,050 |
| **v3 (minimum viable)** | **$1,364** | **−$810** |

**$3,636 headroom vs $5K budget.**

## What's Still Premium
- Real CNC brushed aluminum shell — the design identity
- Laser-engraved unit numbers
- 20 individually numbered units

## Trade-off
Pi Zero 2W vs RK3566: handles NES/SNES/GBA/light PS1 perfectly. Not as fast for N64/PS1 heavy titles, but fine for a collector retro device.

## Timeline
~3–4 weeks (Pi Zero 2W ships fast, no tooling delays)
