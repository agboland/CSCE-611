
module simtop;

    // Define parameters for test case configuration
    parameter NUM_TESTS = 10;

    // Declare signals and variables
    logic clk;
    logic rst;
	 
	 // Probing CPU for test bench
    wire [31:0] inst_mem_out;
	 wire [4:0] regdest_WB_out;
	 wire regwrite_WB_out;
	 wire [1:0] regselWB_reg_out;
	 wire [31:0] GPIOoutreg_out;
	 wire [31:0] GPIOin_reg_out;
	 wire [4:0] Rwb_reg_out; // FIXXXXXXXXXXXXXXXXXXXXXXXXXXXXx
	 wire [31:0] IMM_WB_reg_out;
	 


    wire [31:0] dummy;
    wire [31:0] dummy1;
    logic [11:0] address_input; 
    logic [11:0] imm_val;
    logic [4:0] shamt_val;
    logic done;

    // Instantiate the CPU and other components
    CPU cpu_inst (
        .clk(clk),
        .rst_n(rst),
        .GPIO_in(dummy1),
        .GPIO_out(dummy),
		  
		  // Test bench probing
		  .inst_mem_out(inst_mem_out),
		  .regdest_WB_out(regdest_WB_out),
		  .regwrite_WB_out(regwrite_WB_out),
		  .regselWB_reg_out(regselWB_reg_out),
		  .GPIOoutreg_out(GPIOoutreg_out),
		  .GPIOin_reg_out(GPIOin_reg_out),
		  .Rwb_reg_out(Rwb_reg_out),
		  .IMM_WB_reg_out(IMM_WB_reg_out) 
    );
	 
	 
	//R-Type opcode
	parameter OPCODE_RTYPE = 7'b0110011;
	
	reg [4:0] rs1, rs2, rd;
	reg [31:0] rs1_val, rs2_val, expected_result;

		//Add 
		parameter FUNCT3_ADD = 3'b000;
		parameter FUNCT7_ADD = 7'b0000000;
		
		//sub
		parameter FUNCT3_SUB = 3'b000;
		parameter FUNCT7_SUB = 7'b0100000;
	
		//and
		parameter FUNCT3_AND = 3'b111;
		parameter FUNCT7_AND = 7'b0000000;
	
		//or
		parameter FUNCT3_OR = 3'b110;
		parameter FUNCT7_OR = 7'b0000000;			

		//XOR
		parameter FUNCT3_XOR = 3'b100;
		parameter FUNCT7_XOR = 7'b0000000;			
	
		//SLL
		parameter FUNCT3_SLL = 3'b001;
		parameter FUNCT7_SLL = 7'b0000000;

		//SRA
		parameter FUNCT3_SRA = 3'b101;
		parameter FUNCT7_SRA = 7'b0100000;

		//SRL
		parameter FUNCT3_SRL = 3'b101;
		parameter FUNCT7_SRL = 7'b0000000;
	
		//SLT
		parameter FUNCT3_SLT = 3'b010;
		parameter FUNCT7_SLT = 7'b0000000;
	
		//SLTU
		parameter FUNCT3_SLTU = 3'b011;
		parameter FUNCT7_SLTU = 7'b0000000;
	
		//MUL
		parameter FUNCT3_MUL = 3'b000;
		parameter FUNCT7_MUL = 7'b0000001;
	
		//MULH
		parameter FUNCT3_MULH = 3'b001;
		parameter FUNCT7_MULH = 7'b0000001;
	
		//MULHU
		parameter FUNCT3_MULHU = 3'b011;
		parameter FUNCT7_MULHU = 7'b0000001;

		//CSSRW
		parameter OPCODE_CSRRW = 7'b1110011;
		parameter FUNCT3_CSSRW = 3'b001;
	
	
	//I-Type opcode
	parameter OPCODE_ITYPE = 7'b0010011;
	
		//ADDI
		parameter FUNCT3_ADDI = 3'b000;
		
		//ANDI
		parameter FUNCT3_ANDI = 3'b111;
		
		//ORI
		parameter FUNCT3_ORI = 3'b110;
					
		//XORI
		parameter FUNCT3_XORI = 3'b100;
					
		//SLLI
		parameter FUNCT3_SLLI = 3'b001;
		
		//SRAI
		parameter FUNCT3_SRAI = 3'b101;
		parameter FUNCT7_SRAI = 7'b0100000;
		
		//SRLI
		parameter FUNCT3_SRLI = 3'b101;
		parameter FUNCT7_SRLI = 7'b0000000;		


	//U-Type opcode
	parameter OPCODE_UTYPE = 7'b0110111;
			
			
	initial begin
		clk = 0; #1; // Set clock to 0
		rst = 0; #1; // Enable sync reset
		repeat(2) begin
			clk = ~clk; #1; // Cycle the clock once
		end
		rst = 1; #1; // Disable sync reset
			
			
		// for inst_mem		
//		for(int i = 0; i < 13; i++) begin
//			repeat(2) begin
//				clk = ~clk; #1; // Cycle Clock
//			end
//			$display("Output of InstMem: %h", inst_mem_out);
//		end

			
		// Reset CPU again
//		rst = 0; #1; // Enable sync reset
//		repeat(2) begin 
//			clk = ~clk; #1; // Cycle the clock once
//		end
//		rst = 1; #1; // Disable sync reset
		
		
		
		// Get first instruction
		repeat(2) begin
			clk = ~clk; #1; // Cycle the clock once
		end		
			
		
		for(int i = 0; i < 13; i++) begin
		
			$display("Output of instmem for instruction %2d: %h", i + 1, inst_mem_out);
			$display("Output of rs1 for instruction %2d: %h", i + 1, Rwb_reg_out);
			
			repeat(2) begin 
				clk = ~clk; #1; // Cycle clock
			end
		
			$display("Output of regdest_reg_WB for instruction %2d: %h", i + 1, regdest_WB_out);
			$display("Output of regwrite_reg_WB for instruction %2d: %h", i + 1, regwrite_WB_out);
			$display("Output of regdsel_reg_WB for instruction %2d: %h", i + 1, regselWB_reg_out);
			$display("Output of GPIO_out for instruction %2d: %h", i + 1, GPIOoutreg_out);
			$display("Output of GPIO_in_reg for instruction %2d: %h", i + 1, GPIOin_reg_out);
			//$display("Output of Rwb_WB_reg for instruction %2d: %h", i + 1, Rwb_reg_out);
			$display("Output of IMM_reg_WB for instruction %2d: %h\n\n", i + 1, IMM_WB_reg_out);
			
			
//			repeat(2) begin 
//				clk = ~clk; #1; // Cycle clock
//			end
//		
//			$display("Output of regdest_WB for instruction %2d: %h\n\n", i + 1, regdest_WB_out);
		end
		
			
	end
endmodule 