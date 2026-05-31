`timescale 1ns/1ps
module mips_tb;
    reg clk, reset;
    reg [4:0] reg_sel;           // NEW: select register for display (unused in sim)
    wire [31:0] pc, alu_out, reg_display;
    wire illegal, halt;
    
    // Instantiate the modified mips_core
    mips_core uut (
        .clk(clk),
        .reset(reset),
        .reg_sel(reg_sel),          // connect to a driver
        .reg_display_out(reg_display),
        .pc_out(pc),
        .alu_result(alu_out),
        .mem_read_data(),
        .write_data_to_mem(),
        .illegal_inst(illegal),
        .halt(halt)
    );
    
    always #5 clk = ~clk;   // 100 MHz clock
    
    initial
        begin
            $dumpfile("mips_tb.vcd");
            $dumpvars(0, mips_tb);
            clk = 0;
            reset = 1;
            reg_sel = 5'b00000;    // default to register 0
            #15 
            reset = 0;
            #500
            $finish();
        end
    
    initial
        begin
            $monitor("Time=%0t PC=%h ALU_out=%h Illegal=%b Halt=%b Reg_display=%h",
                $time, pc, alu_out, illegal, halt, reg_display);
        end
endmodule