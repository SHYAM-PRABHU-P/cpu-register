`timescale 1ns / 1ps

module cpu_reg_2R1W_tb();
    reg clk=1;
    reg rst;
    reg [4:0]w_ad;
    reg [4:0]r1_ad;
    reg [4:0]r2_ad;
    reg [7:0]w_d;
    reg w_en;
    wire [7:0]r1_d;
    wire [7:0]r2_d;
    integer i;
    
    //reg [7:0]wr;
    
    cpu_reg_2R1W #(.W(8),.d(32)) uut (.clk(clk),.rst(rst),.w_ad(w_ad),.w_en(w_en),.w_d(w_d),.r1_ad(r1_ad),
                                        .r2_ad(r2_ad),.r1_d(r1_d),.r2_d(r2_d));
                                        
    always begin
        clk=~clk;#0.5;
    end 
    
    task write (input [4:0]ad,input [7:0]data);
        begin
            @(posedge clk);
            w_en=1;
            w_ad=ad;
            w_d=data;
            @(posedge clk);
            w_en=0;
        end
    endtask
    
    task read_1(input [4:0] ad);
        begin
            @(posedge clk);
            r1_ad=ad;
        end
    endtask 
    
    task read_2(input [4:0] ad);
        begin
            @(posedge clk);
            r2_ad=ad;
        end
    endtask 
    
    initial begin
        $monitor("ADDRESS=%0d,DATA=%0d",w_ad,w_d);
        $monitor("ADDRESS_1=%0d,READ_DATA_1=%0d",r1_ad,r1_d);
        $monitor("ADDRESS_2=%0d,READ_DATA_2=%0d",r2_ad,r2_d);
        rst=0;
        @(posedge clk);
        rst=1;
        $display("/////////////Write/////////////");
        for(i=0;i<32;i=i+1) begin
            
            write(i,$random());
        end
        $display("/////////////Read/////////////");
        read_1(2);
        read_2(3);
        
        
    end
endmodule
