# OBJECT 001 — Build Plan v2
_Revised: 2026-03-06T01:56:18Z_
_Philosophy: Minimal assembly at door. No soldering. No wiring. No software setup._

---

## Approach: Anbernic Shell Swap

Buy 20× Anbernic RG35XX H units — fully working retro handhelds straight from the factory. Transplant the internals into custom CNC brushed aluminum shells. That's the entire build.

**Assembly per unit: ~10 minutes, one screwdriver.**

---

## Why Anbernic RG35XX H

| Spec | Value |
|------|-------|
| Display | 3.5" IPS, **640×480** (exact spec match) |
| SoC | Allwinner H700, quad-core A53 |
| RAM | 1GB DDR3 |
| Storage | microSD slot (user-replaceable) |
| Battery | 3500mAh built-in, USB-C charging |
| OS | Linux + RetroArch pre-loaded |
| Dimensions | 155 × 70 × 20mm (internals ~145 × 63mm) |
| Price | ~$55 shipped |
| Community | JELOS / muOS / GarlicOS custom firmware |

Plays: NES, SNES, GBA, GBC, PS1, N64, Neo Geo — out of the box.

---

## Final BOM (20 units)

| Line Item | Source | Qty | Unit | Total |
|-----------|--------|-----|------|-------|
| Anbernic RG35XX H | Amazon / AliExpress | 20 | $55 | $1,100 |
| CNC 6061-T6 shell (front) | PCBWay / Fictiv / Xometry | 20 sets | $18 | $360 |
| CNC 6061-T6 shell (rear) | PCBWay / Fictiv / Xometry | (included) | $14 | $280 |
| Type II anodize + brushed finish | (included in CNC quote) | 20 | — | — |
| Laser engraving "OBJECT 001 — XX/20" | PCBWay add-on | 20 | $3 | $60 |
| Replacement burgundy button caps | Aliexpress | 1 lot | $40 | $40 |
| M2 screw kit | Amazon | 1 | — | $10 |
| Kraft numbered packaging (01–20) | Local print | 20 | $2 | $40 |
| Shipping (vendors → SF) | — | — | — | $60 |
| Contingency 10% | — | — | — | $195 |
| **TOTAL** | | | | **$2,145** |

---

## Shell Design Constraints

The CNC shell must be machined to fit the Anbernic RG35XX H internals exactly:

```
Internal PCB footprint:  ~145mm × 63mm
Display opening:         83mm × 63mm (3.5" IPS)
Button cutouts:          Match RG35XX H layout exactly
Screw posts:             4× M2, matching original positions
USB-C port:              Right side, 9mm from bottom
MicroSD slot:            Left side
Volume/power buttons:    Top edge
Shell depth:             21mm assembled (front 11mm + rear 10mm)
```

**The CNC vendor needs the Anbernic RG35XX H teardown dimensions.** These are publicly documented — send vendor the reference drawings from the RG35XX modding community or provide caliper measurements from a sample unit ordered first.

---

## Assembly Sequence (when parts arrive)

**Before assembly day:**
- Flash muOS or JELOS to 20× microSD cards (better UI than stock)
- Insert SD cards into Anbernic units
- Power on each — verify display, buttons, audio, charging all work
- This is your QC baseline

**Assembly day (10 min/unit × 20 = ~4 hours, 2 people):**

1. Unscrew 4× M2 screws from Anbernic plastic shell
2. Separate front and rear plastic halves
3. Lift PCB + display + battery subassembly out
4. Drop subassembly into CNC aluminum front shell
5. Align display window, button cutouts, port openings
6. Place CNC aluminum rear shell, screw 4× M2 screws
7. Install burgundy ABS button caps (press-fit over existing tactile switches)
8. Power on in new shell — verify everything works
9. Pack in numbered kraft box (serial matches laser engraving)

**No soldering. No wiring. No electronics.**

---

## What to Order First

1. **1× Anbernic RG35XX H** — measure all internal dimensions with calipers → send to CNC vendor
2. **1× CNC sample shell** (from PCBWay/Fictiv) — verify fit before full run
3. On sample approval → order 19 more Anbernic units + 19 more shell sets
4. **Lead time: ~3–4 weeks** (CNC is the long pole)

---

## Software (pre-loaded, nothing to do)

Anbernic ships with RetroArch + EmulationStation. Optional upgrade:
- [muOS](https://muos.dev) — cleaner UI, 5-min flash to microSD
- [JELOS](https://jelos.org) — more features, community-supported

No coding. No config. Flash → play.

---

## Budget vs Previous Plans

| Version | Approach | Total |
|---------|----------|-------|
| v1 | Custom PCB + CNC + sourcing everything | $4,224 |
| v2 | Lean sourcing, still custom electronics | $2,174 |
| v3 | Pi Zero 2W + individual components | $1,364 |
| **v4 (current)** | **Anbernic shell swap — works out of box** | **$2,145** |

v4 costs slightly more than v3 but the assembly time drops from ~3 days of electronics work to a single 4-hour afternoon. The device is also better — larger display, bigger battery, more emulation power.
