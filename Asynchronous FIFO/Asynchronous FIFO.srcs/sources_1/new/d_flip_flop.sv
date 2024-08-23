`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 22:59:10
// Design Name: 
// Module Name: d_flip_flop
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


module d_flip_flop #(parameter size) (clk,rst,data_in,data_out);
input clk,rst;
input [size-1:0]data_in;
output reg [size-1:0]data_out;

always_ff @(posedge clk or posedge rst) begin
    if (rst) data_out<=0;
    else data_out<=data_in;
end

endmodule
