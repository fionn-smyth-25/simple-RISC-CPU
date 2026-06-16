`timescale 1ns / 1ps

module INSTRUCT_MEM
(
    input[31:0] addr,
    output[31:0] instruction
);

    reg[31:0] imem[255:0];
    
    assign instruction = imem[addr];
endmodule
