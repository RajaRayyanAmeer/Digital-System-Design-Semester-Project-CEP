`timescale 1ns / 1ps
module top_nexys (
    input wire clk_100MHz, reset_btn,
    input wire [4:0] sw,          // select register to display
    input wire show_btn,          // press to latch register value onto 7-seg
    output wire [15:0] led,
    output wire [7:0] seg, an
);
    wire reset_sync;
    wire [31:0] pc, alu_out, mem_data, reg_display;
    wire illegal, halt;
    reg [31:0] display_value;     // latched value to show on 7-seg
    
    // Synchronous reset
    reg [1:0] reset_sync_reg;
    always @(posedge clk_100MHz)
        reset_sync_reg <= {reset_sync_reg[0], reset_btn};
    
    assign reset_sync = reset_sync_reg[1];
    
    // Instantiate MIPS core with register selection
    mips_core core (.clk(clk_100MHz), .reset(reset_sync), .reg_sel(sw), // switches select register
                    .reg_display_out(reg_display), .pc_out(pc), .alu_result(alu_out),
                    .mem_read_data(mem_data), .write_data_to_mem(), .illegal_inst(illegal),
                    .halt(halt));
    
    // Latch the selected register's value when show_btn is pressed
    always @(posedge clk_100MHz or posedge reset_sync)
        begin
            if (reset_sync)
                display_value <= 32'h00000000;
            else if (show_btn)
                display_value <= reg_display;
        end
    
    // LEDs: show halt and illegal status + some debug info
    assign led[0] = halt;
    assign led[1] = illegal;
    assign led[15:2] = alu_out[13:0];   // optional: show ALU result
    
    // 7-segment shows the latched register value
    display_7seg disp (.clk(clk_100MHz), .value(display_value), .seg(seg), .an(an));
endmodule