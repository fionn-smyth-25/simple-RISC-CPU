`timescale 1ns / 1ps

module ALU_tb;

    reg[7:0] a_test, b_test, c_test;
    reg[2:0] fxn_test;
      
    ALU uut (.a(a_test), .b(b_test), .fxn(fxn_test), .c(c_test));
    
    
    initial begin
        for (int i = 0; i < 8; i++) begin
            fxn_test <= i;
            #(100);
        end    
    end
    
    always @ (fxn_test) begin
        a_test = 8'h4;
        b_test = 8'h3;
        #(25);
        a_test = 8'h5;
        b_test = 8'h5;
        #(25);
        a_test = 8'h0;
        b_test = 8'h1;
        #(25);
        a_test = 8'hFF;
        b_test = 8'h20;
    end
    
endmodule
