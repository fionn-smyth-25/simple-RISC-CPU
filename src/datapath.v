`timescale 1ns / 1ps

module datapath
(   
    input clk, rst, pc_src, mem_to_reg, alu_src, reg_dst, reg_write, mem_write,
    input[2:0] alu_control,
    input[31:0] read_data, instr,
    output zero,
    output[31:0] pc_out, alu_out, write_data
);

    wire[31:0] r_d_2, src_1, src_2;
    wire[4:0] write_to_reg;
    assign write_data = r_d_2;
    
    PC pc (.clk(clk), .rst(rst), .jmp_en(1'b0), .jmp_addr(pc_src), .pc(pc_out));
    REG_FILE rf (.clk(clk), .rst(rst), .src_addr_1(instr[25:21]), .src_addr_2(instr[20:16]), 
                 .dest_addr(write_to_reg), .write_en(reg_write), .write_data(read_data), 
                 .reg_data_1(src_1), .reg_data_2(r_d_2));
    ALU alu (.a(src_1), .b(src_2), .fxn(alu_control), .c(alu_out));    
    
    //alu_src chooses between sign extended immediate and register value
    //allows r-type instructions
    mux m1 (.x(r_d_2), .y({{16{instr[15]}}, instr[15:0]}), .sel(alu_src), .z(src_2));
    
    //chooses which register to write data to
    mux m2 (.x(instr[20:16]), .y(instr[15:11]), .sel(reg_dst), .z(write_to_reg));
    
endmodule
