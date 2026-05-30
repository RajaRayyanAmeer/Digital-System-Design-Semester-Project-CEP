`timescale 1ns / 1ps
module mips_core (
    input wire clk, reset,
    output wire [31:0] pc_out, alu_result, mem_read_data, write_data_to_mem,
    output reg illegal_inst,
    output reg halt         // optional: becomes 1 when program finishes
);
    wire [31:0] pc, next_pc, instr;
    wire [31:0] read_data1, read_data2, imm32, alu_in2, alu_out, mem_readdata;
    wire [4:0] write_reg;
    wire [2:0] alu_ctrl;
    wire zero;
    wire reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, jump;
    wire [1:0] alu_op;
    wire illegal_ctrl;
    
    // PC
    pc pc_inst (.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc));
    
    // Instruction Memory
    instruction_memory imem (.addr(pc), .instr(instr));
    
    // Control Unit
    control_unit cu (.opcode(instr[31:26]), .reg_dst(reg_dst), .alu_src(alu_src),
                     .mem_to_reg(mem_to_reg), .reg_write(reg_write), .mem_read(mem_read),
                     .mem_write(mem_write), .branch(branch), .jump(jump), .alu_op(alu_op),
                     .illegal(illegal_ctrl));
    
    // Register File
    register_file rf (.clk(clk), .reg_write(reg_write),
                      .read_reg1(instr[25:21]), .read_reg2(instr[20:16]),
                      .write_reg(write_reg), .write_data(mem_to_reg ? mem_readdata : alu_out),
                      .read_data1(read_data1), .read_data2(read_data2));
    
    assign write_reg = reg_dst ? instr[15:11] : instr[20:16];
    
    // Sign Extend & ALU Mux
    sign_extend sext (.imm16(instr[15:0]), .imm32(imm32));
    assign alu_in2 = alu_src ? imm32 : read_data2;
    
    // ALU Control
    alu_control alu_ctrl_inst (.alu_op(alu_op), .funct(instr[5:0]), .alu_control(alu_ctrl));
    alu alu_inst (.a(read_data1), .b(alu_in2), .alu_control(alu_ctrl),
                  .result(alu_out), .zero(zero));
    
    // Data Memory
    data_memory dmem (.clk(clk), .mem_read(mem_read), .mem_write(mem_write),
                      .addr(alu_out), .write_data(read_data2), .read_data(mem_readdata));
    
    // Next PC Logic
    wire [31:0] pc_plus4 = pc + 4;
    wire [31:0] branch_target = pc_plus4 + (imm32 << 2);
    wire [31:0] jump_target = {pc_plus4[31:28], instr[25:0], 2'b00};
    wire branch_taken = branch & zero;
    
    assign next_pc = jump ? jump_target :
                     (branch_taken ? branch_target : pc_plus4);
    
    // Outputs for Debugging / Display
    assign pc_out = pc;
    assign alu_result = alu_out;
    assign mem_read_data = mem_readdata;
    assign write_data_to_mem = read_data2;
    
    // Illegal instruction detection and halt (simple counter stop)
    always @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    illegal_inst <= 1'b0;
                    halt <= 1'b0;
                end
            else if (illegal_ctrl)
                begin
                    illegal_inst <= 1'b1;
                    halt <= 1'b1;
                end
            else if (pc == 32'h0000002C)
                begin   // example end address
                    halt <= 1'b1;
                end
        end
endmodule