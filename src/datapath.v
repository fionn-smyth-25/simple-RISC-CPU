`timescale 1ns / 1ps

module datapath
(   
    input clk, rst, pc_src, mem_to_reg, alu_src, reg_dst, reg_write, mem_write, jump,
    input[2:0] alu_control,
    input[31:0] read_data, instr,
    output[31:0] pc_out, alu_out, write_data
);

    wire[31:0] src_1, src_2, r_d_2, jmp_addr, signimm, result;
    wire[4:0] write_to_reg;
    assign write_data = r_d_2;
    assign signimm = {{16{instr[15]}}, instr[15:0]};
    
    PC pc (.clk(clk), .rst(rst), .jmp_en(pc_src), .jmp_addr(jmp_addr), .pc(pc_out));
    REG_FILE rf (.clk(clk), .rst(rst), .src_addr_1(instr[25:21]), .src_addr_2(instr[20:16]), 
                 .dest_addr(write_to_reg), .write_en(reg_write), .write_data(result), 
                 .reg_data_1(src_1), .reg_data_2(r_d_2));
    ALU alu (.a(src_1), .b(src_2), .fxn(alu_control), .c(alu_out));    
    
    //alu_src chooses between sign extended immediate and register value
    //allows r-type instructions
    mux #(32) m1 (r_d_2, signimm, alu_src, src_2);
    
    mux #(5) m2 (instr[20:16], instr[15:11], reg_dst, write_to_reg);
    
    mux #(32) m3 (alu_out, read_data, mem_to_reg, result);
    
    assign jmp_addr = signimm >> 2;
    
endmodule
