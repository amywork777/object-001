# OBJECT 001 — Build Plan v1
_Authored: 2026-03-06T01:37:00Z_
_Status: Pre-manufacture reference document_

---

## ⚠️ Compatibility Issues Found & Resolved

The original cart had 6 problems. All fixed in the revised BOM below.

| # | Issue | Fix |
|---|-------|-----|
| 1 | DPI display uses 18+ GPIO pins — not enough left for buttons | **Replace** with 2.4" SPI ILI9341 (uses 6 GPIO) |
| 2 | DPI display not listed as Pi Zero 2W compatible | SPI ILI9341 is proven on Pi Zero 2W |
| 3 | TP4056 outputs 3.7–4.2V, Pi Zero 2W needs 5V | **Add** MT3608 5V boost converter |
| 4 | Battery (95×65mm) too wide for 65mm shell interior | **Replace** with 803060 60mm-wide cell; **widen shell to 75mm** |
| 5 | No audio components | **Add** MAX98357A I2S DAC + 1W speaker |
| 6 | Pi Zero 2W has no pre-soldered GPIO header | **Add** 2×20 pin header (solder during assembly) |

---

## Final Verified BOM (20 units)

### Off-Shelf (Amazon/Adafruit)

| Component | Part | Spec | Source | Qty (×20) | Unit Cost |
|-----------|------|------|--------|-----------|-----------|
| Compute | Raspberry Pi Zero 2W | BCM2710A1, 512MB, WiFi/BT | Amazon B09LH5SBPS | 20 | $15 |
| Display | Waveshare 2.4" SPI LCD | ILI9341, 320×240, SPI | Amazon B074V7BXK5 | 20 | $14 |
| Battery | 3.7V 2000mAh LiPo | 803060, 60×30×8mm, JST PH2 | Aliexpress | 20 | $5 |
| Charger | TP4056 USB-C module | 5V in, 1A charge, protection | Amazon B0C3LB3JSZ | 20 (1 pack) | $2 |
| Boost converter | MT3608 5V module | 2–24V in → 5V out, 2A | Amazon | 20 | $1 |
| I2S DAC | MAX98357A breakout | 3W, I2S, 3.3V | Adafruit #3006 | 20 | $5 |
| Speaker | 1W 8Ω mini speaker | 28mm round | Adafruit #1314 | 20 | $2 |
| GPIO header | 2×20 pin 2.54mm | Male, for Pi Zero 2W | Amazon | 20 | $0.50 |
| microSD | 32GB Class 10 | For RetroPie OS | Amazon | 20 | $6 |
| Tactile buttons | 6mm tactile switch | 10 per unit (d-pad+face+menu) | Amazon (pack) | 200 | $0.20 |
| Misc | Wires, resistors, standoffs | M2 screws, 10kΩ resistors | Amazon | 1 lot | $20 |

**Cart subtotal (off-shelf): ~$960**

### Custom (Quotes pending)

| Component | Spec | Vendor | Est. Cost (×20) |
|-----------|------|--------|-----------------|
| CNC shell front | 6061-T6 Al, 125×75×10mm, brushed + anodized | PCBWay/Fictiv/Xometry | $350 |
| CNC shell rear | 6061-T6 Al, 125×75×10mm, battery door | PCBWay/Fictiv/Xometry | $250 |
| Laser engraving | "OBJECT 001 — XX/20" rear panel, unique per unit | PCBWay add-on | $60 |
| Burgundy buttons | ABS, pre-colored, D-pad + 4 face + 2 small | Aliexpress | $40 |

**Custom subtotal: ~$700**

**Grand total: ~$1,660 for 20 units ($83/unit)**

---

## Physical Fit Verification

```
Shell interior (125×75×18mm assembled, 2mm walls):
  Internal: 121mm × 71mm × 14mm usable depth

Component footprints:
  Pi Zero 2W:          65mm × 30mm × 5mm  ✓ fits
  2.4" SPI display:    60mm × 42mm × 3mm  ✓ fits  
  Battery (803060):    60mm × 30mm × 8mm  ✓ fits
  TP4056 module:       26mm × 17mm × 3mm  ✓ fits
  MT3608 module:       23mm × 12mm × 4mm  ✓ fits
  MAX98357A:           18mm × 18mm × 3mm  ✓ fits
  Speaker (28mm):      28mm diameter       ✓ fits in rear cutout

Layout (top view, front shell):
  ┌─────────────────────────────────┐
  │  [DISPLAY 60×42]   [speaker]   │
  │                                 │
  │  [D-PAD]    [Pi Zero 2W]  [AB] │
  │            [battery below]      │
  │  [SELECT]     [USB-C]  [START] │
  └─────────────────────────────────┘
  
Depth stack (rear to front):
  Rear shell (2mm) + battery (8mm) + PCB/Pi (5mm) + display (3mm) + front glass (2mm) = 20mm
  → Spec shell to 20mm depth (revised from 15mm)
```

---

## Power Architecture

```
USB-C port (external)
      │
      ▼
  TP4056 module ──── charges ────▶ LiPo battery (3.7V 2000mAh)
                                         │
                                         ▼
                                  MT3608 boost converter
                                  (3.7–4.2V → 5.1V regulated)
                                         │
                                         ▼
                              Pi Zero 2W (5V via GPIO pin 2)
                                         │
                              Pi 3.3V regulator
                                         │
                              ▼          ▼          ▼
                           Display   MAX98357A   Buttons
                           (3.3V)    (3.3V)      (pull-ups)
```

**Power notes:**
- Pi Zero 2W is powered via 5V GPIO pin (pin 2), bypassing USB port
- Max current draw at full load: Pi ~350mA + display ~50mA + audio ~200mA = ~600mA
- MT3608 rated at 2A continuous — sufficient ✓
- Battery life: 2000mAh / 600mA = ~3.3 hours gaming

---

## GPIO Pinout

| GPIO | BCM | Function | Connected To |
|------|-----|----------|-------------|
| 2 | — | 5V power | MT3608 output |
| 6 | — | GND | Common ground |
| 19 | 10 | SPI0_MOSI | Display MOSI |
| 23 | 11 | SPI0_SCLK | Display CLK |
| 24 | 8 | SPI0_CE0 | Display CS |
| 11 | 17 | GPIO17 | D-pad UP |
| 13 | 27 | GPIO27 | D-pad DOWN |
| 15 | 22 | GPIO22 | D-pad LEFT |
| 16 | 23 | GPIO23 | D-pad RIGHT |
| 29 | 5 | GPIO5 | Button A |
| 31 | 6 | GPIO6 | Button B |
| 33 | 13 | GPIO13 | START |
| 37 | 26 | GPIO26 | SELECT |
| 36 | 16 | GPIO16 | MENU |
| 18 | 24 | GPIO24 | Display DC |
| 22 | 25 | GPIO25 | Display RST |
| 32 | 12 | GPIO12 | Display backlight (PWM) |
| 12 | 18 | PCM_CLK | I2S BCLK → MAX98357A |
| 35 | 19 | PCM_FS | I2S LRCLK → MAX98357A |
| 38 | 20 | PCM_DIN | I2S DATA → MAX98357A |

All button inputs use Pi's internal pull-up resistors (no external resistors needed).

---

## Assembly Sequence

### Stage 1 — Prep Components (Day 1, ~2 hours for all 20)
1. Flash RetroPie to all 20 microSD cards (use Balena Etcher, flash all simultaneously via USB hub)
2. Solder 40-pin headers onto all 20 Pi Zero 2W boards
3. Solder JST PH2.0 connector onto each TP4056 module (battery lead)
4. Test each Pi: insert SD, connect micro-USB, verify boot

### Stage 2 — Subassembly (Day 1–2, ~30 min per unit)
5. Wire MT3608 → Pi GPIO 5V pin (pin 2) and GND (pin 6)
6. Set MT3608 output to exactly 5.1V (adjust trim pot with multimeter)
7. Wire TP4056 battery out → MT3608 input
8. Wire battery to TP4056 battery terminals
9. Solder display to Pi GPIO per pinout table above
10. Wire MAX98357A I2S pins + speaker leads

### Stage 3 — Button Matrix (Day 2, ~20 min per unit)
11. Place 10 tactile switches in shell button positions
12. Wire each to GPIO per pinout table (common GND rail)
13. Install burgundy ABS button caps over tactile switches

### Stage 4 — Shell Integration (Day 2, ~20 min per unit)
14. Mount display into front shell window (adhesive foam tape seal)
15. Secure Pi + power board stack with M2 standoffs
16. Lay battery flat in rear of shell
17. Route USB-C charging port through shell cutout
18. Test full power cycle before closing shell
19. Close shell with M2 screws (4× corners)

### Stage 5 — Software + QC (Day 3, ~15 min per unit)
20. Boot RetroPie, configure button mapping (runcommand + retroarch)
21. Load sample ROM set (verify NES, SNES, GBA all run)
22. Engrave serial number (if not done by CNC vendor) or apply numbered label
23. QC checklist: display on, audio on, all buttons respond, USB-C charges, battery holds

### Stage 6 — Pack & Number (Day 3, ~5 min per unit)
24. Place in numbered kraft box (01/20 through 20/20)
25. Include design lineage card (AI prompt → Vizcom render → physical device)
26. Seal

---

## Software Setup (RetroPie)

```bash
# Flash to microSD (run on each card)
# Download: https://retropie.org.uk/download/

# After first boot — configure display driver for ILI9341 SPI:
# Add to /boot/config.txt:
dtparam=spi=on
dtoverlay=ili9341,speed=64000000,fps=30,bgr=1

# Configure audio (I2S MAX98357A):
dtoverlay=hifiberry-dac

# GPIO button mapping via mk_arcadejoystick_rpi or RetroFlag GPIOnext
# Map: BCM 17,27,22,23 = UP,DOWN,LEFT,RIGHT | 5,6 = A,B | 13,26 = START,SELECT
```

---

## Risk Register

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| ILI9341 driver incompatibility with Pi Zero 2W + RetroPie | Low | Proven in 50+ DIY builds; fbcp-ili9341 driver well documented |
| MT3608 voltage drift under load → Pi undervoltage | Medium | Set to 5.15V (headroom); add 100µF capacitor on output |
| Battery too thick once in shell | Low | 803060 = 8mm thick; shell depth revised to 20mm |
| CNC tolerances off on first sample | Medium | Order 1 sample unit before full 20-unit run |
| Pi Zero 2W purchase limit (5/order on Amazon) | High | Order from 4 vendors: Adafruit, Pimoroni, CanaKit + Amazon |

---

## What Still Needs to Happen

- [ ] Update Amazon cart: swap DPI display → ILI9341 SPI, add MT3608, MAX98357A, speaker, header, SD cards
- [ ] Update CNC quote emails: revise shell dimensions to 125×75×20mm
- [ ] Order 1 CNC shell sample before committing to full run
- [ ] Lock GPIO header + PCB breakout design
- [ ] Approve spend proposal → trigger manufacture step
