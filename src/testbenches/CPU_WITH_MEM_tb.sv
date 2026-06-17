`timescale 1ns / 1ps

module CPU_WITH_MEM_tb;

    logic clk, rst;
    
    CPU_WITH_MEM cpu (.clk(clk), .rst(rst));
    
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
        
        //rst high for first 2 clk cycles
        rst = 1;
        repeat (2) @(posedge clk);
        
        rst = 0;
        @(posedge clk);
        
    end
    

endmodule
