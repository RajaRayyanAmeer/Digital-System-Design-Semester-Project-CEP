`timescale 1ns / 1ps
module display_7seg (
    input wire clk,               // 100 MHz board clock
    input wire [31:0] value,      // 32-bit value to show
    output reg [7:0] seg,         // segments (active low)
    output reg [7:0] an           // 8-digit anode enables (active low)
);
    reg [16:0] counter;          // refresh clock divider
    reg [2:0] digit_sel;         // 0..7
    reg [3:0] hex_digit;
    
    // Select current digit value
    always @(*)
        begin
            case (digit_sel)
                3'd0: hex_digit = value[3:0];
                3'd1: hex_digit = value[7:4];
                3'd2: hex_digit = value[11:8];
                3'd3: hex_digit = value[15:12];
                3'd4: hex_digit = value[19:16];
                3'd5: hex_digit = value[23:20];
                3'd6: hex_digit = value[27:24];
                3'd7: hex_digit = value[31:28];
                default: hex_digit = 4'h0;
            endcase
        end
    
    // 7-segment decoder (active low)
    always @(*)
        begin
            case (hex_digit)
                4'h0: seg = 8'b10000000; // 0
                4'h1: seg = 8'b11110011; // 1
                4'h2: seg = 8'b01001001; // 2
                4'h3: seg = 8'b01100000; // 3
                4'h4: seg = 8'b00110011; // 4
                4'h5: seg = 8'b00100100; // 5
                4'h6: seg = 8'b00000100; // 6
                4'h7: seg = 8'b11110000; // 7
                4'h8: seg = 8'b00000000; // 8
                4'h9: seg = 8'b00100000; // 9
                4'hA: seg = 8'b00001000; // A
                4'hB: seg = 8'b00000011; // b
                4'hC: seg = 8'b10000110; // C
                4'hD: seg = 8'b01000001; // d
                4'hE: seg = 8'b00000110; // E
                4'hF: seg = 8'b00001110; // F
                default: seg = 8'b11111111;
            endcase
        end
    
    // Refresh counter and anode selector
    always @(posedge clk)
        begin
            counter <= counter + 1;
            if (counter == 17'd100000)
                begin   // ~1 kHz refresh
                    counter <= 0;
                    digit_sel <= digit_sel + 1;
                end
        end
    
    // Anode decoding (active low)
    always @(*)
        begin
            an = 8'b11111111;
            an[digit_sel] = 1'b0;
        end
endmodule