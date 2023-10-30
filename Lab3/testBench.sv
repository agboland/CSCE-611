
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
			
			parameter OPCODE_CSRRW = 7'b1110011
			
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
		  

		  		//ADD TEST
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
				

			//SUB TEST
			rs1_val = 32'h00000002;
			rs2_val = 32'h00000001;

			expected_result = rs1_val - rs2_val;

			#10;
			
            // Check the result
            if (result !== expected_result) begin
                $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
                done = 1;
            end				

            // Increment the test count
            test_count = test_count + 1;            


		//AND TEST
rs1_val = 32'h0000000F;
rs2_val = 32'h00000003;
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

AND_instruction = {FUNCT7_AND, rs2, rs1, FUNCT3_AND, rd, OPCODE_RTYPE}

expected_result = rs1_val & rs2_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//OR TEST
rs1_val = 32'h0000000F;
rs2_val = 32'h00000003;
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

OR_instruction = {FUNCT7_OR, rs2, rs1, FUNCT3_OR, rd, OPCODE_RTYPE}

expected_result = rs1_val | rs2_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//XOR TEST
rs1_val = 32'h0000000F;
rs2_val = 32'h00000003;
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

XOR_instruction = {FUNCT7_XOR, rs2, rs1, FUNCT3_XOR, rd, OPCODE_RTYPE}

expected_result = rs1_val ^ rs2_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//SLL TEST
rs1_val = 32'h00000004;
rs2_val = 32'h00000003; // Shifting by 3 bits
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

SLL_instruction = {FUNCT7_SLL, rs2, rs1, FUNCT3_SLL, rd, OPCODE_RTYPE}

expected_result = rs1_val << rs2_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;


//SRA TEST
rs1_val = 32'hF0000004; // A negative number to show arithmetic shift
rs2_val = 32'h00000003; // Shifting by 3 bits
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

SRA_instruction = {FUNCT7_SRA, rs2, rs1, FUNCT3_SRA, rd, OPCODE_RTYPE}

expected_result = $signed(rs1_val) >>> rs2_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//SRL TEST
rs1_val = 32'hF0000004;
rs2_val = 32'h00000003; // Shifting by 3 bits
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

SRL_instruction = {FUNCT7_SRL, rs2, rs1, FUNCT3_SRL, rd, OPCODE_RTYPE}

expected_result = rs1_val >>> rs2_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//SLT TEST
rs1_val = 32'h00000004;
rs2_val = 32'h00000003;
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

SLT_instruction = {FUNCT7_SLT, rs2, rs1, FUNCT3_SLT, rd, OPCODE_RTYPE}

expected_result = ($signed(rs1_val) < $signed(rs2_val)) ? 1 : 0;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//SLTU TEST
rs1_val = 32'h00000004;
rs2_val = 32'h00000003;
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

SLTU_instruction = {FUNCT7_SLTU, rs2, rs1, FUNCT3_SLTU, rd, OPCODE_RTYPE}

expected_result = (rs1_val < rs2_val) ? 1 : 0;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//MUL TEST
rs1_val = 32'h00000004;
rs2_val = 32'h00000003;
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

MUL_instruction = {FUNCT7_MUL, rs2, rs1, FUNCT3_MUL, rd, OPCODE_RTYPE}

expected_result = rs1_val * rs2_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//MULH TEST
rs1_val = 32'h0000FFFF;
rs2_val = 32'h0000FFFF;
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

MULH_instruction = {FUNCT7_MULH, rs2, rs1, FUNCT3_MULH, rd, OPCODE_RTYPE}

expected_result = ($signed(rs1_val) * $signed(rs2_val)) >>> 32;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//MULHU TEST
rs1_val = 32'h0000FFFF;
rs2_val = 32'h0000FFFF;
regfile[rs1] = rs1_val;
regfile[rs2] = rs2_val;

MULHU_instruction = {FUNCT7_MULHU, rs2, rs1, FUNCT3_MULHU, rd, OPCODE_RTYPE}

expected_result = (rs1_val * rs2_val) >>> 32;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//CSRRW TEST
csr_address = 32'h000000C0; // An example CSR address
rs1_val = 32'h0000000A; // Value to write to CSR
regfile[rs1] = rs1_val;

CSRRW_instruction = {csr_address, rs1, FUNCT3_CSRRW, rd, OPCODE_CSRRW}

expected_result = csr_read(csr_address); // Assuming csr_read is a function that reads CSR

#10;

// Check the result and also check if the CSR is updated
if (result !== expected_result || csr_read(csr_address) !== rs1_val) begin
    $display("Test case %d failed: Expected %h, Got %h or CSR not updated", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//ADDI TEST
rs1_val = 32'h00000004;
imm_val = 32'h00000003; // Immediate value
regfile[rs1] = rs1_val;

ADDI_instruction = {imm_val, rs1, FUNCT3_ADDI, rd, OPCODE_ITYPE}

expected_result = rs1_val + imm_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//ANDI TEST
rs1_val = 32'h0000000F;
imm_val = 32'h00000003; // Immediate value
regfile[rs1] = rs1_val;

ANDI_instruction = {imm_val, rs1, FUNCT3_ANDI, rd, OPCODE_ITYPE}

expected_result = rs1_val & imm_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//ORI TEST
rs1_val = 32'h0000000F;
imm_val = 32'h00000003; // Immediate value
regfile[rs1] = rs1_val;

ORI_instruction = {imm_val, rs1, FUNCT3_ORI, rd, OPCODE_ITYPE}

expected_result = rs1_val | imm_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//XORI TEST
rs1_val = 32'h0000000F;
imm_val = 32'h00000003; // Immediate value
regfile[rs1] = rs1_val;

XORI_instruction = {imm_val, rs1, FUNCT3_XORI, rd, OPCODE_ITYPE}

expected_result = rs1_val ^ imm_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//SLLI TEST
rs1_val = 32'h0000000F;
shamt_val = 3; // Shift amount
regfile[rs1] = rs1_val;

SLLI_instruction = {shamt_val, rs1, FUNCT3_SLLI, rd, OPCODE_ITYPE}

expected_result = rs1_val << shamt_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//SRAI TEST
rs1_val = 32'hFFFFFFF0;
shamt_val = 4; // Shift amount
regfile[rs1] = rs1_val;

SRAI_instruction = {FUNCT7_SRAI, shamt_val, rs1, FUNCT3_SRAI, rd, OPCODE_ITYPE}

expected_result = $signed(rs1_val) >>> shamt_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//SRLI TEST
rs1_val = 32'hFFFFFFFF;
shamt_val = 4; // Shift amount
regfile[rs1] = rs1_val;

SRLI_instruction = {shamt_val, rs1, FUNCT3_SRLI, rd, OPCODE_ITYPE}

expected_result = rs1_val >>> shamt_val;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;

//LUI TEST
imm_val = 32'h0000F000; // Immediate value

LUI_instruction = {imm_val, rd, OPCODE_LUI}

expected_result = imm_val << 12;

#10;

// Check the result
if (result !== expected_result) begin
    $display("Test case %d failed: Expected %h, Got %h", test_count, expected_result, result);
    done = 1;
end

// Increment the test count
test_count = test_count + 1;


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
