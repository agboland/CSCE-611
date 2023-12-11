
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
	 


    wire [31:0] dummy;
    wire [31:0] GPIOin_manual;
    logic [11:0] address_input; 
    logic [11:0] imm_val;
    logic [4:0] shamt_val;
    logic done;

	 assign GPIOin_manual = 32'd3;
	 
    // Instantiate the CPU and other components
    CPU cpu_inst (
        .clk(clk),
        .rst_n(rst),
        .GPIO_in(GPIOin_manual),
        .GPIO_out(dummy),
		  
		  // Test bench probing
		  .inst_mem_out(inst_mem_out),
		  .regdest_WB_out(regdest_WB_out),//add - done
		  .regwrite_WB_out(regwrite_WB_out),//add - done
		  .regselWB_reg_out(regselWB_reg_out),//add - done
		  .GPIOoutreg_out(GPIOoutreg_out),//csrrw - done
		  .GPIOin_reg_out(GPIOin_reg_out),//csrrw - done
		  .Rwb_reg_out(Rwb_reg_out), //add
		  .IMM_WB_reg_out(IMM_WB_reg_out) //lui - done
    );
	 


			
		//CLK RST	
		initial begin
			clk = 0; #5; // Set clock to 0
			rst = 0; #5; // Enable sync reset
		repeat(2) begin
			clk = ~clk; #5; // Cycle the clock once
		end
		rst = 1; #5; // Disable sync reset
			
		
	
//#################################Test IMM_WB_reg_out##########################################

		//ClK to load first instruction 
		repeat(2) begin
			clk = ~clk; #5; // Cycle Clock
		end

		//CLK to load first instruction to next stage in pipline
		repeat(2) begin
			clk = ~clk; #5; // Cycle Clock
		end
		
		//Read IMM_WB_REG for expected value from inst_mem.dat "lui,t0,123"	
		if (IMM_WB_reg_out == 32'b0000_0000_0000_0111_1011_0000_0000_0000) begin
			$display("Test of IMM_WB_reg passed");
		end else begin
			$display("Test of IMM_WB_reg failed"); 
		end
		
//################################Test of regdest_WB_out#######################################			
		repeat(2) begin
			clk = ~clk; #5; // Cycle Clock
		end
		if (regdest_WB_out == 5'b00101) begin
			$display("Test of regdest_WB_out passed");
		end else begin
			$display("Test of regdest_WB_out failed"); 
		end
		
//################################Test of regwrite_WB_out#######################################
			
		if (regwrite_WB_out == 1'b1) begin
			$display("Test of regwrite_WB_out passed");
		end else begin
			$display("Test of regwrite_WB_out failed"); 
		end
		
		
//################################Test of regselWB_reg_out#######################################		

		if (regselWB_reg_out==2'h2) begin
			$display("Test of regselWB_reg_out passed");
		end else begin
			$display("Test of regselWB_reg_out failed"); 
		end
//################################Test of Rwb_reg_out#######################################			
		
		if (Rwb_reg_out==32'b0000_0000_0000_0111_1011_0000_0000_0000) begin
			$display("Test of Rwb_reg_out passed");
		end else begin
			$display("Test of Rwb_reg_out failed"); 
		end
	
//################################Test of GPIOoutreg_out#######################################			
	
		//CLK to load third instruction to next stage in pipline
		repeat(2) begin
			clk = ~clk; #5; // Cycle the clock once
		end

		if (GPIOoutreg_out == 32'b0000_0000_0000_0111_1011_0000_0000_0000) begin
			$display("Test of GPIOoutreg_out passed");
		end else begin
			$display("Test of GPIOoutreg_out failed"); 
		end
	
	
//################################Test of GPIOin_reg_out#######################################
	
		if (GPIOin_reg_out == 32'd3) begin
			$display("Test of GPIOin_reg_out passed");
		end else begin
			$display("Test of GPIOin_reg_out failed"); 
		end
	


		
		

	
//		// Get first instruction
//		repeat(2) begin
//			clk = ~clk; #1; // Cycle the clock once
//		end		
//			
//		
//		for(int i = 0; i < 20; i++) begin
//		
//			$display("Output of instmem for instruction %2d: %h", i + 1, inst_mem_out);
//			//$display("Output of rs1 for instruction %2d: %h", i + 1, Rwb_reg_out);
//			
//			repeat(2) begin 
//				clk = ~clk; #1; // Cycle clock
//			end
//		
//			$display("Output of regdest_reg_WB for instruction %2d: %h", i + 1, regdest_WB_out);
//			$display("Output of regwrite_reg_WB for instruction %2d: %h", i + 1, regwrite_WB_out);
//			$display("Output of regdsel_reg_WB for instruction %2d: %h", i + 1, regselWB_reg_out);
//			$display("Output of GPIO_out for instruction %2d: %h", i + 1, GPIOoutreg_out);
//			$display("Output of GPIO_in_reg for instruction %2d: %h", i + 1, GPIOin_reg_out);
//			$display("Output of Rwb_WB_reg for instruction %2d: %h", i + 1, Rwb_reg_out);
//			$display("Output of IMM_reg_WB for instruction %2d: %h\n\n", i + 1, IMM_WB_reg_out);
//			
			
//			repeat(2) begin 
//				clk = ~clk; #1; // Cycle clock
//			end
//		
//			$display("Output of regdest_WB for instruction %2d: %h\n\n", i + 1, regdest_WB_out);
//		end
		
			
	end
endmodule  