`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 18:57:31
// Design Name: 
// Module Name: read_ptr_empty
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


module read_ptr_empty #(parameter PTR_WIDTH)
(rd_clk,rd_rst,rd_en,wr_ptr_g2,empty,rd_addr,rd_ptr_g);

input rd_clk,rd_rst,rd_en;
input [PTR_WIDTH:0]wr_ptr_g2;
output [PTR_WIDTH-1:0]rd_addr;
output [PTR_WIDTH:0]rd_ptr_g;
output empty;

reg [PTR_WIDTH:0]rd_ptr_b;
wire [PTR_WIDTH:0]wr_ptr_b;
    
assign empty=(wr_ptr_g2==0||wr_ptr_b==rd_ptr_b);    
assign rd_addr=rd_ptr_b[PTR_WIDTH-1:0];

always_ff @(posedge rd_clk or posedge rd_rst) begin
    if (rd_rst) rd_ptr_b=0;   
    else if (rd_en&&~empty) 
        rd_ptr_b=rd_ptr_b+1;
    else
        rd_ptr_b=rd_ptr_b;   
end      
    
binary_to_gray #(PTR_WIDTH+1) b2g(rd_ptr_b,rd_ptr_g);
gray_to_binary #(PTR_WIDTH+1) g2b(wr_ptr_g2,wr_ptr_b);
 
endmodule
