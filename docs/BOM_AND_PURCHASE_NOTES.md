# SkipCore350 BOM and Purchase Notes

This document is the human-readable companion to the spreadsheet BOM.

Use it for purchase source notes, AliExpress/eBay/Amazon/local substitutions, mistakes, and practical comments that do not fit neatly into a spreadsheet cell.

---

## Linked BOM file

Current spreadsheet location in repo:

```text
hardware/SkipCore350_BOM_with_STL_Links.xlsx
```

Keep the spreadsheet as the structured source of truth for quantities, sizes, and links. Use this Markdown file for narrative build notes.

---

## Core architecture summary

```text
Printer: SkipCore350
Motion: CoreXY
Target build volume: 350 x 350 x 350 mm
Frame: 2020 / 2040 aluminium extrusion
Linear rails: MGN12 / MGN12H style
Belts: GT2, 9 mm
Z: triple Z leadscrew system
Controller: BTT Manta M8P v2.0 with CB1
Drivers: TMC2209
Bed: 350 x 350 x 8 mm aluminium tooling plate
Bed heater: 230 VAC silicone heater, around 500 W
Current hotend: E3D Revo Ceramic 24 V 60 W
Alternate/planned hotend: Rapido 2 UHF PT1000
Extruder: HGX Lite 2.0 style, direct drive/Bowden path depending on current build stage
Probe: BLTouch
```

---

## Purchase-source categories

Use these sections to record where each major component came from and whether it was a good purchase.

### AliExpress

| Item | Supplier/store | Link | Qty | Status | Notes |
|---|---|---|---:|---|---|
| 9 mm GT2 belts | | | | | |
| Idlers/pulleys | | | | | |
| MGN12 rails | | | | | |
| TMC2209 drivers | | | | | |
| HGX Lite extruder | | | | | |
| Fans | | | | | |
| Cable chain | | | | | |
| Fasteners | | | | | |

### eBay

| Item | Seller | Link | Qty | Status | Notes |
|---|---|---|---:|---|---|
| | | | | | |

### Amazon

| Item | Seller | Link | Qty | Status | Notes |
|---|---|---|---:|---|---|
| | | | | | |

### Local / Australian suppliers

| Item | Supplier | Link | Qty | Status | Notes |
|---|---|---|---:|---|---|
| Aluminium bed plate | | | | | |
| AC silicone heater | | | | | |
| Thermal fuse | | | | | |
| Wiring / ferrules / terminals | | | | | |
| Fasteners | | | | | |

---

## Parts to verify before public recommendation

- [ ] Exact Manta M8P v2.0 source.
- [ ] Exact CB1 source.
- [ ] Exact rail lengths.
- [ ] Exact belt length and pitch.
- [ ] Exact idler/pulley tooth and bore details.
- [ ] Exact AC bed heater wattage and supplier.
- [ ] Exact bed thermistor type.
- [ ] Exact SSR model and rating.
- [ ] Exact fans and voltage.
- [ ] Exact extruder model and gear ratio.
- [ ] Exact hotend version and sensor.

---

## Good purchase / bad purchase log

### Good purchases

| Item | Why it was good | Would buy again? |
|---|---|---|
| | | |

### Problem purchases

| Item | Problem | Workaround / replacement |
|---|---|---|
| | | |

---

## Notes on substitutions

When documenting alternatives, include:

```text
Original intended part:
Actual purchased part:
Reason for substitution:
Mechanical impact:
Firmware/config impact:
STL/CAD impact:
Would recommend to another builder: yes/no
```

---

## Open BOM tasks

- [ ] Link each STL to the matching BOM row where practical.
- [ ] Mark parts as purchased / printed / installed / replaced.
- [ ] Add source links for AliExpress, eBay, Amazon, and local suppliers.
- [ ] Add notes for parts that needed modification.
- [ ] Add a final “known-good build” BOM once commissioning is complete.
