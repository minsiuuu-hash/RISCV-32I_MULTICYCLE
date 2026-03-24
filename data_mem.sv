`timescale 1ns / 1ps

module data_mem (
    input               clk,
    input               rst,
    input               dwe,
    input        [ 2:0] i_funct3,
    input        [31:0] daddr,
    input        [31:0] dwdata,
    output logic [31:0] drdata
);

    logic [31:0] dmem[0:255];

    // initial begin        // sorting  
    //     dmem[0] = 32'd3;
    //     dmem[1] = 32'd1;
    //     dmem[2] = 32'd4;
    //     dmem[3] = 32'd0;
    //     dmem[4] = 32'd2;
    // end

    always_ff @(posedge clk) begin
        if (dwe) begin
            case (i_funct3)
                3'b000: begin  // SB
                    case (daddr[1:0])
                        2'b00: dmem[daddr[31:2]][7:0] <= dwdata[7:0];
                        2'b01: dmem[daddr[31:2]][15:8] <= dwdata[7:0];
                        2'b10: dmem[daddr[31:2]][23:16] <= dwdata[7:0];
                        2'b11: dmem[daddr[31:2]][31:24] <= dwdata[7:0];
                    endcase
                end
                3'b001: begin  // SH
                    case (daddr[1:0])
                        2'b00: dmem[daddr[31:2]][15:0] <= dwdata[15:0];
                        2'b10: dmem[daddr[31:2]][31:16] <= dwdata[15:0];
                        default:
                        dmem[daddr[31:2]] <= 32'hxxxxxxxx;  // misaligned SH
                    endcase
                end
                3'b010: begin  // SW
                    if (daddr[1:0] == 2'b00) dmem[daddr[31:2]] <= dwdata;
                    else dmem[daddr[31:2]] <= 32'hxxxxxxxx;  // misaligned SW
                end
                default: begin
                    dmem[daddr[31:2]] <= 32'hxxxxxxxx;
                end
            endcase
        end
    end

    always_comb begin
        drdata = 32'b0;
        case (i_funct3)
            3'b000: begin  // LB
                case (daddr[1:0])
                    2'b00:
                    drdata = {
                        {24{dmem[daddr[31:2]][7]}}, dmem[daddr[31:2]][7:0]
                    };
                    2'b01:
                    drdata = {
                        {24{dmem[daddr[31:2]][15]}}, dmem[daddr[31:2]][15:8]
                    };
                    2'b10:
                    drdata = {
                        {24{dmem[daddr[31:2]][23]}}, dmem[daddr[31:2]][23:16]
                    };
                    2'b11:
                    drdata = {
                        {24{dmem[daddr[31:2]][31]}}, dmem[daddr[31:2]][31:24]
                    };
                endcase
            end
            3'b001: begin  // LH
                case (daddr[1:0])
                    2'b00:
                    drdata = {
                        {16{dmem[daddr[31:2]][15]}}, dmem[daddr[31:2]][15:0]
                    };
                    2'b10:
                    drdata = {
                        {16{dmem[daddr[31:2]][31]}}, dmem[daddr[31:2]][31:16]
                    };
                    default: drdata = 32'hxxxxxxxx;  // misaligned LH
                endcase
            end
            3'b010: begin  // LW
                if (daddr[1:0] == 2'b00) drdata = dmem[daddr[31:2]];
                else drdata = 32'hxxxxxxxx;  // misaligned LW
            end
            3'b100: begin  // LBU
                case (daddr[1:0])
                    2'b00: drdata = {24'b0, dmem[daddr[31:2]][7:0]};
                    2'b01: drdata = {24'b0, dmem[daddr[31:2]][15:8]};
                    2'b10: drdata = {24'b0, dmem[daddr[31:2]][23:16]};
                    2'b11: drdata = {24'b0, dmem[daddr[31:2]][31:24]};
                endcase
            end
            3'b101: begin  // LHU
                case (daddr[1:0])
                    2'b00:   drdata = {16'b0, dmem[daddr[31:2]][15:0]};
                    2'b10:   drdata = {16'b0, dmem[daddr[31:2]][31:16]};
                    default: drdata = 32'hxxxxxxxx;  // misaligned LHU
                endcase
            end
            default: begin
                drdata = 32'hxxxxxxxx;
            end
        endcase
    end

endmodule
