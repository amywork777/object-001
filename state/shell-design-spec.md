# OBJECT 001 — Shell Design Specification
**Drawing: SHELL-001 · Rev A · 2026-03-06**

---

## Overview

Custom CNC brushed aluminum shell housing Anbernic RG35XX H internals (PCB, display, battery, button mechanisms). Exterior is fully custom-designed based on OBJECT 001 Vizcom renders (adbf947c — Retro Premium Brushed Metal). Interior cavity is sized to fit RG35XX H guts.

Two-part shell: front cover + rear body, mating at horizontal split seam.

---

## Exterior Dimensions

| Dimension        | Value    | Notes                                   |
|------------------|----------|-----------------------------------------|
| Width            | 152mm    | Slightly wider than Anbernic for grip   |
| Height           | 74mm     | Slightly shorter, cleaner look          |
| Total depth      | 22mm     | Front half: 10mm · Rear half: 12mm      |
| Corner radius    | R10mm    | All 4 front-face corners                |
| Edge treatment   | R2mm     | All long edges (top/bottom/sides)       |
| Top/bottom edges | C0.5     | 0.5mm × 45° chamfer, premium feel       |

**Total mass estimate: ~90g per unit (6061-T6 aluminum)**

---

## Interior Cavity

| Dimension         | Value    |
|-------------------|----------|
| Width (internal)  | 146mm    |
| Height (internal) | 68mm     |
| Depth (total)     | 16mm     |
| Wall thickness    | 3mm min  |

**Interior layout (front → rear, depth stack):**
```
Front face aluminum:      3mm
Display recess:           3mm (display glass + panel)
Air gap:                  1mm
Button membrane height:   2mm
PCB thickness:            1.5mm
Battery (3300mAh LiPo):   7mm  (75mm × 55mm footprint)
Clearance:                0.5mm
Rear cover aluminum:      3mm
────────────────────────────────
Total:                   22mm ✓
```

---

## Display Window

| Parameter         | Value           |
|-------------------|-----------------|
| Cutout size       | 72mm × 55mm     |
| Position (left)   | 45mm from left  |
| Position (top)    | 9.5mm from top  |
| Inner edge        | C0.3 chamfer    |
| Tolerance         | ±0.05mm         |
| Panel behind      | 3.5" IPS, 79×62mm module sits behind 3mm ledge |

**Note**: Display window position is constrained by PCB ribbon cable reach.
⚠️ VERIFY on sample unit before CNC order. Adjust if needed within ±3mm.

---

## Button Holes — Front Face

All button positions are approximate based on Anbernic RG35XX H layout.
**⚠️ VERIFY ALL POSITIONS on physical sample unit with calipers before cutting.**

### D-Pad (left side)
| Parameter        | Value                              |
|------------------|------------------------------------|
| Shape            | Plus/cross cutout                  |
| Overall span     | 27mm × 27mm (incl. 0.5mm clearance)|
| Arm width        | 9mm                                |
| Center position  | 32mm from left, 44mm from top      |
| Corner radii     | R1.5 on all cross inner corners    |

### Face Buttons A/B/X/Y (right side)
| Button | Center (from left) | Center (from top) | Diameter |
|--------|-------------------|-------------------|----------|
| X      | 133mm             | 28mm              | 8.5mm    |
| B      | 121mm             | 40mm              | 8.5mm    |
| A      | 145mm             | 40mm              | 8.5mm    |
| Y      | 133mm             | 52mm              | 8.5mm    |

Button cluster diamond spacing: 16mm center-to-center
Hole diameter 8.5mm = 8mm cap OD + 0.25mm clearance each side

### Start / Select / Menu
| Button | Center (from left) | Center (from top) | Diameter |
|--------|-------------------|-------------------|----------|
| Start  | 89mm              | 62mm              | 7mm      |
| Select | 103mm             | 62mm              | 7mm      |
| Menu   | 76mm              | 62mm              | 6mm      |

---

## Shoulder Buttons — Top Edge

| Button | Position (from left) | Width | Depth (into top face) |
|--------|---------------------|-------|-----------------------|
| L      | 14mm to 40mm        | 26mm  | 8mm                   |
| R      | 112mm to 138mm      | 26mm  | 8mm                   |

Shoulder buttons are flat oval protrusions (NOT cutouts) formed in the top edge.
Height above top edge plane: 3mm. Radius: R3mm on all edges.

---

## Port Cutouts

**⚠️ ALL PORT POSITIONS must be verified on physical sample unit.**
Positions below are estimated from product photos. Tolerance ±0.5mm acceptable.

### Bottom Edge
| Port        | Center from left | Width | Height |
|-------------|-----------------|-------|--------|
| USB-C       | 76mm            | 9mm   | 3.5mm  |
| 3.5mm audio | 26mm            | —     | ⌀4mm   |

### Top Edge (between shoulder buttons)
| Port/Button  | Center from left | Size         |
|--------------|-----------------|--------------|
| Vol −        | 70mm            | ⌀5mm button  |
| Vol +        | 82mm            | ⌀5mm button  |
| Power/Reset  | 148mm           | ⌀7mm button  |

### Right Side Edge
| Port    | Center from bottom | Width | Height |
|---------|--------------------|-------|--------|
| microSD | 18mm               | 16mm  | 2mm    |

---

## Shell Split Seam

- Front cover meets rear body at horizontal seam
- Seam depth from front face: 10mm
- Mating method: 4× M2 screws (countersunk, rear face)
- Screw locations: 8mm from each corner (centers)
- Alignment: 4× alignment pins, ⌀2mm, 3mm deep (2 on top edge, 2 on bottom)
- Seam gap tolerance: ≤0.05mm (flush, no visible step)

---

## Screw Boss Positions (Interior)

4× M2 threaded brass inserts, heat-set into rear body interior
| Insert | Position (from left) | Position (from top) |
|--------|---------------------|---------------------|
| TL     | 8mm                 | 8mm                 |
| TR     | 144mm               | 8mm                 |
| BL     | 8mm                 | 66mm                |
| BR     | 144mm               | 66mm                |

---

## Rear Face

### Laser Engraving
- Line 1: `OBJECT 001` — centered, 5mm cap height, Helvetica Neue Light / similar
- Line 2: `— XX/20 —` — centered, 3.5mm cap height (XX = unit number, 01–20)
- Position: vertically centered on rear face, slightly above center
- Depth: 0.15mm, anodize-through (mark after anodizing)

### Speaker Grille
- Location: bottom-right corner, 15mm from right, 10mm from bottom
- Pattern: 3×8 grid of ⌀1.5mm holes on 3mm centers = 24 holes total
- Through-hole, deburred

---

## Material & Finish

| Spec             | Value                                               |
|------------------|-----------------------------------------------------|
| Material         | 6061-T6 Aluminum                                    |
| Hardness         | T6 temper (fully hardened, 60 HRB)                 |
| Brushing         | 180-grit linear, horizontal direction (width-wise)  |
| Anodizing        | Type II sulfuric acid, 10µm, clear/silver           |
| Color            | Natural aluminum silver (not dyed)                  |
| Final texture    | Satin — visible grain but not rough                 |

**Brushing must be horizontal only (left-right grain matching device width axis).
No cross-grain, no circular brushing. Grain runs full face continuously.**

---

## Tolerances

| Feature             | Tolerance |
|---------------------|-----------|
| General dimensions  | ±0.1mm    |
| Display window      | ±0.05mm   |
| Button hole diameters | ±0.1mm  |
| Port cutouts        | ±0.1mm    |
| Wall thickness      | ±0.2mm    |
| Seam gap (assembled)| ≤0.05mm   |
| Flatness (any face) | 0.1mm     |

---

## Quantity & Order Sequence

1. **Sample run**: 1 unit (front + rear) for fit verification
2. Fit test on actual Anbernic RG35XX H PCB
3. One revision round if needed
4. **Full run**: 19 remaining units (each numbered individually for engraving)

---

## Open Items (requires physical sample unit measurement)

- [ ] Exact display window position (X/Y center of ribbon cable attachment)
- [ ] Exact button hole positions (measure PCB pad centers)
- [ ] USB-C port center position (measure on PCB)
- [ ] 3.5mm jack position
- [ ] microSD slot position
- [ ] Power/volume button positions
- [ ] Verify interior depth stack (measure actual battery thickness)
- [ ] PCB screw boss positions (reuse or add new mounting points)

**Required tools for measurement**: digital calipers, 0.1mm resolution

---

*OBJECT 001 · Viz · Rev A · 2026-03-06*
