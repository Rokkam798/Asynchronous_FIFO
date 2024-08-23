`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 02:33:42
// Design Name: 
// Module Name: gray_to_binary
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


module gray_to_binary #(parameter size)(gray, binary);

input [size-1:0] gray;
output reg [size-1:0] binary;

always_comb begin
    for (int i=(size-1);i>=0;i=i-1) begin
        if (i==size-1) binary[size-1]=gray[size-1];
        else binary[i]=gray[i]^binary[i+1];
    end
end


endmodule
