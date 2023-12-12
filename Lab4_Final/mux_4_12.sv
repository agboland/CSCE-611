/* 4 input mux 12 bits wide */
module mux_4_12(

	input wire [11:0] a,
	input wire [11:0] b,
	input wire [11:0] c,
	input wire [11:0] d,
	input wire [1:0] select,
	
	output wire [11:0] y

);

assign y = select == 2'b00 ? a : 
					select == 2'b01 ? b : 
						select == 2'b10 ? c : d;

endmodule
