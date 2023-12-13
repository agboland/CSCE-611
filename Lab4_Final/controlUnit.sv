/* Control Unit implementation */
module controlUnit (
	
	 input wire [6:0] funct7,
	 input wire [11:0] imm12,
	 input wire [2:0] funct3,
	 input wire [6:0] opcode,
	 input wire stall_EX,
	 input wire zero,

    output logic alusrc_EX,
	 output logic regwrite_EX,
	 output logic [1:0] regsel_EX,
	 output logic [3:0] aluop_EX,
	 output logic gpio_we,
	 output logic [1:0] pcsrc_EX,
	 output logic stall_FETCH
);


always_comb begin
	
	alusrc_EX = 1'h0;
	regwrite_EX = stall_EX ? 1'h0 : 1'h1;
	regsel_EX = 2'h2;
	gpio_we = 1'h0;
	aluop_EX = 4'h0;
	pcsrc_EX = 2'h0;
	stall_FETCH = 1'h0;
	
	
	//R-type instructions
	 if (opcode == 7'h33 && funct7 == 7'h0 && funct3 == 3'h0) begin 							//add
		aluop_EX = 4'h3;
	 end else if (opcode == 7'h33 && funct7 == 7'h20 && funct3 == 3'h0) begin 				//sub
		aluop_EX = 4'h4;
	 end else if (opcode == 7'h33 && funct7 == 7'h0 && funct3 == 3'h7) begin 				//and
		aluop_EX = 4'h0;
	 end else if (opcode == 7'h33 && funct7 == 7'h0 && funct3 == 3'h6) begin 				//or
		aluop_EX = 4'h1;
	 end else if (opcode == 7'h33 && funct7 == 7'h0 && funct3 == 3'h4) begin 				//xor
		aluop_EX = 4'h2;
	 end else if (opcode == 7'h33 && funct7 == 7'h0 && funct3 == 3'h1) begin 				//sll
		aluop_EX = 4'h8;
	 end else if (opcode == 7'h33 && funct7 == 7'h20 && funct3 == 3'h5) begin 				//sra
		aluop_EX = 4'hA;
	 end else if (opcode == 7'h33 && funct7 == 7'h0 && funct3 == 3'h5) begin 				//srl
		aluop_EX = 4'h9;
	 end else if (opcode == 7'h33 && funct7 == 7'h0 && funct3 == 3'h2) begin 				//slt
		aluop_EX = 4'hC;
	 end else if (opcode == 7'h33 && funct7 == 7'h0 && funct3 == 3'h3) begin 				//sltu
		aluop_EX = 4'hD;
	 end else if (opcode == 7'h33 && funct7 == 7'h1 && funct3 == 3'h0) begin 				//mul
		aluop_EX = 4'h5;
	 end else if (opcode == 7'h33 && funct7 == 7'h1 && funct3 == 3'h1) begin 				//mulh
		aluop_EX = 4'h6;
	 end else if (opcode == 7'h33 && funct7 == 7'h1 && funct3 == 3'h3) begin 				//mulhu
		aluop_EX = 4'h7;
	 
	 
	 //I-type instructions
	 end else if  (opcode == 7'h13 && funct3 == 3'h0) begin 									   //addi
		alusrc_EX = 1'h1;
		aluop_EX = 4'h3;
	 end else if  (opcode == 7'h13 && funct3 == 3'h7) begin 										//andi
		alusrc_EX = 1'h1;
		aluop_EX = 4'h0;
	 end else if  (opcode == 7'h13 && funct3 == 3'h6) begin 										//ori
		alusrc_EX = 1'h1;
		aluop_EX = 4'h1;
	 end else if  (opcode == 7'h13 && funct3 == 3'h4) begin 										//xori
		alusrc_EX = 1'h1;
		aluop_EX = 4'h2;
	 end else if  (opcode == 7'h13 && funct3 == 3'h1 && funct7 == 7'h0) begin 				//slli
		alusrc_EX = 1'h1;
		aluop_EX = 4'h8;
	 end else if  (opcode == 7'h13 && funct3 == 3'h5 && funct7 == 7'h20) begin 			//srai
		alusrc_EX = 1'h1;
		aluop_EX = 4'hA;
	 end else if  (opcode == 7'h13 && funct3 == 3'h5 && funct7 == 7'h0) begin 				//srli
		alusrc_EX = 1'h1;
		aluop_EX = 4'h9;
	 end else if (opcode == 7'h67 && funct3 == 3'h0) begin										//jalr
		pcsrc_EX = 2'h3;
		stall_FETCH = 1'h1;
		regsel_EX = 2'h3;
	 
	 
	 
	 //U-type instructions
	 end else if (opcode == 7'h37)  begin 									//lui			
		regsel_EX = 2'b1;
	 
	 
	 //B-type instructions
	 end else if (opcode == 7'h63 && funct3 == 3'h0 && !stall_EX) begin			//beq
		aluop_EX = 4'h4;
		regwrite_EX = 1'h0;
		if (zero) begin 
			pcsrc_EX = 2'h1;
			stall_FETCH = 1'h1;
		end 
	 end else if (opcode == 7'h63 && funct3 == 3'h1 && !stall_EX) begin			//bne
		aluop_EX = 4'h4;
		regwrite_EX = 1'h0;
		if (!zero) begin
			pcsrc_EX = 2'h1;
			stall_FETCH = 1'h1;
		end
	 end else if (opcode == 7'h63 && funct3 == 3'h4 && !stall_EX) begin			//blt
		aluop_EX = 4'hC;
		regwrite_EX = 1'h0;
		if (!zero) begin
			pcsrc_EX = 2'h1;
			stall_FETCH = 1'h1;
		end
	 end else if (opcode == 7'h63 && funct3 == 3'h6 && !stall_EX) begin			//bltu
		aluop_EX = 4'hD;
		regwrite_EX = 1'h0;
		if (!zero) begin
			pcsrc_EX = 2'h1;
			stall_FETCH = 1'h1;
		end
	 end else if (opcode == 7'h63 && funct3 == 3'h5 && !stall_EX) begin			//bge
		aluop_EX = 4'hC;
		regwrite_EX = 1'h0;
		if (zero) begin 
			pcsrc_EX = 2'h1;
			stall_FETCH = 1'h1;
		end
	 end else if (opcode == 7'h63 && funct3 == 3'h7 && !stall_EX) begin			//bgeu
		aluop_EX = 4'hD;
		regwrite_EX = 1'h0;
		if (zero) begin
			pcsrc_EX = 2'h1;
			stall_FETCH = 1'h1;
		end
	 
	 
	 //J-type instructions
	 end else if (opcode == 7'h6f && !stall_EX) begin									//jal
		pcsrc_EX = 2'h2;
		stall_FETCH = 1'h1;
		regsel_EX = 2'h3;
	 end
	 
	
	 //CSRRW instruction
	 else if (opcode == 7'h73) begin 	
		if(imm12 == 12'h0) begin  // reading gpio
			regsel_EX = 2'h0;
		end else if(imm12 == 12'h2) begin // writing gpio
			regwrite_EX = 1'h0;
			gpio_we = 1'h1;
		end
	end
	
	
	
	
	
	
	
	 // Check stall
	 if (stall_EX) begin
		regwrite_EX = 1'h0;
		gpio_we = 1'h0;
		pcsrc_EX = 2'h0;
	 end
	
end

endmodule
