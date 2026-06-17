`timescale 1ns / 1ps

module INSTRUCT_MEM
(
    input rst,
    input[31:0] addr,
    output[31:0] instruction
);

    reg[31:0] imem[255:0];
    
    assign instruction = imem[addr];
    
    initial begin
        $readmemb("/hosthome/fpga/vivado_projecrs/simple_risc_cpu_project/simple_risc_cpu_project.srcs/sources_1/imports/assembler/asm.txt", imem);
    end
endmodule
