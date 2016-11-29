module MBUFF(memValIn, destRegIn, regWrEnIn, opIn, clk, flush,
	memValOut, destRegOut, regWrEnOut, opOut);
	input flush, clk, regWrEnIn;
	input [31:0] memValIn;
	input [3:0] destRegIn, opIn;
	output reg [31:0] memValOut;
	output reg regWrEnOut;
	output reg [3:0] destRegOut, opOut;
	
	always @(posedge clk) begin
		if (flush == 1'b1) begin
			{memValOut, destRegOut, regWrEnOut} <= 0;
		end
		else begin
			memValOut <= memValIn;
			destRegOut <= destRegIn;
			regWrEnOut <= regWrEnIn;
			opOut <= opIn;
		end
	end
endmodule