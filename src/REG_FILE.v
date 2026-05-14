`timescale 1ns / 1ps

module REG_FILE
(
    input clk, write_en,
    input[2:0] read_src_1, read_src_2, reg_dest,
    input[7:0] write_data,
    output[7:0] reg_data_1, reg_data_2 
);

    //8 registers each 8 bits wide
    reg[7:0] regs[0:7];
    
    //load data from up to two selected registers
    assign reg_data_1 = regs[read_src_1];
    assign reg_data_2 = regs[read_src_2];
    
    //write data to selected register
    always @(posedge clk) begin
        if (write_en) begin
            regs[reg_dest] <= write_data;
        end
    end
endmodule
