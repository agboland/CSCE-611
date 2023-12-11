module CPU (
    input wire clk,
    input wire rst_n,
    input wire [31:0] GPIO_in,
	 
    output logic [31:0] GPIO_out,
	 
	 // Outputs for test bench
    output logic [31:0] inst_mem_out,
	 output logic [4:0] regdest_WB_out,
	 output logic regwrite_WB_out,
	 output logic [1:0] regselWB_reg_out,
	 output logic [31:0] GPIOoutreg_out,
	 output logic [31:0] GPIOin_reg_out,
	 output logic [31:0] Rwb_reg_out,
	 output logic [31:0] IMM_WB_reg_out
);
	
	logic [11:0] PC_FETCH; // Output of PC
	logic [31:0] instruction_EX;
	logic [11:0] PC_FETCH_1;
	logic [11:0] PC_in;
	
	//----------------------------------------------------Program Counter
	PC pc(.clk(clk), .rst_n(rst_n), .addr(PC_in), .PC_FETCH(PC_FETCH), .PC_FETCH_1(PC_FETCH_1));
	
	logic [11:0] PC_EX;
	//----------------------------------------------------PC fetch register
	register_12 PC_EX_reg(.clk(clk), .in(PC_FETCH), .out(PC_EX));
	
	logic [11:0] branch_addr_EX;
	logic [11:0] jal_addr_EX;
	logic [11:0] jalr_addr_EX;
	//----------------------------------------------------PC mux
	mux_4_12 pcsrc_mux(.a(PC_FETCH_1), .b(branch_addr_EX), .c(jal_addr_EX), .d(jalr_addr_EX), .select(pcsrc_EX), .y(PC_in));
	
	
	//----------------------------------------------------Instruction memory
	InstructionMemory instmem(.clk(clk), .reset(rst_n), .address(PC_FETCH), .instruction(instruction_EX));
	assign inst_mem_out = instruction_EX;
	
	
	//----------------------------------------------------Instruction decoder module
	wire [6:0] opcode;
	wire [2:0] funct3;
	wire [6:0] funct7;
	wire [4:0] rd;
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [11:0] imm12;
	wire [6:0] imm7;
	wire [4:0] imm5;
	wire [19:0] imm20; 
	InstructionDecoder instdec(.instruction(instruction_EX), .PC_EX(PC_EX), .readdata1_EX(rd1),
		.opcode(opcode), .funct3(funct3), .funct7(funct7), .rd(rd), .rs1(rs1), .rs2(rs2), .imm12(imm12), .imm7(imm7), .imm5(imm5), .imm20(imm20), .jal_addr_EX(jal_addr_EX), .branch_addr_EX(branch_addr_EX), .jalr_addr_EX(jalr_addr_EX));
	
	
	
	
	//----------------------------------------------------regdest_WB register
	logic [4:0] writeaddr;
	register_5 regdest_WB(.clk(clk), .in(rd), .out(writeaddr));
	assign regdest_WB_out = writeaddr; // Probe for test bench
	
	
	
	//----------------------------------------------------SignExtend
	logic [31:0] signExtended;
	SignExtend se(.in(imm12), .out(signExtended));
	
	
	
	//----------------------------------------------------Regfile implementation
	logic we;
	logic [31:0] rd1;
	logic [31:0] rd2;
	logic [31:0] wd;
	regfile rf(.clk(clk), .we(we), .readaddr1(rs1), .readaddr2(rs2), .writeaddr(writeaddr), .writedata(wd), .readdata1(rd1), .readdata2(rd2));
	
	
	
	//----------------------------------------------------Control Unit
	logic alusrc_EX;
	logic regwrite_EX;
	logic [1:0] regsel_EX;
	logic [3:0] aluop_EX;
	logic gpio_we;
	logic [1:0] pcsrc_EX;
	logic stall_EX;
	logic stall_FETCH;
	logic se_imm_sel;
	controlUnit cu(.funct7(funct7), .imm12(imm12), .funct3(funct3), .opcode(opcode), .stall_EX(stall_EX), .zero(zero),
		.stall_FETCH(stall_FETCH), .alusrc_EX(alusrc_EX), .regwrite_EX(regwrite_EX), .regsel_EX(regsel_EX), .aluop_EX(aluop_EX), .gpio_we(gpio_we), .pcsrc_EX(pcsrc_EX));
	
	//----------------------------------------------------Stall register
	register_1 stall_reg(.clk(clk), .in(stall_FETCH), .out(stall_EX));
	
	
	//----------------------------------------------------Regwrite_EX register
	register_1 regwrite_WB(.clk(clk), .in(regwrite_EX), .out(we));
	assign regwrite_WB_out = we;
	
	
	
	//----------------------------------------------------Regsel_EX register
	logic [1:0] regsel_WB;
	register_2 regselWB_reg(.clk(clk), .in(regsel_EX), .out(regsel_WB));
	assign regselWB_reg_out = regsel_WB;
	
	
	
	//----------------------------------------------------GPIO_out register
	register_32s GPIOoutreg(.clk(clk), .we(gpio_we), .in(rd1), .out(GPIO_out));
	assign GPIOoutreg_out = GPIO_out;
	
	//----------------------------------------------------GPIO_in register
	logic [31:0] GPIOin_WB;
	register_32a GPIOin_reg(.clk(clk), .in(GPIO_in), .out(GPIOin_WB));
	assign GPIOin_reg_out = GPIOin_WB;
	
	//----------------------------------------------------2 input mux
	logic [31:0] alu_b;
	mux_2 mux2(.a(rd2), .b(signExtended), .select(alusrc_EX), .y(alu_b));
	
	//----------------------------------------------------ALU
	logic [31:0] R_EX;
	logic zero;
	alu ALU(.A(rd1), .B(alu_b), .op(aluop_EX), .R(R_EX), .zero(zero));
	
	//----------------------------------------------------R_WB register
	logic [31:0] R_WB;
	register_32a Rwb_reg(.clk(clk), .in(R_EX), .out(R_WB));
	assign Rwb_reg_out = R_WB;
	
	//----------------------------------------------------IMM_WB register
	logic [31:0] IMM_WB;
	register_32a IMM_WB_reg(.clk(clk), .in({imm20, 12'b0}), .out(IMM_WB));
	assign IMM_WB_reg_out = IMM_WB;
	
	//---------------------------------------------------regsel_WB
	mux_4 mux4(.a(GPIOin_WB), .b(IMM_WB), .c(R_WB), .d({20'b0, PC_EX}), .select(regsel_WB), .y(wd)); 
	
	//assign regsel_WB_out = wd; // Probe for test bench

endmodule // End CPU Module

