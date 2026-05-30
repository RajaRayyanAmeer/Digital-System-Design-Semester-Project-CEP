`timescale 1ns / 1ps
module alu (
    input wire [31:0] a, b,
    input wire [2:0] alu_control,
    output reg [31:0] result,
    output reg zero
);
    always @(*)
        begin
            case (alu_control)
                3'b000: result = a + b;           // add
                3'b001: result = a - b;           // sub
                3'b010: result = a & b;           // and
                3'b011: result = a | b;           // or
                3'b100: result = ($signed(a) < $signed(b)) ? 1 : 0; // slt
                default: result = 32'h00000000;
            endcase
            zero = (result == 32'h00000000);
        end
endmodule