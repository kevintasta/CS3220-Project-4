module ForwardMux (regOut, aluOut, memOut, wbOut, sel, muxOut);
	parameter [1:0] REG = 2'b00, ALU = 2'b01, MEM = 2'b10, WB = 2'b11;
	input [31:0] regOut, aluOut, memOut, wbOut;
	input [1:0] sel;
	output reg [31:0] muxOut;
	always @(*) begin
		case (sel)
			REG: muxOut <= regOut;
			ALU: muxOut <= aluOut;
			MEM: muxOut <= memOut;
			WB: muxOut <= wbOut;
		endcase
	end
endmodule