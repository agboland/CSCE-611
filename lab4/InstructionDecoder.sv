module InstructionDecoder (
    input [31:0] instruction,
	 input [11:0] PC_EX,
	 input [31:0] readdata1_EX,
    output [6:0] opcode,
    output [2:0] funct3,
    output [6:0] funct7,
    output [4:0] rd,
    output [4:0] rs1,
    output [4:0] rs2,
    output [11:0] imm12,
    output [6:0] imm7,
    output [4:0] imm5,
    output [19:0] imm20,
	 output [11:0] jal_addr_EX,
	 output [11:0] branch_addr_EX,
	 output [11:0] jalr_addr_EX
);
    // Extract opcode field (bits 6-0)
    assign opcode = instruction[6:0];

    // Extract funct3 field (bits 14-12)
    assign funct3 = instruction[14:12];

    // Extract funct7 field (bits 31-25)
    assign funct7 = instruction[31:25];

    // Extract rd field (bits 11-7)
    assign rd = instruction[11:7];

    // Extract rs1 field (bits 19-15)
    assign rs1 = instruction[19:15];

    // Extract rs2 field (bits 24-20)
    assign rs2 = instruction[24:20];

    // Extract immediate fields for I-type (bits 31-20, 11-0)
    assign imm12 = instruction[31:20];
    assign imm7 = instruction[31:25];
    assign imm5 = instruction[11:7];

    // Extract immediate field for U-type (bits 31-12)
    assign imm20 = instruction[31:12];
	 
	 
	 logic [19:0] jal_offset_EX;
	 assign jal_offset_EX = { instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0 };
	 assign jal_addr_EX = PC_EX + jal_offset_EX[13:2];
	 
	 logic [12:0] branch_offset_EX;
	 assign branch_offset_EX = { instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0 };
	 assign branch_addr_EX = PC_EX + { branch_offset_EX[12],branch_offset_EX[12:2] };
	 
	 logic [11:0] jalr_offset;
	 assign jalr_offset = instruction[31:20];
	 assign jalr_addr_EX = readdata1_EX[11:0] + {{2{jalr_offset[11]}},jalr_offset[11:2]};
	 
endmodule
