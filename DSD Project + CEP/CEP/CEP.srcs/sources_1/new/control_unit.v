`timescale 1ns / 1ps
module control_unit (
    input wire [5:0] opcode,
    output reg reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, jump,
    output reg [1:0] alu_op,
    output reg illegal   // error detection
);
    always @(*)
        begin
            // default values
            reg_dst = 1'b0;
            alu_src = 1'b0;
            mem_to_reg = 1'b0;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            alu_op = 2'b00;
            illegal = 1'b0;
        
            case (opcode)
                6'b000000:
                begin  // R-type
                    reg_dst = 1'b1;
                    reg_write = 1'b1;
                    alu_op = 2'b10;
                end
            
                6'b001000:
                begin  // addi
                    alu_src = 1'b1;
                    reg_write = 1'b1;
                    alu_op = 2'b00;
                end
    
                6'b100011:
                begin  // lw
                    alu_src = 1'b1;
                    mem_to_reg = 1'b1;
                    reg_write = 1'b1;
                    mem_read = 1'b1;
                    alu_op = 2'b00;
                end
                
                6'b101011:
                begin  // sw
                    alu_src = 1'b1;
                    mem_write = 1'b1;
                    alu_op = 2'b00;
                end
                
                6'b000100:
                begin  // beq
                    branch = 1'b1;
                    alu_op = 2'b01;
                end
                
                6'b000010:
                begin  // j
                    jump = 1'b1;
                end
            
                default: illegal = 1'b1;
            endcase
        end
endmodule