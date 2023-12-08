/* Register implementation */

module register_2(

	input wire clk,
	input wire [1:0] in,
	//input wire we,
	
	output reg [1:0] out

);

always_ff @(posedge clk) begin
//	if(we) begin
//			out = in;
//	end
	out = in;
end //End always_ff
endmodule
