module MBUFF(memValIn, destRegIn, regWrEnIn, clk, wrEn, flush,
	memValOut, destRegOut, regWrEnOut);
	input wrEn, flush, clk, regWrEnIn;
	input [31:0] memValIn;
	input [3:0] destRegIn;
	output reg [31:0] memValOut;
	output reg regWrEnOut;
	output reg [3:0] destRegOut;
	
	always @(posedge clk) begin
		if (flush == 1'b1) begin
			{memValOut, destRegOut, regWrEnOut} <= 0;
		end
		if (wrEn == 1'b1) begin
			memValOut <= memValIn;
			destRegOut <= destRegIn;
			regWrEnOut <= regWrEnIn;
		end
	end
endmodule