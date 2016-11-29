module DBUFF(incPC, src1RegIn, src2RegIn, sextIn, aluOpIn, aluCmpIn, aluSelIn, destRegIn, regWrEnIn, memWrEnIn, isLWIn, opIn, dstRegMuxIn, clk, flush,
	incPCOut, src1RegOut, src2RegOut, sextOut, aluOpOut, aluCmpOut, aluSelOut, destRegOut, regWrEnOut, memWrEnOut, isLWOut, opOut, dstRegMuxOut);
	input flush, clk, regWrEnIn, memWrEnIn, aluSelIn, isLWIn;
	input [31:0] incPC, sextIn, src1RegIn, src2RegIn;
	input [3:0] destRegIn, aluOpIn, aluCmpIn, opIn;
	input [1:0] dstRegMuxIn;
	output reg [31:0] incPCOut, sextOut, src1RegOut, src2RegOut;
	output reg regWrEnOut, memWrEnOut, aluSelOut, isLWOut;
	output reg [3:0] destRegOut, aluOpOut, aluCmpOut, opOut;
	output reg [1:0] dstRegMuxOut;
	
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
			src2RegOut <= src2RegOut;
			destRegOut <= destRegIn;
			aluOpOut <= aluOpIn;
			isLWOut <= isLWIn;
			opOut <= opIn;
			dstRegMuxOut <= dstRegMuxIn;
		end
	end
endmodule