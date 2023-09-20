module hexdriver (input [3:0] val, output logic [6:0] HEX);

	always_comb
		case (val)
			// abc_defg
			4'b0000: HEX = 7'b100_0000; // 0
			4'b0001: HEX = 7'b111_1001; // 1
			4'b0010: HEX = 7'b011_0000; // 2
			4'b0011: HEX = 7'b101_1000; // 3
			4'b0100: HEX = 7'b001_1001; // 4
			4'b0101: HEX = 7'b001_0010; // 5
			4'b0110: HEX = 7'b000_0010; // 6
			4'b0111: HEX = 7'b111_1000; // 7
			4'b1000: HEX = 7'b000_0000; // 8
			4'b1001: HEX = 7'b001_1000; // 9
			
			4'b1010: HEX = 7'b000_1000; // A
			4'b1011: HEX = 7'b000_0000; // B
			4'b1100: HEX = 7'b100_0110; // C
			4'b1101: HEX = 7'b100_0000; // D
			4'b1110: HEX = 7'b000_0110; // E
			4'b1111: HEX = 7'b000_1110; // F
			
			default: HEX = 7'b111_1111; // required
		endcase
	
	
	
	
	
	/*module sevenseg(input logic [3:0] data,
						output logic [6:0] segments);
		always_comb
			case (data)
				// abc_defg
				4'd0: segments = 7'b111_1110;
				4'd1: segments = 7'b011_0000;
				4'd2: segments = 7'b110_1101;
				4'd3: segments = 7'b111_1001;
				4'd4: segments = 7'b011_0011;
				4'd5: segments = 7'b101_1011;
				4'd6: segments = 7'b101_1111;
				4'd7: segments = 7'b111_0000;
				4'd8: segments = 7'b111_1111;
				4'd9: segments = 7'b111_1011;
				default: segments = 7'b000_0000; // required
			endcase
	endmodule*/

endmodule
