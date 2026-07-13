# SkipCore350 Test Prints

This folder contains small commissioning prints used before serious tuning.

## 100 x 100 first-layer squaring frame

Files:

- `SkipCore350_100x100_1layer_5mm_frame.stl` — slicer-friendly 100 x 100 x 0.2 mm frame.
- `SkipCore350_100x100_slow_PLA_rear_right_zero.gcode` — direct Klipper G-code for the current SkipCore coordinate model.

Use the STL through Orca/SuperSlicer for normal use. Use the direct G-code only when the machine coordinate setup has been confirmed:

```text
rear-right = X0 Y0
printable area = negative X/Y
bed size = 330 x 330 mm
```

The direct G-code prints centred around `X-165 Y-165`, with movement around `X -215..-115` and `Y -215..-115`.

## Measurement targets

```text
Outer X side: 100.00 mm
Outer Y side: 100.00 mm
Ideal diagonal: 141.42 mm
```

Measure:

```text
front edge
rear edge
left edge
right edge
diagonal 1
diagonal 2
```

If both sides are close but diagonals differ, investigate XY skew/squareness.

## Caution

Watch the first direct G-code run carefully. It includes homing, bed/nozzle heat, and a short prime line. It assumes the rear-right-zero/negative-coordinate setup documented in `COMMISSIONING.md`.
