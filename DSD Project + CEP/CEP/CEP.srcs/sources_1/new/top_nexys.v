`timescale 1ns / 1ps
module top_nexys (
    input wire clk_100MHz,      // onboard clock
    input wire reset_btn,       // center button (active high)
    input wire [4:0] sw,        // 5 switches to select register
    input wire show_btn,        // optional: press to update display (or auto)
    output wire [15:0] led,     // 16 LEDs
    output wire [7:0] seg,      // 7-segment segments
    output wire [7:0] an        // 7-segment anodes
);
    wire reset_sync;
    reg [31:0] reg_value;
    wire [31:0] pc, alu_out, mem_data, wb_data;
    wire illegal, halt;
    
    // Synchronous reset (avoid metastability)
    reg [1:0] reset_sync_reg;
    always @(posedge clk_100MHz)
        reset_sync_reg <= {reset_sync_reg[0], reset_btn};
    
    assign reset_sync = reset_sync_reg[1];
    
    // Instantiate MIPS core
    mips_core core (
        .clk(clk_100MHz),
        .reset(reset_sync),
        .pc_out(pc),
        .alu_result(alu_out),
        .mem_read_data(mem_data),
        .write_data_to_mem(wb_data),
        .illegal_inst(illegal),
        .halt(halt)
    );
    
    // Select which register to display on 7-seg (using switches)
    reg [31:0] register_display;
    
    always @(posedge clk_100MHz or posedge reset_sync)
        begin
            if (reset_sync)
                register_display <= 32'h00000000;
            else if (show_btn)   // or just always refresh – we'll do auto
                register_display <= reg_value;
            else
                register_display <= register_display;
        end
    
    assign led[0] = halt;
    assign led[1] = illegal;
    assign led[15:2] = alu_out[13:0];   // simple status
    
    // For demonstration, we show PC value:
    display_7seg disp (.clk(clk_100MHz), .value(pc), .seg(seg), .an(an));
endmodule