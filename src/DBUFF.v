module DBUFF(incPC, src1RegIn, src2RegIn, sextIn, aluOpIn, aluSelIn, destRegIn, regWrEnIn, memWrEnIn, clk, wrEn, flush,
	incPCOut, src1RegOut, src2RegOut, sextOut, aluOpOut, aluSelOut, destRegOut, regWrEnOut, memWrEnOut);
	input wrEn, flush, clk, regWrEnIn, memWrEnIn, aluSelIn;
	input [31:0] incPC, sextIn;
	input [3:0] src1RegIn, src2RegIn, destRegIn, aluOpIn;
	output reg [31:0] incPCOut, sextOut;
	output reg regWrEnOut, memWrEnOut, aluSelOut;
	output reg [3:0] src1RegOut, src2RegOut, destRegOut, aluOpOut;
	
	always @(posedge clk) begin
		if (flush == 1'b1) begin
			{incPCOut, src1RegOut, src2RegOut, sextOut, aluOpOut, aluSelOut, destRegOut, regWrEnOut, memWrEnOut} <= 0;
		end
		if (wrEn == 1'b1) begin
			incPCOut <= incPC;
			sextOut <= sextIn;
			regWrEnOut <= regWrEnIn;
			memWrEnOut <= memWrEnIn;
			aluSelOut <= aluSelIn;
			src1RegOut <= src1RegIn;
			src2RegOut <= src2RegOut;
			destRegOut <= destRegIn;
			aluOpOut <= aluOpIn;
		end
	end
endmodule