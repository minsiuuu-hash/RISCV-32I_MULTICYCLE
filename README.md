I change Single-Cycle to Multi-Cycle<br>

5 STAGE<br>
FETCH > DECODE > EXECUTE > MEMORY > WRITEBACK<br>

First, i change cpu code. it was combinational logic. but we need sequential logic to make Multi Cycle.<br>
Then we can divide the instruction to several clks.<br>

![project image](img/block.png)
I add total 7 register to make Multi Cycle.<br>

Between Decode and Execute: RS1, RS2, Immediate save registers (3)<br>
Between Execute and Memory: ALU_RESULT, RS2 save registers (2)<br>
Between Memory and Write Back: DRDATA save register (1)<br>
PC path: PC_NEXT save register (1), and the PC register was changed to an enable-controlled register using pc_en<br>

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

