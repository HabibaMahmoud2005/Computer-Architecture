# ==========================================================
# ALU Test DO File
# Compiles all VHDL sources, runs simulation, and applies
# lab test vectors for ALU verification.
# ==========================================================

# Clear previous work
vdel -all
vlib work
vmap work work

# Compile source files
vcom partB.vhd
vcom partC.vhd
vcom partD.vhd
vcom ALU.vhd

# Load the top-level ALU for simulation
vsim work.ALU

# Add signals to waveform window
add wave A
add wave B
add wave Cin
add wave S
add wave F
add wave Cout

# ==========================================================
# Apply test vectors from lab table
# ==========================================================

# Case 1: AND
force A x"F00F"
force B x"000A"
force Cin 0
force S "0100"   ;# S3S2=01 -> partB, S1S0=00 -> AND
run 200ns

# Case 2: OR
force S "0101"   ;# partB, OR
run 200ns

# Case 3: XOR
force S "0110"   ;# partB, XOR
run 200ns

# Case 4: NOT
force S "0111"   ;# partB, NOT
run 200ns

# Case 5: Logical Shift Right
force S "1000"   ;# partC, LSR
run 200ns

# Case 6: Rotate Right
force S "1001"   ;# partC, ROR
run 200ns

# Case 7: Rotate Right with Carry, Cin=0
force Cin 0
force S "1010"
run 200ns

# Case 8: Rotate Right with Carry, Cin=1
force Cin 1
run 200ns

# Case 9: Arithmetic Shift Right
force S "1011"
run 200ns

# Case 10: Logical Shift Left
force Cin 0
force S "1100"   ;# partD, LSL
run 200ns

# Case 11: Rotate Left
force S "1101"
run 200ns

# Case 12: Rotate Left with Carry, Cin=0
force Cin 0
force S "1110"
run 200ns

# Case 13: Rotate Left with Carry, Cin=1
force Cin 1
run 200ns

# Case 14: F = 0000 (all zeros)
force S "1111"
run 200ns

# ==========================================================
# End of simulation
# ==========================================================
wave zoom full
update \