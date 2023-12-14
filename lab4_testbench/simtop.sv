
module simtop;

    // Define parameters for test case configuration
    parameter NUM_TESTS = 10;

    // Declare signals and variables
    logic clk;
    logic rst;
	 
	 // Probing CPU for test bench

    	wire stall_EX_out;
	wire GPIO_we_out;
	wire alusrc_EX_out;
	wire regwrite_EX_out;
	wire [1:0] regsel_EX_out;
	wire [3:0] aluop_EX_out;
	wire gpio_we_out;
	wire [1:0] pcsrc_EX_out;
	wire stall_FETCH_out;
	wire [6:0] funct7_out;
	wire [11:0] imm12_out;
	wire [2:0] funct3_out;
	wire [6:0] opcode_out;


	
    logic done;

	 assign GPIOin_manual = 32'd3;
	 
    // Instantiate the CPU and other components
    CPU cpu_inst (
        .clk(clk),
        .rst_n(rst),
		  
		  // Test bench probing

	    .stall_EX_out(stall_EX_out), 			//jal		-	
	    .PC_EX_out(PC_EX_out),//add		-	
	    .GPIO_we_out(GPIO_we_ou),
	    .alusrc_EX_out(alusrc_EX_out),
	    .regwrite_EX_out(regwrite_EX_out),
	    .regsel_EX_out(regsel_EX_out),
	    .aluop_EX_out(aluop_EX_out),
	    .gpio_we_out(gpio_we_out),
	    .pcsrc_EX_out(pcsrc_EX_out),
	    .stall_FETCH_out(stall_FETCH_out)
  );
	 


			
		//CLK RST	
		initial begin
			clk = 0; #5; // Set clock to 0
			rst = 0; #5; // Enable sync reset
			
		repeat(2) begin
			clk = ~clk; #5; // Cycle the clock once
		end
		rst = 1; #5; // Disable sync reset			

 always @(posedge clk) begin
        if (rst == 1) begin  // Only check after reset is deasserted
            // Compare actual outputs with expected outputs
            if (alusrc_EX_out != expected_alusrc_EX) begin
                $display("Error: alusrc_EX_out incorrect at time %t", $time);
            end
            if (regwrite_EX_out != expected_regwrite_EX) begin
                $display("Error: regwrite_EX_out incorrect at time %t", $time);
            end
            if (aluop_EX_out != expected_aluop_EX) begin
                $display("Error: aluop_EX_out incorrect at time %t", $time);
            end
            if (pcsrc_EX_out != expected_pcsrc_EX) begin
                $display("Error: pcsrc_EX_out incorrect at time %t", $time);
            end
            if (stall_FETCH_out != expected_stall_FETCH) begin
                $display("Error: stall_FETCH_out incorrect at time %t", $time);
            end
            if (gpio_we_out != expected_gpio_we) begin
                $display("Error: stall_FETCH_out incorrect at time %t", $time);
            end
        end
    end
			

		repeat(10) begin
			clk = ~clk; #5; // Cycle Clock
		end


		

	end
endmodule  
