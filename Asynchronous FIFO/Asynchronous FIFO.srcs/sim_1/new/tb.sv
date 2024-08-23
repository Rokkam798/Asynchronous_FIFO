`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2024 01:09:19
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb  #(parameter FIFO_WIDTH=32,FIFO_DEPTH=8)();

logic wr_clk=0,rd_clk=0,wr_en=0,rd_en=0,wr_rst=0,rd_rst=0;
logic full,empty;
logic [FIFO_WIDTH-1:0] write_data,read_data;

fifo_top #(FIFO_WIDTH,FIFO_DEPTH) fifo
(wr_clk,rd_clk,wr_rst,rd_rst,wr_en,rd_en,write_data,read_data,full,empty);

always #5 wr_clk=~wr_clk;
always #7 rd_clk=~rd_clk;

initial begin
    wr_clk = 1; wr_rst = 1; rd_rst = 1; rd_clk = 1;
 #6 wr_rst = 0; rd_rst = 0;
end

initial 
#9 wr_en = 1;

initial begin
    repeat(10) #10 write_data = $random;
    #10 wr_en=0;
end

initial #100 rd_en = 1; 

initial #300 $finish;

endmodule
