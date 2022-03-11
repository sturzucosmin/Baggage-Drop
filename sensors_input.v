`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:58:44 11/10/2021 
// Design Name: 
// Module Name:    sensors_input 
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
module sensors_input(
   output   [7 : 0]   height,
   input    [7 : 0]   sensor1,
   input    [7 : 0]   sensor2,
   input    [7 : 0]   sensor3,
   input    [7 : 0]   sensor4);
	
	reg [8:0] data_sum2;
   reg [9:0] data_sum4;
	reg [7:0] height_aux;

 	
	
	always @(*) begin
		height_aux = 0;
		data_sum4 = 0;
		data_sum2 = 0;
	
		if(sensor1 == 0 || sensor3 == 0) begin
			data_sum2 = sensor2 + sensor4;
		end else	if(sensor2 == 0 || sensor4 == 0) begin
			data_sum2 = sensor1 + sensor3;
		end else if(sensor1 != 0 && sensor2 != 0 && sensor3 != 0 && sensor4 != 0) begin
			data_sum4 = sensor1 + sensor2 + sensor3 + sensor4;
		end
		
		if(data_sum2 != 0) begin
			height_aux = data_sum2 >> 1; //impartirea la 2 
			if(data_sum2[0] == 1) begin // daca suma este impara => impartirea la 2 va da un rezultat de tipul "n,5" care se aproximeaza la "n+1"
				height_aux = height_aux + 1;
			end
		end else if(data_sum4 != 0) begin
			height_aux = data_sum4 >> 2; //impartirea la 4
			if(data_sum4[1] == 1) begin // daca (data_sum4 >> 1) este impar => impartirea la 4 va da un rezultat de tipul "n,5" care se aproximeaza la "n+1"
				height_aux = height_aux + 1;
			end
		end
		
	end
	
	assign height = height_aux;

endmodule
