`timescale 1ns / 1ps

module mux
(
    input x, y, sel,
    output z
);

    wire g0, g1, g2;
    not e0 (g0, sel);
    and e1 (g1, x, g0);
    and e2 (g2, y, sel);
    or e3 (z, g1, g2);

endmodule
