`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:27 11/08/2021 
// Design Name: 
// Module Name:    square_root 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module square_root(
	output [15:0] out,
	input [7:0] in );

	reg[15:0] base;
	reg [15:0] y;
	reg [4:0] i;
	reg [31:0] in_aux; //pt comparare cu y*y
	
	always @(*) begin
		base = 16'b1000_0000_0000_0000;
		y = 16'b0000_0000_0000_0000;
		in_aux = in;
		in_aux = in_aux << 16;
		
		for (i = 0; i < 16; i = i + 1) begin
			y = y + base;
			
			if((y*y)>in_aux)
				y = y - base;
			
			base = base >> 1;
		end
	end
	
	assign out = y;
	
endmodule