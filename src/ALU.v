`timescale 1ns / 1ps

module ALU
(
    input signed[7:0] a, b,
    input[2:0] fxn,
    output reg signed[7:0] c
);

    always @* begin
        case (fxn)
            3'b000: c = a + b; 
            3'b001: c = a - b; 
            3'b010: c = a & b; 
            3'b011: c = a | b; 
            3'b100: c = a; 
            default: c = 0;
        endcase
    end
endmodule
