`timescale 1ns / 1ps
module register_file (
    input wire clk, reg_write,
    input wire [4:0] read_reg1, read_reg2, write_reg,
    input wire [31:0] write_data,
    output reg [31:0] read_data1, read_data2
);
    reg [31:0] regs [0:31];
    integer i;
    
    initial
        begin
            for (i=0; i<32; i=i+1)
                regs[i] = 32'h00000000;
        end
    
    always @(*)
        begin
            read_data1 = (read_reg1 == 5'b0) ? 32'h00000000 : regs[read_reg1];
            read_data2 = (read_reg2 == 5'b0) ? 32'h00000000 : regs[read_reg2];
        end
    
    always @(posedge clk)
        begin
            if (reg_write && write_reg != 5'b0)
                regs[write_reg] <= write_data;
        end
endmodule