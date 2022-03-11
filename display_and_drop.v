`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:22:21 11/10/2021 
// Design Name: 
// Module Name:    display_and_drop 
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
module display_and_drop(
    output   [6 : 0]   seven_seg1, 
    output   [6 : 0]   seven_seg2,
    output   [6 : 0]   seven_seg3,
    output   [6 : 0]   seven_seg4,
    output   [0 : 0]   drop_activated,
    input    [15: 0]   t_act,
    input    [15: 0]   t_lim,
    input              drop_en);
	 
	 reg [0:0] drop_activated_aux;
	 
	 reg [6:0] seven_seg1_aux; 
    reg [6:0] seven_seg2_aux;
    reg [6:0] seven_seg3_aux;
    reg [6:0] seven_seg4_aux;
	 
	 //pentru reprezentare literelor 
	 reg [6:0] D = 7'b1011110;
	 reg [6:0] R = 7'b1010000; 
	 reg [6:0] O = 7'b1011100;
	 reg [6:0] P = 7'b1110011;
	 reg [6:0] C = 7'b0111001;
	 reg [6:0] L = 7'b0111000;
	 reg [6:0] H = 7'b1110110;
	 reg [6:0] T = 7'b1111000;
	 
	 always @(*) begin

		if (t_act < t_lim && drop_en == 0) begin
			drop_activated_aux = 0;
			seven_seg1_aux = C;
			seven_seg2_aux = O;
			seven_seg3_aux = L;
			seven_seg4_aux = D;			
		end else if (t_act < t_lim && drop_en == 1) begin
			drop_activated_aux = 1;
			seven_seg1_aux = D;
			seven_seg2_aux = R;
			seven_seg3_aux = O;
			seven_seg4_aux = P;
		end else if (t_act > t_lim && drop_en == 1) begin
			drop_activated_aux = 0;
			seven_seg1_aux = 0;
			seven_seg2_aux = H;
			seven_seg3_aux = O;
			seven_seg4_aux = T;
		end
		
	 end
	 
	 assign drop_activated = drop_activated_aux;
	 assign seven_seg1 = seven_seg1_aux;	 
	 assign seven_seg2 = seven_seg2_aux;	 
	 assign seven_seg3 = seven_seg3_aux;
	 assign seven_seg4 = seven_seg4_aux;	 
	 
endmodule
