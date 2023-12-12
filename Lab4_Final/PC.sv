/* Program counter */
module PC (
	input wire clk,
	input wire rst_n,
	input wire [11:0] addr,
	
	output logic [11:0] PC_FETCH,
	output logic [11:0] PC_FETCH_1
);


	assign PC_FETCH_1 = PC_FETCH + 1;

	always_ff @(posedge clk) begin
		if(~rst_n) begin
			PC_FETCH <= 12'd0;
		end else begin //End IF begin Else
			PC_FETCH <= addr;
		end // End Else IF
	end //End always_ff

endmodule
