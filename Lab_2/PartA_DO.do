# ==========================================================
# partA Test DO File
# Compiles, simulates, and applies lab test vectors
# for 8-bit arithmetic operations verification.
# Matches the test table exactly from the lab document
# ==========================================================

# Clear previous simulation data
vdel -all
vlib work
vmap work work

# Compile source files
vcom full_adder.vhd
vcom partA.vhd

# Load design for simulation with generic N=8 override
vsim work.partA -gN=8

# Add signals to waveform window
add wave -radix hex A
add wave -radix hex B
add wave Cin
add wave Sel
add wave -radix hex F
add wave Cout

# ==========================================================
# Apply test vectors matching the table (n = 8)
# ==========================================================

# Case 1: F = A (Sel=00, Cin=0)
# Expected: F = 0F, Cout = 0
force A x"0F"
force B x"00"
force Cin 0
force Sel "00"
run 10ns

# Case 2: F = A + B (Sel=01, Cin=0) - First test
# Expected: F = 10, Cout = 0
force A x"0F"
force B x"0001"
force Cin 0
force Sel "01"
run 10ns

# Case 3: F = A + B (Sel=01, Cin=0) - Second test with overflow
# Expected: F = 00, Cout = 1
force A x"FF"
force B x"0001"
force Cin 0
force Sel "01"
run 10ns

# Case 4: F = A - B - 1 (Sel=10, Cin=0)
# Expected: F = FD, Cout = 1
force A x"FF"
force B x"0001"
force Cin 0
force Sel "10"
run 10ns

# Case 5: F = A - 1 (Sel=11, Cin=0)
# Expected: F = FE, Cout = 1
force A x"FF"
force B x"00"
force Cin 0
force Sel "11"
run 10ns

# Case 6: F = A + 1 (Sel=00, Cin=1)
# Expected: F = 0F, Cout = 0
force A x"0E"
force B x"00"
force Cin 1
force Sel "00"
run 10ns

# Case 7: F = A + B + 1 (Sel=01, Cin=1)
# Expected: F = 01, Cout = 1
force A x"FF"
force B x"0001"
force Cin 1
force Sel "01"
run 10ns

# Case 8: F = A - B (Sel=10, Cin=1)
# Expected: F = 0E, Cout = 1
force A x"0F"
force B x"0001"
force Cin 1
force Sel "10"
run 10ns

# Case 9: F = 0 (Sel=11, Cin=1)
# Expected: F = 0000, Cout = 0
force A x"F0"
force B x"00"
force Cin 1
force Sel "11"
run 10ns

# ==========================================================
# End of simulation
# ==========================================================
wave zoom full
update