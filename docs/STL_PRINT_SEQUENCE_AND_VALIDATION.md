# SkipCore350 STL Print Sequence and Validation

This document defines the practical print-test sequence for commissioning SkipCore350.

The aim is not to print a Benchy first. The aim is to validate one system at a time: first layer, XY squareness, extrusion, pressure advance, temperature stability, flow limit, then input shaping.

---

## Test order summary

1. First-layer square / squaring plane.
2. Calibration cube.
3. Larger squareness plane.
4. Flow calibration.
5. Pressure Advance tower.
6. Temperature tower.
7. Speed / heat / volumetric flow test.
8. Accelerometer / input shaper testing.
9. Functional printer part.
10. Cosmetic benchmark print.

---

## General starting profile

Use conservative slicer settings until the machine proves itself.

```text
Nozzle: 0.4 mm
Layer height: 0.20 mm
Material: PLA or PLA+
Bed: 60 °C typical starting point
Hotend: 200–220 °C depending on filament
Speed: 40–50 mm/s for first tests
Acceleration: conservative
Part fan: limited, especially with Revo Ceramic and dual 5010 fans
Pressure Advance: off or baseline until PA test
Input Shaper: off or conservative until accelerometer test
```

---

## 1. First-layer square / squaring plane

Purpose:

- Validate Z offset.
- Validate bed mesh compensation.
- Validate extrusion starts cleanly.
- Check if nozzle is too high/low.
- Check if the machine can lay down a simple continuous first layer.

Suggested part:

```text
Single-layer square, 100 x 100 mm or 150 x 150 mm
0.20 mm layer height
2–4 perimeter outline optional
```

Record:

```text
Date:
Material:
Nozzle temp:
Bed temp:
Z offset:
Bed mesh active: yes/no
Result:
Comments:
```

Pass condition:

- Lines touch without ploughing.
- No gaps between adjacent lines.
- Corners remain stuck.
- No obvious mesh compensation error.

---

## 2. Calibration cube

Purpose:

- Confirm basic extrusion and motion.
- Check X/Y/Z dimensions.
- Check layer consistency.
- Check ringing before fast tuning.

Suggested part:

```text
20 mm cube
0.20 mm layers
2–3 walls
15–20% infill
moderate speed
```

Measurements:

| Axis | Target | Measured | Error | Notes |
|---|---:|---:|---:|---|
| X | 20.00 mm | | | |
| Y | 20.00 mm | | | |
| Z | 20.00 mm | | | |

Pass condition:

- No layer shift.
- No obvious under-extrusion.
- Dimensions are close enough for early commissioning.
- Corners give clues for PA, but do not tune everything from the first cube.

---

## 3. Larger squareness / diagonal plane

Purpose:

- Check XY squareness over a bigger area.
- Check if CoreXY belt path or frame alignment is skewed.
- Check useful bed area before large prints.

Suggested part:

```text
Large thin square or rectangle, e.g. 200 x 200 mm or 250 x 250 mm
1–2 layers
Add diagonal or corner markers if useful
```

Measurements:

```text
Front-left to rear-right diagonal:
Front-right to rear-left diagonal:
Difference:
Notes:
```

Pass condition:

- Diagonals are close.
- Corners remain adhered.
- No obvious bed mesh edge problems.

---

## 4. Flow calibration

Purpose:

- Set slicer flow/extrusion multiplier after extruder rotation distance is already correct.

Do not use flow compensation to hide incorrect extruder rotation distance.

Record:

```text
Date:
Material:
Extruder rotation distance:
Slicer flow before:
Slicer flow after:
Test method:
Result:
```

---

## 5. Pressure Advance tower

Purpose:

- Tune corner quality and pressure response.
- Reduce bulging and corner blobbing.

Suggested order:

1. Confirm extruder rotation distance.
2. Confirm reasonable first layer.
3. Confirm flow.
4. Run PA tower.

Record:

```text
Date:
Material:
Nozzle:
Layer height:
Speed:
PA test range:
Best PA value:
Config updated: yes/no
Notes:
```

Known reference from earlier machines:

```text
Ender 5 Pro pressure advance reference was around 0.122.
SkipCore early tests may land elsewhere depending on extruder, Bowden/direct path, hotend, and filament.
```

Pass condition:

- Corners sharper without under-extruded gaps.
- PA value is recorded in config or slicer notes.

---

## 6. Temperature tower

Purpose:

- Find the best print temperature for a specific filament and hotend.
- Check bridging, surface, layer adhesion, stringing, and hotend stability.

Record:

| Material | Brand | Colour | Temp range | Best temp | Notes |
|---|---|---|---|---:|---|
| | | | | | |

Pass condition:

- Hotend holds temperature during fan changes.
- Chosen temperature balances strength and print quality.

---

## 7. Speed / heat / volumetric flow test

Purpose:

- Find the useful speed limit for the current hotend/extruder/material combination.
- Separate motion limits from hotend melt-flow limits.

Watch for:

- Under-extrusion at high speed.
- Extruder clicking/skipping.
- Weak layer bonding.
- Temperature drop during fast sections.
- Heat creep.
- Fan-induced hotend faults.

Record:

```text
Date:
Hotend:
Extruder:
Material:
Nozzle:
Layer height:
Line width:
Max reliable volumetric flow:
Max practical print speed:
Failure mode:
Notes:
```

---

## 8. Accelerometer / input shaper

Purpose:

- Measure X/Y resonances.
- Select input shaper and safe acceleration.

Current plan:

- Find accelerometer.
- Mount it rigidly to the head/toolhead.
- BTT Pad 7 can be used for the test process if it is easier.
- Transfer the final shaper values to the CB1 Klipper config.

Record:

```text
Date:
Accelerometer:
Mounted where:
Test host: BTT Pad 7 / CB1 / other
X recommended shaper:
X frequency:
Y recommended shaper:
Y frequency:
Recommended max acceleration:
Values copied to CB1 config: yes/no
Notes:
```

Pass condition:

- Accelerometer mounted solidly.
- Resonance graphs generated successfully.
- Config values recorded and committed.
- Print confirms ringing improvement.

---

## 9. Functional printer part

Purpose:

- Validate that the printer can produce useful parts, not just tuning artifacts.

Suggested first functional parts:

- Small bracket.
- Cable clip.
- Fan duct revision.
- Webcam cradle piece.
- Belt clamp spare.

Record:

```text
Part:
STL path:
Material:
Print settings:
Fit result:
Changes needed:
```

---

## 10. Cosmetic benchmark print

Only after the boring engineering tests pass.

Candidate:

- Benchy.
- Overhang/bridge test.
- Orca calibration model.

Record:

```text
Model:
Material:
Speed:
Acceleration:
PA:
Input shaper:
Cooling:
Result:
Photos:
```

---

## Print validation log

| Date | Test | Material | Key settings | Result | Next action |
|---|---|---|---|---|---|
| | First-layer square | | | | |
| | Cube | | | | |
| | PA tower | | | | |
| | Temp tower | | | | |
| | Speed test | | | | |
| | Input shaper | | | | |
