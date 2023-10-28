/* Sign extend module */
module SignExtend(

	input wire [11:0] in,
	
	output wire [31:0] out

);

//Get in[11] and add 20 to the output
assign out = { {20{in[11]}} , in};

endmodule
