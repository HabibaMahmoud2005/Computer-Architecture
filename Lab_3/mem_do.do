# ============================================
# Register File (Memory-based) Simulation Script
# Design: reg_file_mem.vhd
# ============================================

# Compile the design
vcom reg_file_mem.vhd

# Start simulation
vsim work.reg_file_mem

# ============================================
# Add signals to waveform
# ============================================
add wave -radix binary /reg_file_mem/clk
add wave -radix binary /reg_file_mem/rst
add wave -radix binary /reg_file_mem/we
add wave -radix unsigned /reg_file_mem/read_addr1
add wave -radix unsigned /reg_file_mem/read_addr2
add wave -radix unsigned /reg_file_mem/write_addr
add wave -radix hexadecimal /reg_file_mem/datain
add wave -radix hexadecimal /reg_file_mem/dataout1
add wave -radix hexadecimal /reg_file_mem/dataout2
add wave -radix hexadecimal /reg_file_mem/ram

# ============================================
# Clock generation (period = 100 ns)
# ============================================
force clk 0 0ns, 1 50ns -repeat 100ns

# ============================================
# Cycle 1 @ 50ns: Reset all registers
# ============================================
echo "CYCLE 1 @ 50ns: Reset all registers"
force rst 1
force we 0
force read_addr1 000
force read_addr2 000
force write_addr 000
force datain x"00"
run 100 ns

# ============================================
# Cycle 2 @ 150ns: Write 0xFF to Reg(0)
# ============================================
echo "CYCLE 2 @ 150ns: Write FF to Reg(0)"
force rst 0
force we 1
force write_addr 000
force datain x"FF"
run 100 ns

# ============================================
# Cycle 3 @ 250ns: Write 0x11 to Reg(1)
# ============================================
echo "CYCLE 3 @ 250ns: Write 11 to Reg(1)"
force write_addr 001
force datain x"11"
run 100 ns

# ============================================
# Cycle 4 @ 350ns: Write 0x90 to Reg(7)
# ============================================
echo "CYCLE 4 @ 350ns: Write 90 to Reg(7)"
force write_addr 111
force datain x"90"
run 100 ns

# ============================================
# Cycle 5 @ 450ns: Write 0x08 to Reg(3)
# ============================================
echo "CYCLE 5 @ 450ns: Write 08 to Reg(3)"
force write_addr 011
force datain x"08"
run 100 ns

# ============================================
# Cycle 6 @ 550ns: Read Reg(1), Reg(7), Write 0x03 to Reg(4)
# ============================================
echo "CYCLE 6 @ 550ns: Read Reg(1) and Reg(7), Write 03 to Reg(4)"
force read_addr1 001
force read_addr2 111
force write_addr 100
force datain x"03"
run 100 ns

# ============================================
# Cycle 7 @ 650ns: Read Reg(2), Reg(3)
# ============================================
echo "CYCLE 7 @ 650ns: Read Reg(2) and Reg(3)"
force we 0
force read_addr1 010
force read_addr2 011
run 100 ns

# ============================================
# Cycle 8 @ 750ns: Read Reg(4), Reg(5)
# ============================================
echo "CYCLE 8 @ 750ns: Read Reg(4) and Reg(5)"
force read_addr1 100
force read_addr2 101
run 100 ns

# ============================================
# Cycle 9 @ 850ns: Read Reg(6), Reg(0), Write 0x01 to Reg(0)
# ============================================
echo "CYCLE 9 @ 850ns: Read Reg(6) and Reg(0), Write 01 to Reg(0)"
force we 1
force read_addr1 110
force read_addr2 000
force write_addr 000
force datain x"01"
run 100 ns

# ============================================
# Stop the simulation
# ============================================
echo "Simulation finished cleanly at 950ns."
wave zoom full
