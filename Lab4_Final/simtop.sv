
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
	 wire [31:0] Rwb_reg_out;
	 wire [31:0] IMM_WB_reg_out;
	 wire [11:0] branch_addr;
	 wire [11:0] jal_addr;
	 wire [11:0] jalr_addr;
	 wire [1:0] pcsrc;
	 wire [11:0] PC_EX_out;
	 wire [11:0] PC_input_out;
	 wire zero_out;
	 wire [31:0] rd1_out;
	 wire [31:0] rd2_out;
	 wire [31:0] alu_b_out;
	 wire [4:0] rs1_out;
	 wire [4:0] rs2_out;
	 wire [31:0] wr_data_out;

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
		  .IMM_WB_reg_out(IMM_WB_reg_out),
		  
		  .branch_addr(branch_addr),
		  .jal_addr(jal_addr),
		  .jalr_addr(jalr_addr),
		  .pcsrc(pcsrc),
		  .PC_EX_out(PC_EX_out),
		  .PC_input_out(PC_input_out),
		  .zero_out(zero_out),
		  .rd1_out(rd1_out),
		  .rd2_out(rd2_out),
		  .alu_b_out(alu_b_out),
		  .rs1_out(rs1_out),
		  .rs2_out(rs2_out),
		  .wr_data_out(wr_data_out)
    );
	 
	assign dummy1 = 32'h4;
			
	initial begin
	
		clk = 0; #15; // Set clock to 0
		rst = 0; #15; // Enable sync reset
		repeat(2) begin
			clk = ~clk; #15; // Cycle the clock once
		end
		rst = 1; #15; // Disable sync reset
			
			
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
			clk = ~clk; #15; // Cycle the clock once
		end		
			
		
		for(int i = 0; i < 30; i++) begin
		
			$display("Output of instmem for instruction %2d: %h", i + 1, inst_mem_out);
			$display("Output of branch_addr for instruction %2d: %h", i + 1, branch_addr);
			$display("Output of jal_addr for instruction %2d: %h", i + 1, jal_addr);
			$display("Output of jalr_addr for instruction %2d: %h", i + 1, jalr_addr);
			$display("Output of pcsrc for instruction %2d: %h", i + 1, pcsrc);
			$display("Output of PC_EX for instruction %2d: %h", i + 1, PC_EX_out);
			$display("Output of PC_input for instruction %2d: %h", i + 1, PC_input_out);
			$display("Output of zero for instruction %2d: %h", i + 1, zero_out);
			$display("Output of rd1 for instruction %2d: %h", i + 1, rd1_out);
			$display("Output of rd2 for instruction %2d: %h", i + 1, rd2_out);
			$display("Output of alu_b for instruction %2d: %h", i + 1, alu_b_out);
			$display("Output of rs1 for instruction %2d: %h", i + 1, rs1_out);
			$display("Output of rs2 for instruction %2d: %h", i + 1, rs2_out);
			//$display("Output of rs1 for instruction %2d: %h", i + 1, Rwb_reg_out);
			
			repeat(2) begin 
				clk = ~clk; #15; // Cycle clock
			end
		
			
			$display("Output of regdest_reg_WB for instruction %2d: %h", i + 1, regdest_WB_out);
			$display("Output of regwrite_reg_WB for instruction %2d: %h", i + 1, regwrite_WB_out);
			$display("Output of regdsel_reg_WB for instruction %2d: %h", i + 1, regselWB_reg_out);
			$display("Output of GPIO_out for instruction %2d: %h", i + 1, GPIOoutreg_out);
			$display("Output of GPIO_in_reg for instruction %2d: %h", i + 1, GPIOin_reg_out);
			$display("Output of Rwb_WB_reg for instruction %2d: %h", i + 1, Rwb_reg_out);
			$display("Output of IMM_reg_WB for instruction %2d: %h", i + 1, IMM_WB_reg_out);
			$display("Output of wr_data for instruction %2d: %h\n\n", i + 1, wr_data_out);
			
			
//			repeat(2) begin 
//				clk = ~clk; #1; // Cycle clock
//			end
//		
//			$display("Output of regdest_WB for instruction %2d: %h\n\n", i + 1, regdest_WB_out);
		end
		
			
	end
endmodule 