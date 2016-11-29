module EBUFF(pcIn, src1RegIn, aluCalcIn, aluCondIn, destRegIn, regWrEnIn, memWrEnIn, isLWIn, opIn, dstMuxIn, clk, flush,
	pcOut, src1RegOut, aluCalcOut, aluCondOut, destRegOut, regWrEnOut, memWrEnOut, isLWOut, opOut, dstMuxOut);
	input flush, clk, regWrEnIn, memWrEnIn, isLWIn;
	input [31:0] pcIn, aluCalcIn, aluCondIn;
	input [3:0] src1RegIn, destRegIn, opIn;
	input [1:0] dstMuxIn;
	output reg [31:0] pcOut, aluCalcOut, aluCondOut;
	output reg regWrEnOut, memWrEnOut, isLWOut;
	output reg [3:0] src1RegOut, destRegOut, opOut;
	output reg [1:0] dstMuxOut;
	
	always @(posedge clk) begin
		if (flush == 1'b1) begin
			{aluCalcOut, src1RegOut, destRegOut, regWrEnOut, memWrEnOut} <= 0;
		end
		else begin
			pcOut <= pcIn;
			aluCalcOut <= aluCalcIn;
			src1RegOut <= src1RegIn;
			destRegOut <= destRegIn;
			regWrEnOut <= regWrEnIn;
			memWrEnOut <= memWrEnIn;
			aluCondOut <= aluCondIn;
			isLWOut <= isLWIn;
			opOut <= opIn;
			dstMuxOut <= dstMuxIn;
		end
	end
endmodule