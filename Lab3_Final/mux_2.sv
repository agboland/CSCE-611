/* 2 input mux */
module mux_2(

	input wire [31:0] a,
	input wire [31:0] b,
	input wire select,
	
	output wire [31:0] y

);

assign y = select ? b : a;

endmodule
