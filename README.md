# 4-bit CPU Project (Verilog, Vivado Simulation)

This is a simulation-only 4-bit CPU built in Verilog using Xilinx Vivado. It's designed to be small, readable, and fully verified, so it clearly demonstrates the core digital design skills relevant to hardware intern roles at companies like Arm and AMD: datapath + control, ISA design, RTL quality, and verification.

---

## How this maps to digital design/hardware placements

- **Micro-architecture thinking**: Clean separation of datapath (PC, RegFile, ALU, memories) and control (decoder).
- **RTL fundamentals**: Synchronous writes, combinational reads, default assignments, explicit reset, and no unintended latches.
- **Verification mindset**: Unit testbenches for each block plus a self-checking top-level (`cpu_tb.v`) that asserts the final result.
- **Observability**: The top module exposes debug ports (`pc_debug`, `instr_debug`, `R0_debug`, `R1_debug`, `ram3_debug`) so behaviour is easy to inspect in waveforms and logs - exactly what teams want in debugguging. 
- **Documentation & ISA clarity**: A compact instruction set with a reproducible demo program and expected end state.

--- 

## Completed Modules

- **ALU (Arithmetic Logic Unit)**

ADD, SUB, AND, OR, XOR; exposes zero flag and carry on ADD

- **Register File (R0/R1)**

Two 4-bit general-purpose registers with synchronous write and combinational read.

- **Program Counter (PC)**

4-bit counter with increment, load, and reset.

- **Instruction ROM (Read-Only Memory)**

16x8 ROM holding the program (8-bit instruction = opcode[7:4] + operand [3:0]).

- **Data RAM (Random Access Memory)**

16x4 RAM for LOAD/STORE; preloaded with demo data.

- **Decoder (Control Unit)**

Maps opcode to control signals: `reg_write`, `reg_sel`, `alu_op`, `mem_read`, `mem_write`, `pc_inc`, `halt`.

- **Top-Level CPU Integration (`cpu.v`)**

Wires all the modules together correctly and includes debug outputs. Verified by `cpu_tb.v`.

- **Testbenches**

Unit testbenches for each block and an end-to-end CPU testbench with a PASS/FAIL self-check.

---


## Folder Structure

### `/src` - **RTL source**

- `alu.v` - ALU
- `register_file.v` - R0/R1 register file
- `program_counter.v` - PC
- `instruction_memory.v` - ROM (program preloaded)
- `data_memory.v` - RAM (data preloaded)
- `decoder.v` - control decoder
- `cpu.v` - top-level (with debug ports)

### `/sim` - **Simulation & Verification**

- `alu_tb.v` - ALU testbench
- `register_file_tb.v` - Register file testbench
- `program_counter_tb.v` - PC testbench
- `instruction_memory_tb.v` - ROM testbench
- `data_memory_tb.v` - RAM testbench
- `decoder_tb.v` - Decoder testbench
- `cpu_tb.v` - top-level testbench (self-checking)

---

## Instruction Set Architecture (ISA)

**Instruction width**: 8 bits
**Format**: `[7:4] opcode | [3:0] operand`

| Opcode | Function                                  |
|:-------|:------------------------------------------|
| 0000   | No operand: PC just increments            |
| 0001   | Load R0 with the RAM address              | 
| 1001   | Load R1 with the RAM address              |
| 0010   | RAM address will store R0                 |
| 1010   | RAM address will store R1                 |
| 0011   | ADD R0 and R1 and store the result in R0  |
| 0100   | SUB R0 and R1 and store the result in R0  | 
| 0101   | AND R0 and R1 and store the result in R0  |
| 0110   | OR R0 and R1 and store the result in R0   |
| 0111   | XOR R0 and R1 and store the result in R0  |
| 1111   | HALT - stop PC increment (hold state)     |

### Demo program in ROM

- 0: Load R0 with the value 3 (RAM[1] = 3)
- 1: Load R1 with the value 2 (RAM[2] = 2)
- 2: Add R0 and R1 and store into R0 (R0 = 5)
- 3: Store R0 into RAM[3] (RAM[3] = 5)
- 4: HALT

Expected final state: `R0 = 5`, `R1 = 2`, `RAM[3] = 5`, PC halted at 4

--- 

## Tools Used

- **Language**: Verilog HDL
- **Simulator**: Xilinx Vivado (Behavioural Simulation)
- **Editor**: VS Code
- **Version Control**: Git & GitHub

## How to Run in Vivado

1. **Create Project**: RTL Project (don't specify sources at first).
2. **Add Sources**: add `/src` files as **Design Sources** and `/sim` files as **Simulation Sources**.
3. **Run Unit Tests**: simulate **tb.v** files to verify each block.
4. **Run Top-Level**: set **cpu.v** and **cpu_tb.v** as top and **Run Behavioural Simulation**. Watch console for a PASS message: `PASS: Program result OK (RAM[3] = 5)`

## What a reviewer/recruiter will see

- Readable RTL wit beginner-friendly comments.
- Deterministic demo (3 + 2 = 5 stored to memory) that's easy to reproduce.
- Self-checking testbench at the top level.
- Debug ports that make the design transparent in waveformns - great for code reviews 

## Next Steps / Extensions

- Expand ISA including more ALU operations
- Move to **SystemVerilog** + simple **UVM** testbench for scalable verification that's also more industry relevant.
- Explore multi-cycle control or a tiny 2-stage pipeline.

## Goals achieved

- Practiced solid digital design fundamentals through a complete, verifiabvle CPU.
- Demonstrated Verilog, simulation, and verification skills for hardware internships.
- Built a clean, documented project that maps directly to micro-architecture and RTL work at companies like Arm and AMD.