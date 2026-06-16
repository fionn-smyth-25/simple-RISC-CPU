`timescale 1ns / 1ps

module top_level_cpu_tb;

    logic clk, rst;
    logic[31:0] instr, read_data, pc_out, write_data, alu_out;

    top_level_cpu uut (.clk(clk), .rst(rst),
                       .instr(instr), .read_data(read_data),
                       .pc_out(pc_out), .write_data(write_data), .alu_out(alu_out));

    //clk period (ns)
    parameter T = 10;
    
    //clk
    always begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    initial begin
        //initialize
        read_data = 32'b0;
        
        //test program
        //addi
        //          opcode rs    rt    imm
        //rt = rs + imm
        instr = 32'b001000_10001_10001_0000000000000111;
        
        //rst high for first 2 clk cycles
        rst = 1;
        repeat (2) @(posedge clk);
        
        rst = 0;
        @(posedge clk);
        
         #(T);
        //          opcode rs    rt    imm
        //rt = rs + imm
        instr = 32'b001000_10001_10001_0000000000000001;
        #(T);
        //          opcode rs    rt    imm
        //rt = rs + imm
        instr = 32'b001000_10001_10001_0000000000000001;
        #(T);
        //end test
        //no-op
        instr = 32'b0;
    end
                             
endmodule
