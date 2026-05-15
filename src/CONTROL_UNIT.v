`timescale 1ns / 1ps

module CONTROL_UNIT
(
    input[15:0] instruction,
    output reg reg_write, mem_read, mem_write,
    output reg[2:0] alu_op
);

    //decoder
    wire[3:0] opcode = instruction[15:12];
    wire[1:0] register_dest = instruction[11:10];
    wire[1:0] register_source = instruction[9:8];
    wire[7:0] immediate = instruction[7:0];
    
    always @* begin
        reg_write = 0;
        mem_read = 0;
        mem_write= 0;
        alu_op    = 2'b00;
        
        case (opcode)
            4'b0000: begin //ADD
                alu_op = 3'b000;
            end
            4'b0001: begin //SUB
                alu_op = 3'b001;
            end       
            4'b0010: begin //AND
                alu_op = 3'b010;
            end
            4'b0010: begin //OR
                alu_op = 3'b011;
            end
            4'b0011: begin //ADDI
                alu_op = 3'b000;
            end           
            4'b0100: begin //MOVI
                alu_op = 3'b111;
            end
            4'b0101: begin //JMP
                alu_op = 3'b000;
            end 
        endcase
    end
endmodule
