module Forwarding (opIn, opEx, opMem, opWb, reg1In, reg2In, regDestEx, regDestMem, regDestWb, reg1Mux, reg2Mux, isLW, lwStall);
	parameter [1:0] REG = 2'b00, ALU = 2'b01, MEM = 2'b10, WB = 2'b11;
	parameter [3:0] SW = 4'b0011, BRANCH = 4'b0010, NOP = 4'b0000;
	//Opcodes
	input [3:0] opIn, opEx, opMem, opWb;
	//Register indices
	input [3:0] reg1In, reg2In, regDestEx, regDestMem, regDestWb;
	input isLW;
	//Forwarding mux opcode
	output reg [1:0] reg1Mux = 2'b00, reg2Mux = 2'b00;
	output reg lwStall;
	always @ (*) begin
		lwStall = isLW;
		//Forwarding for reg1
		if (regDestEx == reg1In && (opEx != SW && opEx != BRANCH && opEx != NOP)) begin
			if (isLW == 1'b0) begin
				reg1Mux = ALU;
			end
			else begin
				reg1Mux = REG;
			end
		end
		else if (regDestMem == reg1In && (opMem != SW && opMem != BRANCH && opMem != NOP)) begin
			reg1Mux = MEM;
		end
		else if (regDestWb == reg1In && (opWb != SW && opWb != BRANCH && opWb != NOP)) begin
			reg1Mux = WB;
		end
		else begin
			reg1Mux = REG;
		end
		
		//Forwarding for reg2
		if (regDestEx == reg2In && (opEx != SW && opEx != BRANCH && opEx != NOP)) begin
			if (isLW == 1'b0) begin
				reg2Mux = ALU;
			end
			else begin
				reg2Mux = REG;
			end
		end
		else if (regDestMem == reg2In && (opMem != SW && opMem != BRANCH && opMem != NOP)) begin
			reg2Mux = MEM;
		end
		else if (regDestWb == reg2In && (opWb != SW && opWb != BRANCH && opWb != NOP)) begin
			reg2Mux = WB;
		end
		else begin
			reg2Mux = REG;
		end
	end
endmodule