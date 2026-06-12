`timescale 1ns / 1ps
    
module REG_FILE_tb;

    logic clk, rst, we;
    logic[4:0] sa1, sa2, da;
    logic[31:0] wd, rd1, rd2;
    
    REG_FILE uut (.clk(clk), .rst(rst), .src_addr_1(sa1), .src_addr_2(sa2), .dest_addr(da), .write_en(we), .write_data(wd), 
                  .reg_data_1(rd1), .reg_data_2(rd2));
    
    //clk period (ns)
    parameter T = 10;
    
    //clk
    always begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    //----------helper functions----------
    //writes data to selected register
    task automatic write_reg
    (
        input[4:0] addr,
        input[31:0] data
    );
        begin      
            da = addr;
            wd = data;
        end
    endtask
    
    //reads from selected register
    task automatic read_reg
    (
        input[4:0] addr,
        output[31:0] data
    );
        begin 
            sa1 = addr;
            @(posedge clk);
            #1;
            data = rd1;
        end
    endtask
    
    //checks if register contains correct data
    task automatic check_reg
    (
        input[4:0] addr,
        input[31:0] expected_data
    );
        logic[31:0] actual_data;
        begin 
            read_reg(addr, actual_data);
            
        if (actual_data !== expected_data)
            $error("R%0d expected %h got %h",
                   addr, expected_data, actual_data);
        else
            $display("PASS R%0d = %h", addr, actual_data);          
        end
    endtask
    
    initial 
    begin
        //initialize
        we = 1'b0;
        sa1 = 5'b0;
        sa2 = 5'b1;
        da = 5'b0;
        wd = 32'b0;
        
        //rst high for first 2 clk cycles
        rst = 1;
        repeat (2) @(posedge clk);
        
        rst = 0;
        @(posedge clk);
        
        //confirm zero values and tests read functonality
        $display("----------Test 1: Reset Test----------");
        for (int i = 0; i < 32; i++) 
        begin
            check_reg(i, 32'd0);
        end
        
        //fill registers with index value and confirm value
        we = 1'b1;
        $display("----------Test 2: Write Test----------");
        for (int i = 0; i < 32; i++) 
        begin
            write_reg(i, i);
            repeat (2) @(posedge clk);
            check_reg(i, i);
            @(posedge clk);
        end  
        
        //rewrite values and confirm
        $display("----------Test 3: Overwrite Test----------");
        for (int i = 0; i < 32; i++) 
        begin
            write_reg(31 - i, i);
            repeat (2) @(posedge clk);
            check_reg(31 - i, i);
            @(posedge clk);
        end     
        we = 1'b0;
        
        $finish;
    end
    
endmodule

