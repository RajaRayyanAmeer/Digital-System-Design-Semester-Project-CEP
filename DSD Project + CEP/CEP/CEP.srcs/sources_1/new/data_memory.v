`timescale 1ns / 1ps
module data_memory (
    input wire clk, mem_read, mem_write,
    input wire [31:0] addr, write_data,
    output reg [31:0] read_data
);
    reg [31:0] mem [0:1023];
    integer i;
    initial
        for (i=0; i<1024; i=i+1)
            mem[i] = 32'h00000000;
    
    // combinational read
    always @(*)
        begin
            if (mem_read)
                read_data = mem[addr[11:2]];
            else
                read_data = 32'h00000000;
        end
    
    // synchronous write
    always @(posedge clk)
        begin
            if (mem_write)
                mem[addr[11:2]] <= write_data;
        end
endmodule