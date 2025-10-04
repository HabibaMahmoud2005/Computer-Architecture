# ALU / ALSU VHDL Project

## 📌 Overview
This project implements an **N-bit Arithmetic Logic and Shift Unit (ALSU)** in VHDL as part of Cairo University Computer Architecture Labs (Lab1 + Lab2).  
The ALSU integrates arithmetic, logic, and shift/rotate operations into one generic unit.

- **Generic width (N)** → supports different operand sizes (8-bit, 16-bit, …).  
- **Selection inputs (S3 S2 S1 S0)** → choose operation group and type.  
- **Carry-in (Cin)** and **Carry-out (Cout)** supported.

## 🧩 Components
The ALSU is built structurally from 4 submodules:

- **partA** → Arithmetic (Add, Sub, Increment, Decrement, etc.) using a **full adder** chain.
- **partB** → Logic operations (AND, OR, NOR, NOT).
- **partC** → Right shifts and rotates (logical, arithmetic, with carry).
- **partD** → Left shifts and rotates (logical, with carry, zero output).

Additionally, a **1-bit full_adder** component is provided.

## 🔑 Operation Selection
The ALSU uses a 4-bit selection input `S`:

- **S3 S2** → Select submodule:
  - `00` → Arithmetic (partA)
  - `01` → Logic (partB)
  - `10` → Right shifts/rotates (partC)
  - `11` → Left shifts/rotates (partD)
- **S1 S0** → Select operation inside the chosen submodule.

### Part A (Arithmetic) – depends on Cin
| S1S0 | Cin=0 | Cin=1 |
|------|-------|-------|
| 00   | F=A   | F=A+1 |
| 01   | F=A+B | F=A+B+1 |
| 10   | F=A–B–1 | F=A–B |
| 11   | F=A–1 | F=0 |

### Part B (Logic)
| S1S0 | Operation |
|------|-----------|
| 00   | F=A AND B |
| 01   | F=A OR B |
| 10   | F=A NOR B |
| 11   | F=NOT A |

### Part C (Right Shifts/Rotates)
| S1S0 | Operation |
|------|-----------|
| 00   | F=Logical shift right A |
| 01   | F=Rotate right A |
| 10   | F=Rotate right A with Carry (Cin → MSB) |
| 11   | F=Arithmetic shift right A (MSB preserved) |

### Part D (Left Shifts/Rotates)
| S1S0 | Operation |
|------|-----------|
| 00   | F=Logical shift left A |
| 01   | F=Rotate left A |
| 10   | F=Rotate left A with Carry (Cin → LSB) |
| 11   | F=0000…0000 |

## ▶️ Simulation
Simulation is done in **ModelSim** using provided `.do` test scripts.

### Run 8-bit simulation
```tcl
vsim work.ALU -gN=8
do alu_test_8bit.do
```

### Run 16-bit simulation
```tcl
vsim work.ALU -gN=16
do alu_test_16bit.do
```

## 📂 Project Files
- `full_adder.vhd` → 1-bit full adder
- `partA.vhd` → Arithmetic unit (structural using full adders)
- `partB.vhd` → Logic unit
- `partC.vhd` → Right shifts/rotates
- `partD.vhd` → Left shifts/rotates
- `ALU.vhd` → Top-level ALSU integrating all parts
- `partA_DO.do` → ModelSim testbench (8-bit version) for part A
- `ALU_G.do` → ModelSim testbench (8-bit version)
- `README.md` → Project documentation
- `Notes.md` → Lab notes

## ✨ Features Learned
- Structural VHDL design (components + generics)
- Using **full adder chains** instead of `+` / `-` operators
- Handling **generic N-bit signals**
- Simulation automation with **ModelSim DO files**

## 📜 Notes
- Lab1 implemented only Parts B, C, and D.  
- Lab2 extended with Part A (arithmetic) and integrated everything into one generic ALSU.
