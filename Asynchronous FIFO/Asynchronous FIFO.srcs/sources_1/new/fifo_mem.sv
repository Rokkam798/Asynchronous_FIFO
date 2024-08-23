`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 18:54:12
// Design Name: 
// Module Name: fifo_mem
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


module fifo_mem #(parameter FIFO_WIDTH,FIFO_DEPTH,PTR_WIDTH)
(wr_clk,rd_clk,rst,wr_enable,rd_enable,wr_addr,rd_addr,write_data,read_data);

input wr_clk,rd_clk,rst,wr_enable,rd_enable;
input [PTR_WIDTH-1:0]wr_addr,rd_addr;
input [FIFO_WIDTH-1:0] write_data;
output reg[FIFO_WIDTH-1:0] read_data;

reg [FIFO_DEPTH-1:0][FIFO_WIDTH-1:0]mem;

always_ff @(posedge wr_clk or posedge rst) begin
    if (rst) begin
        for (int i=0;i<FIFO_DEPTH;i++)
        mem[i]=0;
    end
    else if (wr_enable)
        mem[wr_addr]=write_data;
end

always_ff @(posedge rd_clk) begin
    if (rd_enable)
        read_data=mem[rd_addr];
end

endmodule
