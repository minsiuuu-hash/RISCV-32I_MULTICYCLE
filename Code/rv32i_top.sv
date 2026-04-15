`timescale 1ns / 1ps

// module rv32i_top (
//     input clk,
//     input rst
// );
//     logic dwe;
//     logic [2:0] o_funct3;
//     logic [31:0] instr_addr, instr_data, daddr, dwdata, drdata;

//     instruction_mem U_INSTRUCTION_MEM (.*);

//     rv32i_cpu U_RV32I (.*);

//     data_mem U_DATA_MEM (
//         .*,
//         .i_funct3(o_funct3)
//     );

// endmodule



module rv32i_top (
    input         clk,
    input         rst,
    output [15:0] led   // 16개의 LED 출력 추가
);
    logic dwe;
    logic [2:0] o_funct3;
    logic [31:0] instr_addr, instr_data, daddr, dwdata, drdata;

    instruction_mem U_INSTRUCTION_MEM (.*);
    rv32i_cpu U_RV32I (.*);
    data_mem U_DATA_MEM (
        .*,
        .i_funct3(o_funct3)
    );

    // 하드웨어가 삭제되지 않도록 내부 신호를 외부 포트에 연결
    // 예: 현재 메모리에 쓰려는 주소의 하위 16비트를 LED로 확인
    assign led = daddr[15:0];

endmodule
