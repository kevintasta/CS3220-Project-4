module BranchOffset(instr, pc, brOffset);
	input [31:0] instr, pc;
	output [31:0] brOffset;
	wire [31:0] immediate;
	SignExtension #(16, 32) immSext(instr[15:0], immval);
	assign brOffset = pc + immediate;
endmodule