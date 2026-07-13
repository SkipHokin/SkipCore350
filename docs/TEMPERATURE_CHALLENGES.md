# SkipCore350 Temperature Challenges

This document captures the temperature-related problems, assumptions, fixes, and tests for SkipCore350.

Use this as a running record rather than a polished final answer. Add dates, screenshots, Klipper log snippets, photos, and final settings as they are confirmed.

---

## Current known context

- Controller: BTT Manta M8P v2.0 with onboard CB1.
- Firmware: Klipper.
- Bed heater: 230 VAC silicone heater, around 500 W.
- Bed control: SSR on bed output path.
- Bed sensor: THB / bed thermistor input.
- Hotend currently used during commissioning: E3D Revo Ceramic 24 V 60 W.
- Planned / alternate hotend: Rapido 2 UHF PT1000.
- Part cooling: dual 5010 fans; earlier testing suggested fan percentage must be kept conservative with the Revo Ceramic.
- Bed target used during early PLA/PLA+ tests: around 60 °C.

---

## Main risk areas

### 1. Bed heater and SSR safety

The bed is mains-powered, so this is not just a tuning issue. Treat the bed circuit as a safety-critical assembly.

Checklist:

- [ ] SSR is rated appropriately for the AC bed load.
- [ ] SSR heat sinking is adequate.
- [ ] Earth bonding is checked.
- [ ] Cable strain relief is fitted.
- [ ] Bed thermal fuse fitted and tested/inspected.
- [ ] Bed thermistor is firmly attached and cannot lift away from the plate.
- [ ] Bed temperature rises smoothly during a controlled test.
- [ ] Bed temperature falls when switched off.
- [ ] No unexpected heating occurs on firmware restart.

Notes:

```text
Date:
Observation:
Action:
Result:
```

---

### 2. Hotend temperature rise faults

Record any Klipper heater errors here. Useful items to capture:

- Exact error text.
- Target temperature.
- Starting temperature.
- Fan state.
- Silicone sock fitted or not.
- Ambient/enclosure temperature.
- Hotend type.
- Heater cartridge wattage.
- Thermistor/sensor type in config.
- PID values at the time.

Log template:

```text
Date:
Hotend:
Nozzle:
Material:
Target temperature:
Fan state:
Error message:
Relevant config:
Likely cause:
Fix attempted:
Result:
```

---

### 3. Revo Ceramic cooling sensitivity

Early commissioning notes indicate the E3D Revo Ceramic may be sensitive to excessive part cooling, especially with dual 5010 fans. Keep part cooling conservative until temperature stability is proven.

Initial conservative rules:

- PLA/PLA+: start part cooling low, around 25–35%.
- Do not run dual 5010 fans at full power during hotend temperature validation.
- Watch for temperature drop during bridges, overhang tests, and Benchy-style cooling changes.
- Tune fan limits before chasing speed.

Test log:

| Date | Material | Nozzle temp | Fan % | Result | Notes |
|---|---:|---:|---:|---|---|
| | | | | | |

---

### 4. PID tuning records

## Hotend PID

```text
Date:
Hotend:
Nozzle:
Target:
Fan state:
PID result:
Saved to config: yes/no
Notes:
```

## Bed PID

```text
Date:
Bed plate:
Target:
Enclosure open/closed:
PID result:
Saved to config: yes/no
Notes:
```

---

## Safe temperature test order

1. Verify room-temperature readings.
2. Heat hotend to 50 °C, then switch off.
3. Heat bed to 40 °C, then switch off.
4. Heat hotend to normal PLA temperature.
5. PID tune hotend.
6. Heat bed to 60 °C.
7. PID tune bed.
8. Run fan disturbance test on hotend.
9. Only then move into print tuning.

---

## Fan disturbance test

Goal: confirm the hotend can hold temperature while part cooling turns on.

Suggested procedure:

```gcode
M109 S220
M106 S64   ; about 25%
; watch hotend temperature
M106 S96   ; about 38%
; watch hotend temperature
M106 S128  ; about 50%, only if previous test is stable
M107
```

Pass condition:

- Hotend recovers without Klipper heater fault.
- No rapid uncontrolled drop.
- No oscillation large enough to affect printing.

Result:

```text
Date:
Fan percentage limit chosen:
Reason:
```

---

## Open questions

- [ ] Confirm final hotend: Revo Ceramic vs Rapido 2 UHF.
- [ ] Confirm final hotend temperature sensor type.
- [ ] Confirm final part cooling max percentage.
- [ ] Confirm bed heater SSR temperature during long heat soak.
- [ ] Confirm enclosure temperature during PETG/ABS/ASA tests.
