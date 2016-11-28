module EBUFF(src1RegIn, aluCalcIn, destRegIn, regWrEnIn, memWrEnIn, clk, wrEn, flush,
	src1RegOut, aluCalcOut, destRegOut, regWrEnOut, memWrEnOut);
	input wrEn, flush, clk, regWrEnIn, memWrEnIn;
	input [31:0] aluCalcIn;
	input [3:0] src1RegIn, destRegIn;
	output reg [31:0] aluCalcOut;
	output reg regWrEnOut, memWrEnOut;
	output reg [3:0] src1RegOut, destRegOut;
	
	always @(posedge clk) begin
		if (flush == 1'b1) begin
			{aluCalcOut, src1RegOut, destRegOut, regWrEnOut, memWrEnOut} <= 0;
		end
		if (wrEn == 1'b1) begin
			aluCalcOut <= aluCalcIn;
			src1RegOut <= src1RegIn;
			destRegOut <= destRegIn;
			regWrEnOut <= regWrEnIn;
			memWrEnOut <= memWrEnIn;
		end
	end
endmodule