# SkipCore350 Commissioning and Print/Test Sequence

Repo target: `SkipHokin/SkipCore350`  
Printer: SkipCore350 CoreXY, BTT Manta M8P v2 + CB1, Klipper  
Coordinate model: rear-right home, `X0 Y0` at rear-right, printable space positive: `X 0..340`, `Y 0..340`
Probe: BLTouch, `X -38`, `Y 2`  
Nozzle: 0.4 mm

> Status: this file is a working commissioning runbook. Tick the boxes as each gate is completed and add notes under each section.

---

## Gate 0 — Safety snapshot

- [X] Backup current `printer.cfg`
- [X] Backup all included `.cfg` files
- [X] Backup Orca profile
- [X] Take photos of wiring and board connections
- [X] Confirm 24 V and mains wiring are mechanically secure
- [X] Confirm bed earth/grounding where applicable

Notes:

```text

```

---

## Gate 1 — Static electrical checks

Do not move motors yet.

- [X] Confirm emergency stop works
- [X] Confirm hotend temperature reads room temperature
- [X] Confirm bed temperature reads room temperature
- [X] Confirm CB1/M8P status is normal
- [X] Confirm no heater is unexpectedly on
- [X] Confirm BLTouch self-test on startup

Useful commands:

```gcode
M112
FIRMWARE_RESTART
STATUS
```

Notes:

```text

```

---

## Gate 2 — Endstops and BLTouch checks

Move the toolhead by hand away from all endstops.

```gcode
QUERY_ENDSTOPS
BLTOUCH_DEBUG COMMAND=pin_down
QUERY_PROBE
BLTOUCH_DEBUG COMMAND=pin_up
QUERY_PROBE
```

Expected:

- [X] X endstop reports open when clear and TRIGGERED when pressed
- [X] Y endstop reports open when clear and TRIGGERED when pressed
- [X] BLTouch reports open when pin down
- [X] BLTouch reports TRIGGERED when pin is gently pushed up

Notes:

```text

```

---

## Gate 3 — Motor direction and tiny moves

Toolhead roughly in the middle by hand. Use small moves only.

```gcode
STEPPER_BUZZ STEPPER=stepper_x
STEPPER_BUZZ STEPPER=stepper_y
STEPPER_BUZZ STEPPER=stepper_z
STEPPER_BUZZ STEPPER=stepper_z1
STEPPER_BUZZ STEPPER=stepper_z2
```

Then:

```gcode
G91
G1 X-10 F1200
G1 X10 F1200
G1 Y-10 F1200
G1 Y10 F1200
G90
```

Expected for this coordinate model:

- [X] `X-10` moves left
- [X] `X10` moves right
- [X] `Y-10` moves toward the front
- [X] `Y10` moves toward the rear
- [X] Z motors all move the same direction
- [X] No binding, grinding, crossed CoreXY motion, or cable-chain issue

Notes:

```text

```

---

## Gate 4 — Homing

Start with XY only.

```gcode
G28 X
G28 Y
G1 X-50 Y-50 F3000
```

For BLTouch centred over the bed, safe Z home nozzle position is approximately:

```ini
[safe_z_home]
home_xy_position: -137, -177
z_hop: 10
z_hop_speed: 5
speed: 80
```

Calculation: probe centre target `X-175 Y-175`; nozzle = probe target minus probe offset = `-175 - (-38)`, `-175 - 2` = `X-137 Y-177`.

Then:

```gcode
G28 Z
```

- [X] X homes to right/rear-right side as expected
- [X] Y homes to rear
- [X] Final XY after homing is `X0 Y0`
- [X] Z homes using BLTouch without nozzle crash

Notes:

```text

```

---

## Gate 5 — Travel limit validation

Do not immediately use the full 350 mm. Walk up to it.

```gcode
G1 Z20 F600
G1 X-50 Y-50 F3000
G1 X-300 Y-50 F3000
G1 X-300 Y-300 F3000
G1 X-50 Y-300 F3000
G1 X-50 Y-50 F3000
```

Then expand carefully:

```gcode
G1 X330 Y330 F3000
```

- [X] Belt paths clear
- [X] Cable chains clear
- [X] BLTouch clears belts and frame
- [X] Toolhead clears frame extremes
- [X] True available X travel recorded
- [X] True available Y travel recorded

Measured travel:

```text
X travel: 340
Y travel: 330
Z travel: 300
```

Notes:

```text

```

---

## Gate 6 — Probe Z offset and repeatability

```gcode
G28
PROBE_CALIBRATE
```

During calibration:

```gcode
TESTZ Z=-0.1
TESTZ Z=0.05
ACCEPT
SAVE_CONFIG
```

Then:

```gcode
G28
PROBE_ACCURACY
```

Targets:

- [ ] Probe range under 0.02 mm: excellent
- [ ] Probe range under 0.05 mm: usable
- [ ] Over 0.05 mm: investigate probe mount, pin, wiring, bed movement

Recorded probe accuracy:

```text
samples:
range:
standard deviation:
```

Notes:

```text

```

---

## Gate 7 — Z tilt

```gcode
G28
Z_TILT_ADJUST
G28 Z
Z_TILT_ADJUST
```

- [ ] First run completes
- [ ] Second run makes only a tiny correction
- [ ] Bed is not chasing itself up/down repeatedly

Notes:

```text

```

---

## Gate 8 — Conservative bed mesh

Starting conservative mesh:

```ini
[bed_mesh]
speed: 120
horizontal_move_z: 8
mesh_min: -300, -300
mesh_max: -60, -30
probe_count: 5,5
algorithm: bicubic
```

Run:

```gcode
G28
Z_TILT_ADJUST
G28 Z
BED_MESH_CALIBRATE
SAVE_CONFIG
```

- [ ] Mesh completes without out-of-range moves
- [ ] BLTouch stays over bed for all probe points
- [ ] Mesh looks plausible, not wild or sloped beyond mechanical expectation

Notes:

```text

```

---

## Gate 9 — Hotend and bed temperature stability

Temperature challenge history to document:

- Earlier fault: `Extruder not heating at expected rate` around 40–42 °C
- 24 V was measured
- Heater cartridge and/or thermistor were replaced/checked
- Later heating appeared OK
- Fan mapping and heatbreak fan behaviour need to be confirmed before long prints

Checks:

```gcode
PID_CALIBRATE HEATER=extruder TARGET=220
SAVE_CONFIG
PID_CALIBRATE HEATER=heater_bed TARGET=60
SAVE_CONFIG
```

- [ ] Hotend heats from room temp to 220 °C normally
- [ ] No heater rate fault
- [ ] Hotend holds stable after PID tune
- [ ] Bed heats to 60 °C normally
- [ ] Bed holds stable after PID tune
- [ ] Heatbreak fan comes on at correct temperature
- [ ] Part fans stay off unless requested

Notes:

```text

```

---

## Gate 10 — Extruder rotation distance

Heat to printing temperature:

```gcode
M109 S220
```

Mark filament 120 mm above extruder entry, then:

```gcode
G91
G1 E100 F60
G90
```

Formula:

```text
new_rotation_distance = old_rotation_distance × actual_extruded / requested_extruded
```

- [ ] 100 mm command gives 99–101 mm actual
- [ ] No skipping
- [ ] No grinding filament
- [ ] Hotend flow seems normal

Recorded result:

```text
old rotation_distance:
requested extrusion:
actual extrusion:
new rotation_distance:
```

Notes:

```text

```

---

# Print and STL commissioning sequence

This section is the suggested print/tune order after the mechanical/electrical gates above.

## Print 1 — First-layer square / squaring plane

Purpose: confirm Z offset, mesh, extrusion, and bed adhesion before wasting time on cubes.

Suggested model:

- Single-layer square, 100 x 100 mm initially
- Then 250 x 250 mm or larger once safe
- 0.20 mm first layer
- PLA first if available

Settings:

```text
Layer height: 0.20 mm
First layer: 0.20 mm
Speed: slow, 20–30 mm/s first layer
Bed: PLA 55–60 °C
Nozzle: PLA 200–215 °C
Fan: off for first layer, normal after
```

Pass:

- [ ] Lines touch neatly
- [ ] No ploughing
- [ ] No round loose strings
- [ ] Same first-layer quality across the tested area

Notes:

```text

```

---

## Print 2 — Calibration cube

Purpose: basic dimensional sanity, extrusion consistency, and axis behaviour.

Suggested model:

- 20 mm XYZ cube
- 2–3 walls
- 15–20% infill
- 0.20 mm layers

Pass:

- [ ] No layer shift
- [ ] X and Y dimensions plausible
- [ ] Z height plausible
- [ ] Corners not wildly bulged
- [ ] Top surface acceptable

Measurements:

```text
X:
Y:
Z:
Notes:
```

---

## Print 3 — Larger squareness / gantry check plane

Purpose: check skew, square, belt tension, and motion over a larger area.

Suggested models:

- 200 x 200 mm square outline
- 250 x 250 mm diagonal cross
- Thin rectangular frame

Check:

- [ ] Diagonals match
- [ ] Corners are square
- [ ] No obvious CoreXY racking
- [ ] No belt tooth artefacts or missed steps

Measurements:

```text
Front-left to rear-right diagonal:
Front-right to rear-left diagonal:
Difference:
```

---

## Print 4 — Flow test

Purpose: tune extrusion multiplier/flow before pressure advance.

Suggested approach:

- Orca Slicer flow calibration
- Or single-wall cube if preferred

Pass:

- [ ] Wall thickness sensible
- [ ] Top infill not overstuffed
- [ ] No under-extruded gaps

Recorded flow:

```text
Material:
Temperature:
Flow / extrusion multiplier:
```

---

## Print 5 — Pressure Advance tower

Purpose: tune corners and acceleration pressure response.

Prerequisites:

- Flow roughly correct
- Extruder rotation distance correct
- Hotend temperature stable
- No major mechanical problems

Suggested:

- Orca pressure advance test
- Start conservative; do not chase speed yet

Pass:

- [ ] Corners sharpen without under-extruding
- [ ] No severe gaps after corners
- [ ] Value recorded in Klipper or slicer profile

Recorded PA:

```text
Material:
Nozzle:
Temperature:
Speed:
PA value:
```

---

## Print 6 — Temperature tower

Purpose: find useful temperature range for the actual hotend/material combo.

Suggested:

- PLA tower first
- Then PETG/ABS/ASA later

Check:

- [ ] Layer bonding
- [ ] Stringing
- [ ] Bridging
- [ ] Overhangs
- [ ] Surface finish

Recorded result:

```text
Material:
Brand:
Best temperature:
Acceptable range:
Notes:
```

---

## Print 7 — Speed / heat / volumetric flow test

Purpose: find practical flow limit of hotend/extruder before input shaping heroics.

Suggested:

- Orca max volumetric speed test
- Or stepped speed tower

Pass:

- [ ] No extruder skipping
- [ ] No sudden matte/under-extruded sections
- [ ] No heat creep
- [ ] No layer shifts

Recorded result:

```text
Material:
Nozzle:
Layer height:
Line width:
Max reliable volumetric flow:
Max useful print speed:
```

---

## Print 8 — Input shaper / accelerometer workflow

Hardware note:

- Accelerometer to be mounted rigidly to the toolhead.
- Process may be run through BTT Pad 7 if that is where the accelerometer tooling is available.
- Results can later be transferred into the CB1 Klipper config.

Before test:

- [ ] Find accelerometer
- [ ] Mount firmly to toolhead/head plate
- [ ] Confirm orientation
- [ ] Confirm wiring/USB/SPI method
- [ ] Confirm Pad 7 can communicate with accelerometer

Run resonance tests when ready:

```gcode
SHAPER_CALIBRATE AXIS=X
SHAPER_CALIBRATE AXIS=Y
SAVE_CONFIG
```

Record:

```text
X recommended shaper:
X frequency:
Y recommended shaper:
Y frequency:
Acceleration limit recommendation:
Where results were generated: BTT Pad 7 / CB1 / other
Date:
```

Pass:

- [ ] Graphs/results captured
- [ ] Values transferred to CB1 config if generated elsewhere
- [ ] Test cube after shaping shows reduced ringing

---

## Print 9 — Real-world validation prints

Only after gates and tuning prints:

- [ ] Functional bracket
- [ ] Longer print, 2–3 hours
- [ ] Larger bed-area print
- [ ] Higher-temperature material test if enclosure is ready
- [ ] Repeatable start/end macro behaviour

Notes:

```text

```

---

# Known configuration anchors

## Fan mapping candidate

```text
FAN0 PF7 → part cooling 24 V
FAN1 PF9 → heatbreak temp-controlled 24 V
FAN2 PF6 → 12 V case always-on
FAN3 PF8 → 24 V case always-on
```

## Known/current printer facts

```text
Printer: SkipCore350
Controller: BTT Manta M8P v2 + CB1
Drivers: TMC2209
Motion: CoreXY, 9 mm GT2 belts
Bed: 350 x 350 x 8 mm aluminium, 230 VAC 500 W silicone heater
Hotend: E3D Revo Ceramic currently noted; Rapido 2 UHF considered
Extruder: HGX Lite 2.0 / Moons NEMA14, gear ratio 19:2, rotation_distance around 7.5 earlier
Probe: BLTouch, X -38, Y 2
Coordinate model: rear-right home, negative printable X/Y space
```

---

# Running log

| Date | Gate/Test | Result | Notes |
|---|---|---|---|
| | | | |
