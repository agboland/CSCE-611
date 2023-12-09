/* Register implementation */

module register_1(
	
	input wire clk,
	input wire in,
	//input wire we,
	
	output logic out

);

always_ff @(posedge clk) begin
//	if(we) begin
//			out = in;
//	end
	out = in;
end //End always_ff

endmodule
