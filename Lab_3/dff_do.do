# ==========================================================
# Lab 3 - Register File (DFF-based) Simulation
# Author: Habiba Mahmoud
# ==========================================================

# Clean workspace
vlib work
vmap work work

# Compile design files
vcom MY_NDFF.vhd
vcom reg_file_dff.vhd

# Start simulation
vsim work.reg_file_dff

# ==========================================================
# Add signals to waveform
# ==========================================================
view wave
add wave -radix binary sim:/reg_file_dff/clk
add wave -radix binary sim:/reg_file_dff/rst
add wave -radix binary sim:/reg_file_dff/we
add wave -radix unsigned sim:/reg_file_dff/read_addr1
add wave -radix unsigned sim:/reg_file_dff/read_addr2
add wave -radix unsigned sim:/reg_file_dff/write_addr
add wave -radix hex sim:/reg_file_dff/write_data
add wave -radix hex sim:/reg_file_dff/read_data1
add wave -radix hex sim:/reg_file_dff/read_data2

# ==========================================================
# Create clock signal (10ns period, 50% duty)
# ==========================================================
force -freeze sim:/reg_file_dff/clk 0 0ns, 1 {5ns} -r 10ns

# ==========================================================
# CYCLE 1: Reset all registers
# ==========================================================
echo "CYCLE 1 (0-10ns): Reset all registers"
force sim:/reg_file_dff/rst 1
force sim:/reg_file_dff/we 0
force sim:/reg_file_dff/read_addr1 000
force sim:/reg_file_dff/read_addr2 000
force sim:/reg_file_dff/write_addr 000
force sim:/reg_file_dff/write_data 00000000
run 10ns

# Release reset
force sim:/reg_file_dff/rst 0

# ==========================================================
# CYCLE 2: Write Reg(0) = 0xFF
# ==========================================================
echo "CYCLE 2 (10-20ns): Write Reg(0) = 0xFF"
force sim:/reg_file_dff/we 1
force sim:/reg_file_dff/write_addr 000
force sim:/reg_file_dff/write_data 11111111
run 10ns

# ==========================================================
# CYCLE 3: Write Reg(1) = 0x11
# ==========================================================
echo "CYCLE 3 (20-30ns): Write Reg(1) = 0x11"
force sim:/reg_file_dff/write_addr 001
force sim:/reg_file_dff/write_data 00010001
run 10ns

# ==========================================================
# CYCLE 4: Write Reg(7) = 0x90
# ==========================================================
echo "CYCLE 4 (30-40ns): Write Reg(7) = 0x90"
force sim:/reg_file_dff/write_addr 111
force sim:/reg_file_dff/write_data 10010000
run 10ns

# ==========================================================
# CYCLE 5: Write Reg(3) = 0x08
# ==========================================================
echo "CYCLE 5 (40-50ns): Write Reg(3) = 0x08"
force sim:/reg_file_dff/write_addr 011
force sim:/reg_file_dff/write_data 00001000
run 10ns

# ==========================================================
# CYCLE 6: Read(Reg1), Read(Reg7), Write(Reg4)=0x03
# ==========================================================
echo "CYCLE 6 (50-60ns): Read Reg(1), Reg(7), Write 0x03 -> Reg(4)"
force sim:/reg_file_dff/we 1
force sim:/reg_file_dff/read_addr1 001
force sim:/reg_file_dff/read_addr2 111
force sim:/reg_file_dff/write_addr 100
force sim:/reg_file_dff/write_data 00000011
run 10ns

# ==========================================================
# CYCLE 7: Read(Reg2), Read(Reg3)
# ==========================================================
echo "CYCLE 7 (60-70ns): Read Reg(2), Reg(3)"
force sim:/reg_file_dff/we 0
force sim:/reg_file_dff/read_addr1 010
force sim:/reg_file_dff/read_addr2 011
run 10ns

# ==========================================================
# CYCLE 8: Read(Reg4), Read(Reg5)
# ==========================================================
echo "CYCLE 8 (70-80ns): Read Reg(4), Reg(5)"
force sim:/reg_file_dff/read_addr1 100
force sim:/reg_file_dff/read_addr2 101
run 10ns

# ==========================================================
# CYCLE 9: Read(Reg6), Read(Reg0), Write(Reg0)=0x01
# ==========================================================
echo "CYCLE 9 (80-90ns): Read Reg(6), Reg(0), Write 0x01 -> Reg(0)"
force sim:/reg_file_dff/we 1
force sim:/reg_file_dff/read_addr1 110
force sim:/reg_file_dff/read_addr2 000
force sim:/reg_file_dff/write_addr 000
force sim:/reg_file_dff/write_data 00000001
run 10ns

# ==========================================================
# End Simulation
# ==========================================================
echo "Simulation finished successfully at 100ns"
run 100ns
wave zoom full
