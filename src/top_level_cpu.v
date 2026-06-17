`timescale 1ns / 1ps

module top_level_cpu
(
    input clk, rst,
    input[31:0] instr, read_data,
    output mem_write,
    output[31:0] pc_out, write_data, alu_out
);

    wire reg_write, reg_dst, alu_src, mem_to_reg, pc_src, jump;
    wire[2:0] alu_control;

    datapath dp (.clk(clk), .rst(rst), .pc_src(pc_src), .mem_to_reg(mem_to_reg), .alu_src(alu_src), .reg_dst(reg_dst), .reg_write(reg_write), .mem_write(mem_write), .jump(jump),
                 .alu_control(alu_control),
                 .read_data(read_data), .instr(instr),
                 .pc_out(pc_out), .alu_out(alu_out), .write_data(write_data));
                 
    CONTROL_UNIT cu (.instruction(instr),
                     .reg_write(reg_write), .mem_write(mem_write), .reg_dst(reg_dst), .alu_src(alu_src), .mem_to_reg(mem_to_reg), .pc_src(pc_src), .jump(jump),
                     .alu_control(alu_control));

endmodule
