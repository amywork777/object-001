# Manufacturer Research — OBJECT 001
_Generated: 2026-03-05T23:28:15Z_

## What We Need to Source (20 units)

| Component | Spec |
|-----------|------|
| CNC aluminum shell | 6061-T6, Type II anodized silver, brushed 150–180 grit |
| Burgundy ABS buttons | D-pad, A/B, Start/Select — injection molded |
| Speaker grille | Perforated aluminum, CNC or etched |
| RK3566 compute module | Quad-core Cortex-A55, 1GB LPDDR4, 16GB eMMC |
| 2.8" IPS display | 640×480, 60Hz, with anti-glare glass |
| Main PCB (custom) | USB-C, battery management, GPIO |
| PCBA (assembly) | Solder components onto custom PCB |
| Battery | ~2500mAh LiPo, flat pack |
| Unit numbering | Laser engraved "XX/20" on rear panel |
| Final assembly | 20 units hand-assembled |

---

## Vendor Selection by Category

### 1. CNC Aluminum Shell
**Primary: PCBWay CNC**
- URL: pcbway.com/rapid-prototyping/manufacture
- Why: Online quoting, handles 6061-T6 well, anodizing in-house, prototyping-friendly MOQ (as low as 1 unit), used by indie hardware projects globally
- Estimated turnaround: 7–14 days
- Anodizing: Yes, Type II silver available as add-on
- Brushing: Can be requested as surface finish; specify Ra 0.4–0.8 µm
- Est. unit price (20 pcs, shell + back plate): $35–55/unit

**Backup: JLCPCB CNC (jlcpcb.com)**
- Same platform as JLCPCB PCB ordering
- Slightly less experience with anodizing but competitive pricing
- Good for tight-budget runs

### 2. Injection-Molded Burgundy Buttons
**Primary: Fictiv (fictiv.com)**
- Handles low-volume injection molding with tooling amortization
- For 20 units, soft tooling (aluminum mold) is viable: ~$500–800 tooling + $1–3/part
- Color match: Pantone 7421 C (deep burgundy/maroon) or custom compound
- 6 button types × 20 units = 120 pieces total

**Alternative: Direct from Shenzhen button suppliers via Alibaba**
- Search: "custom silicone ABS buttons low MOQ"
- MOQ often 100 pcs per color, but for 20 units that's acceptable
- Cheaper tooling (~$200–300) but less quality control
- ABS or POM, colored at compound level (not painted)

**Budget option: 3D print buttons in Formlabs Rigid 10K resin**
- Near-injection-quality surface, paintable
- PCBWay also offers SLA/MJF resin printing if buttons don't need tight snap-fit

### 3. PCB Fabrication + PCBA
**Primary: JLCPCB (jlcpcb.com)**
- Industry standard for low-volume PCB + assembly
- PCB fab: 5-layer, 2-day lead time possible, ~$15–30 for 20 boards
- PCBA: Component sourcing + SMT soldering, online BOM upload
- Handles RK3566-adjacent peripherals (power mgmt ICs, USB-C controllers)
- Total est. for 20 populated boards (excl. SoC module): $200–400

**Backup: PCBWay** (same capabilities, slightly more expensive for small runs)

### 4. Compute Module (RK3566)
**Primary: Radxa CM3 (radxa.com)**
- Based on RK3566, comes as a stamp-size module (55×40mm)
- 1GB LPDDR4 + 16GB eMMC configs available
- Works with MuOS out of the box (community firmware)
- Available direct from Radxa store or via OKdo/Mouser
- Price: ~$25–35/module at qty 20
- Est. lead time: 1–2 weeks in stock

**Alternative: Anbernic supply chain parts**
- Anbernic uses RK3566 in RG353 series; some teardown-sourced modules available on Aliexpress
- Risk: No official docs, may need custom BSP work
- Not recommended for our timeline

**Alternative: Banana Pi BPI-CM4 (RK3566)**
- Similar spec, slightly different form factor
- Available from AliExpress vendors in small qty

### 5. Display (2.8" IPS 640×480)
**Primary: Aliexpress / Waveshare**
- Waveshare 2.8inch IPS display module (waveshare.com)
- 640×480, SPI or RGB interface, anti-glare option
- ~$8–14/unit at qty 20
- Well-documented, multiple open-source drivers
- Lead time: ships from stock

**Alternative: Buydisplay (buydisplay.com)**
- Larger catalog of IPS panels, custom connector options
- MOQ: 1 unit for standard models
- Good for getting exact spec match to shell cutout

### 6. Battery (2500mAh LiPo)
**Primary: Aliexpress battery sellers**
- Search: "3.7V 2500mAh LiPo flat pack 50x70mm"
- Many options, $3–6/unit at qty 20–50
- Key spec: confirm thickness ≤ 5mm to fit shell depth
- Include over-charge/discharge protection circuit (PCM)

### 7. Laser Unit Numbering
**Service: SendCutSend or local laser shop**
- SendCutSend (sendcutsend.com) does laser engraving on aluminum parts
- Upload rear panel post-anodizing, engrave "OBJECT 001 — XX/20"
- ~$2–5/unit
- Alternative: Include in PCBWay CNC order as secondary op

### 8. Final Assembly
**Option A: Self-assembly (Amy + team)**
- 20 units is very manageable in 1–2 days with a small team
- No additional cost
- Gives full QC control and the "handmade" story

**Option B: Contract assembly via PCBWay**
- PCBWay offers mechanical assembly services
- Add-on to CNC order; est. $5–15/unit labor

---

## Vendor Summary Table

| Category | Vendor | Est. Unit Cost (×20) | MOQ | Lead Time |
|----------|--------|----------------------|-----|-----------|
| CNC shell + anodize | PCBWay | $35–55 | 1 | 7–14 days |
| Buttons (ABS) | Fictiv soft tool | $30–50 tooling+parts | 20 | 10–14 days |
| PCB + PCBA | JLCPCB | $15–25 | 5 | 5–10 days |
| RK3566 module | Radxa CM3 | $25–35 | 1 | 7–14 days |
| 2.8" IPS display | Waveshare | $8–14 | 1 | 3–7 days |
| Battery LiPo | Aliexpress | $4–6 | 1 | 7–14 days |
| Laser engraving | SendCutSend | $2–5 | 1 | 3–5 days |
| Assembly | Self / PCBWay | $0–15 | — | — |

**Total estimated component cost per unit: $119–194**
**Total for 20 units: $2,380–$3,880**

Within $1,000–$5,000 budget ✓

---

## Critical Path
Longest lead items (order first):
1. CNC shell (PCBWay) — 7–14 days, must be first
2. Radxa CM3 modules — order in parallel with shell
3. Buttons tooling (Fictiv) — if soft tooling, 10–14 days; if 3D print, 2–3 days

PCB, display, battery can be ordered later without blocking critical path.
