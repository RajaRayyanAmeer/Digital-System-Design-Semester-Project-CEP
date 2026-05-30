`timescale 1ns/1ps
module mips_tb;
    reg clk, reset;
    wire [31:0] pc, alu_out;
    wire illegal, halt;
    
    mips_core uut (
        .clk(clk), .reset(reset),
        .pc_out(pc), .alu_result(alu_out),
        .mem_read_data(), .write_data_to_mem(),
        .illegal_inst(illegal), .halt(halt)
    );
    
    always #5 clk = ~clk;   // 100 MHz clock
    
    initial
        begin
            $dumpfile("mips_tb.vcd");
            $dumpvars(0, mips_tb);
            clk = 0;
            reset = 1;
            #15 reset = 0;
            #500
            $finish();
        end
    
    initial
        begin
            $monitor("Time=%0t PC=%h ALU_out=%h Illegal=%b Halt=%b", $time, pc, alu_out, illegal, halt);
        end
endmodule