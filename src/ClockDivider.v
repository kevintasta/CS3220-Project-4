//                              -*- Mode: Verilog -*-
// Filename        : ClockDivider.v
// Description     : a simple clock divider
//
// cycle_time specifies time the clock remains
// in one state (i.e. half the period of the clock waveform).
//
// cycle_width specifies the number of bits in the cycle_time parameter.
//
module ClockDivider(clk_in,
	clk_out,
	locked);

	output	  locked; // clock is paused when locked is 1

  // Implement this yourself
  // Slow down the clock to ensure the cycle is long enough for all operations to execute
  // If you don't, you might get weird errors
	input clk_in;
	output clk_out;
	parameter counter = 3125000;
	reg[31:0] clk_count;
	reg clk = 0;
	always @ (posedge clk_in) begin
		if (clk_count == counter) begin
			clk <= ~clk;
			clk_count <= 0;
		end
		else begin
			clk_count <= clk_count + 1;
		end
	end
	assign clk_out = clk;

endmodule
