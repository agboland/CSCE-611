module CPU (
    input logic clk,
    input logic rst_n,
    input logic [31:0] GPIO_in,
	 
    output wire [31:0] GPIO_out,
    output wire [31:0] regsel_WB_simtop
);

	//logic [31:0] inst_ram [4095:0];
	//initial $readmemh ("instmem.dat",inst_ram);
	
	
	
	logic [11:0] PC_FETCH;
	logic [31:0] instruction_EX;
	
	
	//----------------------------------------------------Instruction memory
	InstructionMemory instmem(.clk(clk), .reset(rst_n), .address(PC_FETCH), .instruction(regsel_WB_simtop));
	
	
	
	
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
	InstructionDecoder instdec(.instruction(instruction_EX), .opcode(opcode), .funct3(funct3), .funct7(funct7), .rd(rd), .rs1(rs1), .rs2(rs2), .imm12(imm12), .imm7(imm7), .imm5(imm5), .imm20(imm20));
	
	
	
	
	//----------------------------------------------------regdest_WB register
	logic [4:0] writeaddr;
	register_5 regdest_WB(.clk(clk), .in(rd), .out(writeaddr));
	
	
	
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
	controlUnit cu(.funct7(funct7), .imm12(imm12), .funct3(funct3), .opcode(opcode), .alusrc_EX(alusrc_EX), .regwrite_EX(regwrite_EX), .regsel_EX(regsel_EX), .aluop_EX(aluop_EX), .gpio_we(gpio_we));
	
	
	
	//----------------------------------------------------Regwrite_EX register
	register_1 regwrite_WB(.clk(clk), .in(regwrite_EX), .out(we));
	
	
	
	//----------------------------------------------------Regsel_EX register
	logic [1:0] regsel_WB;
	register_2 regselWB_reg(.clk(clk), .in(regsel_EX), .out(regsel_WB));
	
	
	
	//----------------------------------------------------GPIO_out register
	register_32s GPIOoutreg(.clk(clk), .we(gpio_we), .in(rd1), .out(GPIO_out));
	
	//----------------------------------------------------GPIO_in register
	logic [31:0] GPIOin_WB;
	register_32a GPIOin_reg(.clk(clk), .in(GPIO_in), .out(GPIOin_WB));
	
	//----------------------------------------------------2 input mux
	//wire [31:0] mux2_out;
	logic [31:0] alu_b;
	mux_2 mux2(.a(rd2), .b(signExtended), .select(alusrc_EX), .y(alu_b));
	
	//----------------------------------------------------ALU
	logic [31:0] R_EX;
	alu ALU(.A(rd1), .B(alu_b), .op(aluop_EX), .R(R_EX), .zero());
	
	//----------------------------------------------------R_WB register
	logic [31:0] R_WB;
	register_32a Rwb_reg(.clk(clk), .in(R_EX), .out(R_WB));
	
	
	//---------------------------------------------------regsel_WB
	mux_3 mux3(.a(GPIOin_WB), .b({imm20, 12'b0}), .c(R_WB), .select(regsel_WB), .y(wd)); // Probe output of regsel_WB
	//mux_3 mux3(.a(GPIOin_WB), .b({imm20, 12'b0}), .c(R_WB), .select(regsel_WB), .y(regsel_WB_simtop));
	
	
	
	
	always_ff @(posedge clk) begin
		if(~rst_n) begin
			PC_FETCH <= 12'd0;
			//instruction_EX <= 32'd0;
		end else begin //End IF begin Else
			PC_FETCH <= PC_FETCH + 1'b1;
			//instruction_EX <= inst_ram[PC_FETCH];
		end // End Else IF
	end //End always_ff
	
	//assign regsel_WB_simtop = instruction_EX;
	
	

endmodule // End CPU Module

