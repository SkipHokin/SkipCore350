; SkipCore350 100 x 100 first-layer squaring frame
; Direct Klipper G-code for cautious commissioning
; Coordinate assumption: rear-right home is X0 Y0, printable bed is negative X/Y
; Bed size assumed: 330 x 330 mm
; Print centred around X-165 Y-165
; Print envelope approx X -215 to -115, Y -215 to -115
; Material: PLA, 0.4 mm nozzle, 0.20 mm first layer
; WATCH THE FIRST RUN CAREFULLY

M140 S60 ; set bed temp
M104 S205 ; set nozzle temp
G90 ; absolute positioning
M83 ; relative extrusion
G28 ; home all axes
M190 S60 ; wait for bed
M109 S205 ; wait for nozzle
G92 E0
G1 Z5 F600

; move to safe start near print area
G1 X-220 Y-220 F3000
G1 Z0.20 F600

; short prime line, just outside test frame
G1 X-160 Y-220 E2.25 F900
G92 E0

; 100 x 100 outer frame, two slow perimeter passes
; Approx extrusion based on 0.45 mm line width, 0.20 mm layer, 1.75 mm filament

; outer perimeter
G1 X-215 Y-215 F3000
G1 X-115 Y-215 E3.75 F900
G1 Y-115 E3.75 F900
G1 X-215 E3.75 F900
G1 Y-215 E3.75 F900

; inner perimeter, 5 mm inset, helps define a 5 mm border
G1 X-210 Y-210 F3000
G1 X-120 Y-210 E3.37 F900
G1 Y-120 E3.37 F900
G1 X-210 E3.37 F900
G1 Y-210 E3.37 F900

; diagonal witness lines, light but measurable
G1 X-210 Y-210 F3000
G1 X-120 Y-120 E4.77 F900
G1 X-210 Y-120 F3000
G1 X-120 Y-210 E4.77 F900

; repeat outer perimeter lightly for visibility
G1 X-215 Y-215 F3000
G1 X-115 Y-215 E3.75 F900
G1 Y-115 E3.75 F900
G1 X-215 E3.75 F900
G1 Y-215 E3.75 F900

; finish
G92 E0
G1 E-0.8 F1800
G1 Z5 F600
M104 S0
M140 S0
M106 S0
G1 X-10 Y-10 F3000 ; park near rear-right, still away from home switches
M84
; end
