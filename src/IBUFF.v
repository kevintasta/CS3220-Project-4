module IBUFF(incPC, instrIn, clk, flush, pcOut, instrOut);
	input flush, clk;
	input [31:0] incPC, instrIn;
	output reg [31:0] pcOut, instrOut;
	
	always @(posedge clk) begin
		if (flush == 1'b1) begin
			pcOut <= 0;
			instrOut <= 0;
		end
		else begin
			pcOut <= incPC;
			instrOut <= instrIn;
		end
	end
endmodule