/* Register implementation */

module register_5(

	input wire clk,
	input wire [4:0] in,
	//input wire we,
	
	output logic [4:0] out

);

always_ff @(posedge clk) begin
	out <= in;
end //End always_ff

endmodule
