module InstructionDecoder (
    input [31:0] instruction,
    output [6:0] opcode,
    output [2:0] funct3,
    output [6:0] funct7,
    output [4:0] rd,
    output [4:0] rs1,
    output [4:0] rs2,
    output [11:0] imm12,
    output [6:0] imm7,
    output [4:0] imm5,
    output [19:0] imm20
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
endmodule
