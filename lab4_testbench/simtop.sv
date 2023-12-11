
module simtop;

    // Define parameters for test case configuration
    parameter NUM_TESTS = 10;

    // Declare signals and variables
    logic clk;
    logic rst;
	 
	 // Probing CPU for test bench
    wire [31:0] inst_mem_out;
	 wire [4:0]  regdest_WB_out;
	 wire 		 regwrite_WB_out;
	 wire [1:0]  regselWB_reg_out;
	 wire [31:0] GPIOoutreg_out;
	 wire [31:0] GPIOin_reg_out;
	 wire [31:0] Rwb_reg_out;
	 wire [31:0] IMM_WB_reg_out;
	 wire [11:0] PC_EX_out;
    wire        stall_EX_out;

    wire  [31:0] dummy;
    wire  [31:0] GPIOin_manual;
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
		  .regdest_WB_out(regdest_WB_out),		//add 	- 	done
		  .regwrite_WB_out(regwrite_WB_out),	//add 	- 	done
		  .regselWB_reg_out(regselWB_reg_out),	//add 	- 	done
		  .GPIOoutreg_out(GPIOoutreg_out),		//csrrw 	- 	done
		  .GPIOin_reg_out(GPIOin_reg_out),		//csrrw 	-	done
		  .Rwb_reg_out(Rwb_reg_out), 				//add 	- 	done
		  .IMM_WB_reg_out(IMM_WB_reg_out), 		//lui 	- 	done
		  .stall_EX_out(stall_EX_out), 			//jal		-	
		  .PC_EX_out(PC_EX_out)						//add		-	
  );
	 


			
		//CLK RST	
		initial begin
			clk = 0; #5; // Set clock to 0
			rst = 0; #5; // Enable sync reset
		repeat(2) begin
			clk = ~clk; #5; // Cycle the clock once
		end
		rst = 1; #5; // Disable sync reset			

		//ClK to load first instruction 
		repeat(10) begin
			clk = ~clk; #5; // Cycle Clock
		end


		

		
//################################Test of PC_EX_out#######################################		

		if (PC_EX_out==12'b0000_0001_0100) begin
			$display("Test of PC_EX_out passed");
		end else begin
			$display("Test of PC_EX_out failed"); 
		end
	
	

//################################Test of stall_EX_out#######################################

		//repeat(2) begin
		//	clk = ~clk; #5; // Cycle the clock once
		//end
		
		if (stall_EX_out == 1'b1) begin
			$display("Test of stall_EX_out passed");
		end else begin
			$display("Test of stall_EX_out failed"); 
		end
		
			
	end
endmodule  
