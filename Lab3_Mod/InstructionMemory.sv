module InstructionMemory (
    input wire clk,
    input wire reset,
    input wire [11:0] address,
    output logic [31:0] instruction
);

    // Define the memory size and file name
    localparam MEM_SIZE = 4096;
    localparam FILENAME = "instmem.dat";
   

    // Internal memory array to store instructions
    reg [31:0] memory[0:MEM_SIZE-1];

    // Read the instruction memory contents from a file
    initial begin
        $readmemh(FILENAME, memory);
    end

    // Logic to output the instruction based on the address
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            instruction <= 32'b0; // Reset the output to 0
        end else begin
            instruction <= memory[address];
        end
    end

endmodule
