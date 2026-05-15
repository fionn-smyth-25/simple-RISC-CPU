`timescale 1ns / 1ps

module INSTRUCT_MEM
(
    input[7:0] addr,
    output[15:0] instruction
);

    reg[15:0] imem[255:0];
    
    assign instruction = imem[addr];
endmodule
