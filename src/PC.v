`timescale 1ns / 1ps

module PC
(
    input clk, rst, jmp_en,
    input[31:0] jmp_addr,
    output reg[31:0] pc
);

    always @ (posedge clk) begin
        if (rst) begin
            pc <= 0;
        end
        else if (jmp_en) begin
            pc <= jmp_addr;
        end
        else if (pc > 255) begin
            pc <= 0;
        end
        else begin
            pc <= pc + 1;
        end     
    end   
endmodule
