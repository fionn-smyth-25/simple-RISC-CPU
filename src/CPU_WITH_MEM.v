`timescale 1ns / 1ps

module CPU_WITH_MEM
(
    input clk, rst
);

    wire[31:0] instr, pc_out, alu_out, write_data, read_data, mem_write;

    top_level_cpu tlc (.clk(clk), .rst(rst),
                       .instr(instr), .read_data(read_data),
                       .mem_write(mem_write),
                       .pc_out(pc_out), .write_data(write_data), .alu_out(alu_out));
                       
    DATA_MEM dmem (.clk(clk), .rst(rst), .write_en(mem_write),
                   .addr(alu_out), .write_data(write_data),
                   .read_data(read_data));
                   
    INSTRUCT_MEM imem (.rst(rst), 
                       .addr(pc_out),
                       .instruction(instr));
    
endmodule