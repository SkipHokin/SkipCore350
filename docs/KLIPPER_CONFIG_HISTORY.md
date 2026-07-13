# SkipCore350 Klipper Config History

This document records important Klipper configuration decisions and changes.

The actual config files remain the source of truth. This file explains why values were chosen, what was tested, and what should not be changed casually.

---

## Machine identity

```text
Printer: SkipCore350
Controller: BTT Manta M8P v2.0
Host: onboard CB1
Firmware: Klipper
Kinematics: CoreXY
Home position: rear-right
Coordinate system: rear-right is X0 Y0
Printable space: negative X and negative Y from home
Bed size: 350 x 350 mm
Nozzle: 0.4 mm during early commissioning
```

---

## Coordinate convention

Rear-right is home and is treated as X0 Y0.

```text
Rear-left          Rear-right / home
X-350 Y0          X0 Y0

Front-left        Front-right
X-350 Y-350       X0 Y-350
```

Centre nozzle position:

```text
X-175 Y-175
```

---

## Probe / BLTouch

Current known BLTouch offset:

```ini
x_offset: -38
y_offset: 2
```

This means the probe is 38 mm left of the nozzle and 2 mm behind/positive-Y of the nozzle under the current coordinate convention.

Probe-centred safe-home nozzle position for bed centre:

```text
Probe target: X-175 Y-175
Nozzle X = -175 - (-38) = -137
Nozzle Y = -175 - 2 = -177
Suggested safe_z_home: X-137 Y-177
```

Candidate config:

```ini
[safe_z_home]
home_xy_position: -137, -177
z_hop: 10
z_hop_speed: 5
speed: 80
```

Validation:

- [ ] Confirm BLTouch triggers correctly using `QUERY_PROBE`.
- [ ] Confirm safe Z home places probe over bed centre.
- [ ] Confirm no nozzle/bed collision.
- [ ] Confirm probe repeatability using `PROBE_ACCURACY`.

---

## Endstops

Known convention:

```text
X homes to the right.
Y homes to the rear.
Home is rear-right.
```

Validation:

```gcode
QUERY_ENDSTOPS
```

Expected when not triggered:

```text
x: open
y: open
z/probe: open
```

Record:

```text
Date:
X endstop state:
Y endstop state:
Probe state:
Fixes needed:
```

---

## Motor direction and CoreXY validation

Small relative move test after stepper buzz:

```gcode
G91
G1 X-10 F1200
G1 X10 F1200
G1 Y-10 F1200
G1 Y10 F1200
G90
```

Expected:

```text
X-10 = left
X10  = right
Y-10 = front
Y10  = rear
```

Record:

```text
Date:
X move correct: yes/no
Y move correct: yes/no
CoreXY crossed behaviour: yes/no
Fix:
```

---

## Z system

Known design notes:

- Triple Z leadscrew system.
- Z-tilt is part of commissioning.
- Z bracket orientation was improved by flipping the bracket, gaining about 40 mm additional Z travel.

Record final Z configuration:

```text
Lead screw type:
Stepper count:
Driver current:
Microsteps:
Rotation distance:
Z max travel:
Z tilt points:
```

---

## Bed mesh

Because the probe has an X offset of -38, the reachable probe area is smaller than the nozzle travel area.

Conservative starting mesh:

```ini
[bed_mesh]
speed: 120
horizontal_move_z: 8
mesh_min: -300, -300
mesh_max: -60, -30
probe_count: 5,5
algorithm: bicubic
```

Expand only after proving motion limits and probe reach.

Mesh record:

```text
Date:
mesh_min:
mesh_max:
probe_count:
algorithm:
mesh result:
edge issues:
```

---

## Extruder

Known notes:

- HGX Lite 2.0 style extruder.
- Gear ratio reference: 19:2 / 9.5:1.
- Earlier corrected extrusion reference indicated rotation distance around 7.5, but this must be confirmed on the actual current build.

Calibration formula:

```text
new_rotation_distance = old_rotation_distance x actual_extruded / requested_extruded
```

Record:

```text
Date:
Old rotation distance:
Requested extrusion:
Actual extrusion:
New rotation distance:
Saved: yes/no
```

---

## Fans

Known notes:

- FAN0 likely hotend fan.
- FAN1 likely part cooling fan.
- Dual 5010 part cooling should be limited during Revo Ceramic testing.

Final mapping:

```text
FAN0:
FAN1:
FAN2:
Other:
```

Validation:

```text
Date:
Command used:
Observed fan:
Correct mapping: yes/no
```

---

## Temperature config

Record final confirmed sensor and heater settings:

```text
Hotend sensor type:
Hotend pin:
Hotend PID:
Bed sensor type:
Bed pin:
Bed heater pin/SSR:
Bed PID:
Max temp limits:
Thermal safety notes:
```

---

## Pressure Advance

Record tuned values by material and toolhead state:

| Date | Material | Extruder path | Hotend | PA value | Notes |
|---|---|---|---|---:|---|
| | | | | | |

---

## Input Shaper

Record final values after accelerometer testing:

```text
Date:
Accelerometer:
Test host: BTT Pad 7 / CB1 / other
X shaper:
X frequency:
Y shaper:
Y frequency:
Max acceleration recommendation:
Config updated: yes/no
```

---

## Commit log for config changes

Use this table when committing config changes.

| Date | Commit | Config area | Reason | Result |
|---|---|---|---|---|
| | | | | |
