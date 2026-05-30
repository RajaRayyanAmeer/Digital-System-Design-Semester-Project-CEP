`timescale 1ns / 1ps
module instruction_memory (
    input wire [31:0] addr,
    output reg [31:0] instr
);
    // 1024 words of 32-bit instruction memory
    reg [31:0] mem [0:1023];
    integer i;
    // Initialize with a sample program (see section 6 for details)
    initial
        begin
            mem[0] = 32'h20080005;
            mem[1] = 32'h2009000A;
            mem[2] = 32'h012A5020;
            mem[3] = 32'h012A5822;
            mem[4] = 32'h01096024;
            mem[5] = 32'h01096825;
            mem[6] = 32'h0109702A;
            mem[7] = 32'hAD0A0000;
            mem[8] = 32'h8D070000;
            mem[9] = 32'h11290002;
            mem[10]= 32'h0800000C;
            mem[11]= 32'h00000020;   
            
            // fill rest with nop
            for (i=12; i<1024; i = i + 1)
                mem[i] = 32'h00000000;
        end
    
    always @(*)
        begin
            instr = mem[addr[11:2]];  // word-aligned access
        end
endmodule