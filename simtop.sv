/* Copyright 2020 Jason Bakos, Philip Conrad, Charles Daniels */

/* Top-level module for CSCE611 RISC-V CPU, for running under simulation.  In
 * this case, the I/Os and clock are driven by the simulator. */

module simtop;

	logic clk;
	logic [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
  	reg [17:0] SW; // Create a register to represent SW

	top dut
	(
		//////////// CLOCK //////////
		.CLOCK_50(clk),
		.CLOCK2_50(),
	        .CLOCK3_50(),

		//////////// LED //////////
		.LEDG(),
		.LEDR(),

		//////////// KEY //////////
		.KEY(),

		//////////// SW /////////
		.SW(SW),

		//////////// SEG7 //////////
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5),
		.HEX6(HEX6),
		.HEX7(HEX7)
	);


	
 // Clock generation
  always #5 clk = ~clk;

  // Testbench logic
  initial begin
    // Initialize signals
    clk = 0;
    SW = 0;

    // Monitor HEX outputs and apply test cases
    $monitor("SW=%h, HEX0=%h, HEX1=%h, HEX2=%h, HEX3=%h, HEX4=%h, HEX5=%h, HEX6=%h, HEX7=%h",
      SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

    // Test cases
    // Test case 1: SW = 4'b0000 (expect HEX0 to be 7'b100_0000)
    SW = 18'b00_0000_0000_0000_0001;
    #10;
    assert (HEX0 === 7'b111_1001) else $display("Test case 1 failed");

    // Test case 2: SW = 4'b0001 (expect HEX0 to be 7'b111_1001)
    SW = 18'b00_0000_0000_0000_0010;
    #10;
    assert (HEX0 === 7'b011_0000) else $display("Test case 2 failed");

    SW = 18'b00_0000_0000_0011_0000;
    #10;
    assert (HEX1 === 7'b101_1000) else $display("Test case 3 failed");

    SW = 18'b00_0000_0000_0100_0000;
    #10;
    assert (HEX1 === 7'b001_1001) else $display("Test case 4 failed");

    SW = 18'b00_0000_0101_0000_0000;
    #10;
    assert (HEX2 === 7'b001_0010) else $display("Test case 5 failed");

    SW = 18'b00_0000_0110_0000_0000;
    #10;
    assert (HEX2 === 7'b000_0010) else $display("Test case 6 failed");

    SW = 18'b00_0111_0000_0000_0000;
    #10;
    assert (HEX3 === 7'b111_1000) else $display("Test case 7 failed");

    SW = 18'b00_1000_0000_0000_0000;
    #10;
    assert (HEX3 === 7'b000_0000) else $display("Test case 8 failed");

    $display("Success");

    // Finish simulation
    $finish;
  end


endmodule

