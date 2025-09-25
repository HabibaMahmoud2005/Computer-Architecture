# Computer Architecture Lab 1 – 16-bit ALU (Parts B, C, D)

This repository contains my implementation of **Lab 1** for the Computer Architecture course at Cairo University.  
It implements the logical and shift/rotate parts of a 16-bit ALU and a structural top-level that integrates them.

---

## 📂 Files

| File        | Description |
|-------------|-------------|
| `partB.vhd` | Implements **logical operations** (AND, OR, XOR, NOT) on two 16-bit inputs. |
| `partC.vhd` | Implements **right shift/rotate operations** (logical shift right, rotate right, rotate right with carry, arithmetic shift right) on a 16-bit input. |
| `partD.vhd` | Implements **left shift/rotate operations** (logical shift left, rotate left, rotate left with carry, and zero output) on a 16-bit input. |
| `ALU.vhd`   | Structural VHDL connecting `partB`, `partC`, and `partD` into one 16-bit ALU using a 4-bit select line `S`. |
| `ALU_test.do` | ModelSim DO file that compiles the VHDL sources and runs the lab’s test vectors automatically. |

---

## 📝 ALU Selection Codes

The 4-bit input `S` = S3 S2 S1 S0 chooses the operation:

- **S3S2 = 01** → partB (logic ops):
  - `0100` – AND  
  - `0101` – OR  
  - `0110` – XOR  
  - `0111` – NOT  

- **S3S2 = 10** → partC (right shifts/rotates):
  - `1000` – Logical shift right  
  - `1001` – Rotate right  
  - `1010` – Rotate right with carry  
  - `1011` – Arithmetic shift right  

- **S3S2 = 11** → partD (left shifts/rotates):
  - `1100` – Logical shift left  
  - `1101` – Rotate left  
  - `1110` – Rotate left with carry  
  - `1111` – F = 0000 (all zeros)  

---

## 🚀 How to Run in ModelSim

1. Clone this repository.  
2. Open ModelSim (or QuestaSim).  
3. In the transcript window run:

   ```tcl
   do ALU_test.do
