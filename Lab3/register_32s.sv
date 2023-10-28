/* 32 bit register */
module register_32s(

	input wire clk,
	input wire we,
	input wire [1:0] in,
	output wire [1:0] out
	
);

always_ff @(posedge clk) begin
	if(we) begin
		out = in;
	end
end //End always_ff


endmodule
