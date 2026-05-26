I change Single-Cycle to Multi-Cycle<br>

5 STAGE<br>
FETCH > DECODE > EXECUTE > MEMORY > WRITEBACK<br>

First, i change cpu code. it was combinational logic. but we need sequential logic to make Multi Cycle.<br>
Then we can divide the instruction to several clks.<br>

I add total 7 register to make Multi Cycle.<br>

Decode  : RS1, RS2, Extend save register (3)<br>
Execute : ALU_RESULT, RS2 save register (2)<br>
Memory  : DRDATA save register (1)<br>
PC      : PC_NEXT save register + PC enable register (1)<br>

A single-cycle processor completes one instruction in one clock cycle, so the clock period must be long enough for the entire path from Fetch to Write Back. 
In a multi-cycle processor, the instruction execution process is divided into several clock cycles, which reduces the combinational logic delay in each cycle.
Therefore, the clock period can be shorter and the clock frequency can be higher.
However, because each instruction takes multiple cycles, the overall performance depends on the instruction mix and implementation.
