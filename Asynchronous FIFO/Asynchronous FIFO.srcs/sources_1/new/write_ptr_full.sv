`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 18:57:49
// Design Name: 
// Module Name: write_ptr_full
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


module write_ptr_full #(parameter PTR_WIDTH)
(wr_clk,wr_rst,wr_en,rd_ptr_g2,full,wr_addr,wr_ptr_g);

input wr_clk,wr_rst,wr_en;
input [PTR_WIDTH:0]rd_ptr_g2;
output [PTR_WIDTH-1:0]wr_addr;
output [PTR_WIDTH:0]wr_ptr_g;
output full;

reg [PTR_WIDTH:0]wr_ptr_b;
wire [PTR_WIDTH:0]rd_ptr_b;
   
assign full=({~wr_ptr_b[PTR_WIDTH],wr_ptr_b[PTR_WIDTH-1:0]}==rd_ptr_b)?1:0;   
assign wr_addr=wr_ptr_b[PTR_WIDTH-1:0];

always_ff @(posedge wr_clk or posedge wr_rst) begin
    if (wr_rst) wr_ptr_b=0;   
    else if (wr_en&&~full) 
        wr_ptr_b=wr_ptr_b+1;
    else
        wr_ptr_b=wr_ptr_b;   
end    
    
binary_to_gray #(PTR_WIDTH+1) b2g(wr_ptr_b,wr_ptr_g);
gray_to_binary #(PTR_WIDTH+1) g2b(rd_ptr_g2,rd_ptr_b);
 
endmodule
