
module testbench;

    // Define parameters for test case configuration
    parameter NUM_TESTS = 10;
    parameter INITIAL_PC = 0x1000; // Initial program counter value
    parameter TEST_TIMEOUT = 1000; // Timeout in simulation steps

    // Declare signals and variables
    reg clk;
    reg rst;
    wire [31:0] result;
    reg [31:0] instruction;
    reg [5:0] test_count;
    reg done;

    // Instantiate the CPU and other components
    CPU cpu_inst (
        .clk(clk),
        .rst(rst),
        .instruction_input(instruction),
        .result_output(result)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end
	 
	 
	 
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
				parameter FUNCT3_CSSRW = 3'b111;
			
			
			//I-Type opcode
			parameter OPCODE_ITYPE = 7'b0010011
			
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
			

    // Reset generation
    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;

        // Test cases
        test_count = 0;
        done = 0;

        // Test case loop
        while (!done) begin
				rs1 = 5'd1;
				rs2 = 5'd2;
				rd = 5'd3;
		  
				rs1_val = 32'h00000001;
				rs2_val = 32'h00000001;
				regfile[rs1] = rs1_val;
				regfile[rs2] = rs2_val;
				
				ADD_instruction = {FUNCT7_ADD, rs2, rs1, FUNCT3_ADD, rd, OPCODE_RTYPE}
				
				
				expected_result = rs1_val + rs2_val;
				
            #10;

            // Check the result
            if (result !== expected_result) begin
                $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
                done = 1;
            end
				
            // Increment the test count
            test_count = test_count + 1;
				
				
            // Optionally, add more test cases


            // If all tests are done, stop the simulation
            if (test_count >= NUM_TESTS) begin
                $display("All test cases passed.");
                done = 1;
            end
        end

        // Finish simulation
        $finish;
    end

endmodule
