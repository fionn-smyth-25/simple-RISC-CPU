`timescale 1ns / 1ps

module ALU
(
    input signed[7:0] a, b,
    input[3:0] fxn,
    output reg signed[7:0] c
);

    always @* begin
        case (fxn)
            4'b0000: c = a + b; 
            4'b0001: c = a - b; 
            4'b0010: c = a & b; 
            4'b0011: c = a | b; 
            4'b0100: c = a;
            default: c = 0;
        endcase
    end
endmodule
