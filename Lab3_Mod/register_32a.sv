/* 32 bit register asynchronous*/
module register_32a(

	input wire clk,
	input wire [31:0] in,
	output reg [31:0] out
	
);

always_ff @(posedge clk) begin
	out = in;
end //End always_ff


endmodule
