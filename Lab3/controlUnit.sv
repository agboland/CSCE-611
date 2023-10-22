/* Control Unit implementation */
module ControlUnit (
	
	 input wire [6:0] funct7,
	 input wire [11:0] imm12,
	 input wire [2:0] funct3,
	 input wire [6:0] opcode,

    output wire alusrc_EX,
	 output wire regwrite_EX,
	 output wire [1:0] regsel_EX,
	 output wire [3:0] aluop_EX,
	 output wire gpio_we
);


always_comb begin

    //May need to declare default values of outputs here
    //for always_comb to function correctly
	
	 if (opcode == 7'h33) begin 									//R-type instructions
	 
		if (funct7 == 7'h0 && funct3 == 3'h0) begin 				    //add
			aluop_EX = 4'h3;
		end else if (funct7 == 7'h20 && funct3 == 3'h0) begin		    //sub
			aluop_EX = 4'h4;
		end else if (funct7 == 7'h0 && funct3 == 3'h7) begin		    //and
			aluop_EX = 4'h0;
		end else if (funct7 == 7'h0 && funct3 == 3'h6) begin		    //or
			aluop_EX = 4'h1;
		end else if (funct7 == 7'h0 && funct3 == 3'h4) begin		    //xor
			aluop_EX = 4'h2;
		end else if (funct7 == 7'h0 && funct3 == 3'h1) begin		    //sll
			aluop_EX = 4'h8;
		end else if (funct7 == 7'h20 && funct3 == 3'h5) begin		    //sra
			//Not exactly sure what operation code this is...
            //Pretty sure this is a shift right arithmetic
		end else if (funct7 == 7'h0 && funct3 == 3'h5) begin		    //srl
			aluop_EX = 4'h9;
		end else if (funct7 == 7'h0 && funct3 == 3'h2) begin		    //slt
			aluop_EX = 4'hC;
		end else if (funct7 == 7'h0 && funct3 == 3'h3) begin		    //sltu
			aluop_EX = 4'hD;
		end else if (funct7 == 7'h1 && funct3 == 3'h0) begin		    //mul
			aluop_EX = 4'h5;
		end else if (funct7 == 7'h1 && funct3 == 3'h1) begin		    //mulh
			aluop_EX = 4'h6;
		end else if (funct7 == 7'h1 && funct3 == 3'h3) begin		    //mulhu
			aluop_EX = 4'h7;
		end

		alusrc_EX = 1'h0;
		regwrite_EX = 1'h1;
		regsel_EX = 2'h2;
		gpio_we = 1'h0;
	 
	 end else if (opcode == 7'h13) begin 						//I-type instructions
	 
	 end else if (opcode == 7'h73) begin 						//CSRRW instruction
	 
	 end else if (opcode == 7'h37)  begin 						//U-type instructions
	 
	 end
	
end

endmodule
