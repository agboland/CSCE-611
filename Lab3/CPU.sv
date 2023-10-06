module CPU (
    input logic clk,
    input logic rst_n
);

	logic [31:0] inst_ram [4095:0];
	initial $readmemh ("instmem.dat",inst_ram);
	
	logic [11:0] PC_FETCH = 12'd0;
	logic [31:0] instruction_EX;
	
	always_ff @(posedge clk) begin
		if(~rst_n) begin
			PC_FETCH <= 12'd0;
			instruction_EX <- 32'd0;
		end else begin //End IF begin Else
			PC_FETCH <= PC_FETCH + 1'b1;
			instruction_EX <- inst_ram[PC_FETCH];
		end // End Else IF
	end //End always_ff

endmodule // End CPU Module

