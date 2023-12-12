/* 32 bit register */
module register_32s(

	input wire clk,
	input wire we,
	input wire [31:0] in,
	output logic [31:0] out
	
);

always_ff @(posedge clk) begin
	if(we) begin
		out <= in;
	end
end //End always_ff


endmodule
