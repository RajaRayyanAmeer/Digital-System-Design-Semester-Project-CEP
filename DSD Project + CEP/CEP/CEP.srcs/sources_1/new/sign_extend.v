`timescale 1ns / 1ps
module sign_extend (
    input wire [15:0] imm16,
    output reg [31:0] imm32
);
    always @(*)
        imm32 = {{16{imm16[15]}}, imm16};
endmodule