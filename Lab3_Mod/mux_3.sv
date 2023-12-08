/* 3 input mux */
module mux_3(

	input wire [31:0] a,
	input wire [31:0] b,
	input wire [31:0] c,
	input wire [1:0] select,
	
	output wire [31:0] y

);

assign y = select == 2'b00 ? a : 
					select == 2'b01 ? b : c;

endmodule
