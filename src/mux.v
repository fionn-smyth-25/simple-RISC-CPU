`timescale 1ns / 1ps

//parametrizable mux
//sel = 0 : z = x
//sel = 1 : z = y
module mux
#(parameter WIDTH = 32)
(
    input[WIDTH-1:0] x, y,
    input sel,
    output[WIDTH-1:0] z
);

    assign z = sel ? y : x;

endmodule
