`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 02:39:15
// Design Name: 
// Module Name: binary_to_gray
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


module binary_to_gray #(parameter size)(binary, gray);

input [size-1:0] binary;
output reg [size-1:0] gray;

always_comb begin
    for (int i=0;i<=(size-1);i++) begin
        if (i<size-1) gray[i]=binary[i]^binary[i+1];
        else gray[size-1]=binary[size-1]; 
    end
end

endmodule
