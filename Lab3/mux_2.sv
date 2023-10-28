/* 2 input mux */
module mux_2(

	input wire a,
	input wire b,
	input wire select,
	
	output wire y

);

assign y = select ? b : a;

endmodule
