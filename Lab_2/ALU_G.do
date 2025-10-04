# ==========================================================
# ALU Test DO File - 8-bit Version
# Forces N=8 inside simulation
# Matches Lab2 test table exactly
# S3S2 selects module: 00=partA, 01=partB, 10=partC, 11=partD
# S1S0 selects operation within module
# ==========================================================

# Clear previous simulation data
vdel -all
vlib work
vmap work work

# Compile source files with 8-bit generic override
vcom full_adder.vhd
vcom partA.vhd
vcom partB.vhd
vcom partC.vhd
vcom partD.vhd
vcom ALU.vhd

# Load top-level ALU with generic N=8
vsim work.ALU -gN=8

# Add signals to waveform window
add wave -radix hex A
add wave -radix hex B
add wave Cin
add wave -radix binary S
add wave -radix hex F
add wave Cout

# ==========================================================
# PART A: Arithmetic Operations (S3S2 = 00)
# ==========================================================

# Test 1: F = A (S1S0=00, Cin=0)
force A x"0F"
force B x"00"
force Cin 0
force S "0000"
run 200ns

# Test 2: F = A + B (S1S0=01, Cin=0)
force A x"0F"
force B x"01"
force Cin 0
force S "0001"
run 200ns

# Test 3: F = A + B with overflow (S1S0=01, Cin=0)
force A x"FF"
force B x"01"
force Cin 0
force S "0001"
run 200ns

# Test 4: F = A - B - 1 (S1S0=10, Cin=0)
force A x"FF"
force B x"01"
force Cin 0
force S "0010"
run 200ns

# Test 5: F = A - 1 (S1S0=11, Cin=0)
force A x"FF"
force B x"00"
force Cin 0
force S "0011"
run 200ns

# Test 6: F = A + 1 (S1S0=00, Cin=1)
force A x"0E"
force B x"00"
force Cin 1
force S "0000"
run 200ns

# Test 7: F = A + B + 1 (S1S0=01, Cin=1)
force A x"FF"
force B x"01"
force Cin 1
force S "0001"
run 200ns

# Test 8: F = A - B (S1S0=10, Cin=1)
force A x"0F"
force B x"01"
force Cin 1
force S "0010"
run 200ns

# Test 9: F = 0 (S1S0=11, Cin=1)
force A x"F0"
force B x"00"
force Cin 1
force S "0011"
run 200ns

# ==========================================================
# PART B: Logic Operations (S3S2 = 01)
# ==========================================================

# Test 10: F = A AND B
force A x"F5"
force B x"AA"
force Cin 0
force S "0100"
run 200ns

# Test 11: F = A OR B
force A x"F5"
force B x"AA"
force Cin 0
force S "0101"
run 200ns

# Test 12: F = A NOR B  (if XOR required by TA, adjust here)
force A x"F5"
force B x"AA"
force Cin 0
force S "0110"
run 200ns

# Test 13: F = NOT A
force A x"F5"
force B x"00"
force Cin 0
force S "0111"
run 200ns

# ==========================================================
# PART C: Right Shifts/Rotates (S3S2 = 10)
# ==========================================================

# Test 14: Logic shift right A
force A x"F5"
force Cin 0
force S "1000"
run 200ns

# Test 15: Rotate right A
force A x"F5"
force Cin 0
force S "1001"
run 200ns

# Test 16: Rotate right A with Carry (Cin=0)
force A x"F5"
force Cin 0
force S "1010"
run 200ns

# Test 17: Rotate right A with Carry (Cin=1)
force A x"F5"
force Cin 1
force S "1010"
run 200ns

# Test 18: Arithmetic shift right A
force A x"F5"
force Cin 0
force S "1011"
run 200ns

# ==========================================================
# PART D: Left Shifts/Rotates (S3S2 = 11)
# ==========================================================

# Test 19: Logic shift left A
force A x"F5"
force Cin 0
force S "1100"
run 200ns

# Test 20: Rotate left A
force A x"F5"
force Cin 0
force S "1101"
run 200ns

# Test 21: Rotate left A with Carry (Cin=0)
force A x"F5"
force Cin 0
force S "1110"
run 200ns

# Test 22: Rotate left A with Carry (Cin=1)
force A x"F5"
force Cin 1
force S "1110"
run 200ns

# Test 23: F = 0000
force A x"F5"
force Cin 0
force S "1111"
run 200ns

# Test 24: Rotate right A (different input)
force A x"7A"
force Cin 0
force S "1001"
run 200ns

# ==========================================================
# End of simulation
# ==========================================================
wave zoom full
update
