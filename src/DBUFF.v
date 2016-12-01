module DBUFF(incPC, src1RegIn, src2RegIn, sextIn, offsetIn, aluOpIn, aluCmpIn, aluSelIn, destRegIn, regWrEnIn, memWrEnIn, isLWIn, opIn, dstRegMuxIn, clk, flush,
	incPCOut, src1RegOut, src2RegOut, sextOut, offsetOut, aluOpOut, aluCmpOut, aluSelOut, destRegOut, regWrEnOut, memWrEnOut, isLWOut, opOut, dstRegMuxOut);
	input flush, clk, regWrEnIn, memWrEnIn, isLWIn;
	input [31:0] incPC, sextIn, src1RegIn, src2RegIn, offsetIn;
	input [3:0] destRegIn, aluOpIn, aluCmpIn, opIn;
	input [1:0] aluSelIn, dstRegMuxIn;
	output reg [31:0] incPCOut = 0, sextOut = 0, src1RegOut = 0, src2RegOut = 0, offsetOut = 0;
	output reg regWrEnOut = 0, memWrEnOut = 0, isLWOut = 0;
	output reg [3:0] destRegOut = 0, aluOpOut = 0, aluCmpOut = 0, opOut = 0;
	output reg [1:0] aluSelOut = 0, dstRegMuxOut = 0;
	
	always @(posedge clk) begin
		if (flush == 1'b1) begin
			{incPCOut, src1RegOut, src2RegOut, sextOut, aluOpOut, aluSelOut, destRegOut, regWrEnOut, memWrEnOut} <= 0;
		end
		else begin
			incPCOut <= incPC;
			sextOut <= sextIn;
			regWrEnOut <= regWrEnIn;
			memWrEnOut <= memWrEnIn;
			aluSelOut <= aluSelIn;
			src1RegOut <= src1RegIn;
			src2RegOut <= src2RegIn;
			destRegOut <= destRegIn;
			aluOpOut <= aluOpIn;
			isLWOut <= isLWIn;
			aluCmpOut <= aluCmpIn;
			opOut <= opIn;
			offsetOut <= offsetIn;
			dstRegMuxOut <= dstRegMuxIn;
		end
	end
endmodule