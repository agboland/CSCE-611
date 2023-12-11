/* Register implementation */

module register_12(

	input wire clk,
	input wire [11:0] in,
	//input wire we,
	
	output logic [11:0] out

);

always_ff @(posedge clk) begin
	out = in;
end //End always_ff
endmodule
