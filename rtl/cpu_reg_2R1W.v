`timescale 1ns / 1ps

module cpu_reg_2R1W#(parameter w=8,parameter d=32)(
    input clk,rst,
    input [$clog2(d)-1:0]w_ad,
    input [$clog2(d)-1:0]r1_ad,
    input [$clog2(d)-1:0]r2_ad,
    input w_en,
    input [w-1:0]w_d,
    output wire [w-1:0]r1_d,
    output wire [w-1:0]r2_d
    );
    integer i;
    
    reg [w-1:0] cpu [d-1:0];
    
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            for(i=0;i<32;i=i+1) begin
                cpu[i]<=0;
            end
        end
        else if(w_en)
            cpu[w_ad]<=w_d;
    end
    
    assign r1_d= ((w_en==1'b1) && (r1_ad==w_ad)) ? w_d : cpu[r1_ad];
    assign r2_d= ((w_en==1'b1) && (r2_ad==w_ad)) ? w_d : cpu[r2_ad];
    
endmodule
