`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 02:34:56
// Design Name: 
// Module Name: fifo_top
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


module fifo_top #(parameter FIFO_WIDTH=32,FIFO_DEPTH=8)
        (wr_clk,rd_clk,wr_rst,rd_rst,wr_en,rd_en,write_data,read_data,full,empty);
        
input wr_clk,rd_clk,wr_rst,rd_rst,wr_en,rd_en;
input [FIFO_WIDTH-1:0] write_data;
output [FIFO_WIDTH-1:0] read_data;
output full,empty;

localparam PTR_WIDTH=$clog2(FIFO_DEPTH);


assign wr_enable=wr_en && ~full;
assign rd_enable=rd_en && ~empty;

wire rst=(wr_rst)?(wr_rst):rd_rst;
wire [PTR_WIDTH-1:0] wr_addr,rd_addr;
wire [PTR_WIDTH:0] rd_ptr_g,rd_ptr_g2,wr_ptr_g,wr_ptr_g2,rd_ptr_g1,wr_ptr_g1;

fifo_mem #(FIFO_WIDTH,FIFO_DEPTH,PTR_WIDTH) 
            ram (wr_clk,rd_clk,wr_rst,wr_enable,rd_enable,wr_addr,rd_addr,write_data,read_data);
            
read_ptr_empty #(PTR_WIDTH) rptr (rd_clk,rst,rd_en,wr_ptr_g2,empty,rd_addr,rd_ptr_g);

write_ptr_full #(PTR_WIDTH) wptr (wr_clk,wr_rst,wr_en,rd_ptr_g2,full,wr_addr,wr_ptr_g);

d_flip_flop #(PTR_WIDTH+1) sync_r2w1(wr_clk,wr_rst,rd_ptr_g,rd_ptr_g1);
d_flip_flop #(PTR_WIDTH+1) sync_r2w2(wr_clk,wr_rst,rd_ptr_g1,rd_ptr_g2);
d_flip_flop #(PTR_WIDTH+1) sync_w2r1(rd_clk,rst,wr_ptr_g,wr_ptr_g1);
d_flip_flop #(PTR_WIDTH+1) sync_w2r2(rd_clk,rst,wr_ptr_g1,wr_ptr_g2);

endmodule
