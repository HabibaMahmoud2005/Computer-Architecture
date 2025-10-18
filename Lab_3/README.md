# 🧾 Register File Design (Lab Assignment 3)

## 🧠 Objective

This lab implements and simulates two versions of an 8×8 **register file** using VHDL:

1. **Flip-Flop-based design (`reg_file_dff`)**
2. **Memory-based design (`reg_file_mem`)**

Both designs support:

- Two read ports (`read_addr1`, `read_addr2`)
- One write port (`write_addr`)
- Synchronous write operation
- Asynchronous read operation
- Global reset signal

---

## 📂 Project Files

| File               | Description                                        |
| ------------------ | -------------------------------------------------- |
| `my_DFF.vhd`       | Implements a single-bit D Flip-Flop with reset     |
| `my_nDFF.vhd`      | Creates an N-bit register from multiple DFFs       |
| `reg_file_dff.vhd` | 8×8 Register file built using `MY_NDFF` components |
| `reg_file_mem.vhd` | 8×8 Register file implemented using a RAM array    |
| `dff_do.do`        | Simulation script for DFF-based design             |
| `mem_do.do`        | Simulation script for Memory-based design          |

---

## ⚙️ Tools Used

- **Intel Quartus Prime Lite 23.1**
- **ModelSim – Intel FPGA Edition 2020.1**
- **VHDL-2002** standard

---

## 🧾 Results Summary

| Design         | Description            | Observation                                     |
| -------------- | ---------------------- | ----------------------------------------------- |
| `reg_file_dff` | Built using flip-flops | Correct functionality, clear internal structure |
| `reg_file_mem` | Built using RAM array  | More compact RTL, same functional results       |

---

📘 _Computer Architecture – Fall 2025_  
🏫 _Lab 3: Register File Design using DFFs and Memory_
