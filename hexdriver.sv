//Written by: Collin Bollinger and Andrew Boland
module hexdriver (input [3:0] val, output logic [6:0] HEX);

	always_comb
		case (val)
			// abc_defg
			4'b0000: HEX = 7'b100_0000;
			4'b0001: HEX = 7'b111_1001;
			4'b0010: HEX = 7'b011_0000;
			4'b0011: HEX = 7'b101_1000;
			4'b0100: HEX = 7'b001_1001;
			4'b0101: HEX = 7'b001_0010;
			4'b0110: HEX = 7'b000_0010;
			4'b0111: HEX = 7'b111_1000;
			4'b1000: HEX = 7'b000_0000;
			4'b1001: HEX = 7'b001_1000;
			
			4'b1010: HEX = 7'b000_1000;
			4'b1011: HEX = 7'b000_0000;
			4'b1100: HEX = 7'b100_0110;
			4'b1101: HEX = 7'b100_0000;
			4'b1110: HEX = 7'b000_0110;
			4'b1111: HEX = 7'b000_1110;
			
			default: HEX = 7'b111_1111; // required
		endcase
	

endmodule
