# RISC-V RV32I Multi-Cycle CPU

I changed the Single-Cycle CPU into a Multi-Cycle CPU.

## 5 Stages

The instruction execution process is divided into 5 stages.

FETCH → DECODE → EXECUTE → MEMORY → WRITE BACK

First, i change cpu code. it was combinational logic. but we need sequential logic to make Multi Cycle.<br>
Then we can divide the instruction to several clks.<br>

![project image](img/block.png)

## Added Registers for Multi-Cycle CPU

The Single-Cycle CPU was converted into a Multi-Cycle CPU by adding registers between major execution stages.  
These registers hold intermediate values so that each instruction can be executed step by step across multiple clock cycles.

| Section | Registers | Number of Registers | Description |
|:---:|:---:|:---:|:---:|
| Decode → Execute | `RS1`, `RS2`, `Immediate` | 3 | Holds operand values and immediate data after instruction decode |
| Execute → Memory | `ALU_RESULT`, `RS2` | 2 | Holds the ALU result and store data before memory access |
| Memory → Write Back | `DRDATA` | 1 | Holds memory read data before register write-back |
| PC Path | `PC_NEXT` | 1 | Holds the calculated next PC value |

The existing PC register was also modified into an enable-controlled register using `pc_en`.  
This allows the PC to be updated only at the appropriate state in the multi-cycle control flow.

### Total Added Registers

| Category | Count |
|:---:|:---:|
| Pipeline-like stage registers | 6 |
| PC path register | 1 |
| **Total** | **7** |

A single-cycle processor completes one instruction in one clock cycle, so the clock period must be long enough for the entire path from Fetch to Write Back. <br>
In a multi-cycle processor, the instruction execution process is divided into several clock cycles, which reduces the combinational logic delay in each cycle.<br>
Therefore, the clock period can be shorter and the clock frequency can be higher.<br>
However, because each instruction takes multiple cycles, the overall performance depends on the instruction mix and implementation.<br>

## Performance Comparison: Single-Cycle vs Multi-Cycle

The performance of the Single-Cycle CPU and Multi-Cycle CPU was compared using a C code SUM program.

| CPU Type | Clock Period | Simulation Time | Test Program |
|---|---:|---:|---|
| Single-Cycle | 15.8 ns | 4.447 us | C code SUM |
| Multi-Cycle | 8.3 ns | 9.084 us | C code SUM |

### Summary

Although the Multi-Cycle CPU has a shorter clock period than the Single-Cycle CPU, it requires multiple clock cycles to execute one instruction.  
Therefore, in this SUM program simulation, the total simulation time of the Multi-Cycle CPU is longer than that of the Single-Cycle CPU.

