module Forwarding (opIn, opEx, opMem, opWb, reg1In, reg2In, regDestEx, regDestMem, regDestWb, reg1Mux, reg2Mux);
	parameter [1:0] REG = 2'b00, ALU = 2'b01, MEM = 2'b10, WB = 2'b11;
	parameter [3:0] SW = 4'b0011, BRANCH = 4'b0010;
	//Opcodes
	input [3:0] opIn, opEx, opMem, opWb;
	//Register indices
	input [3:0] reg1In, reg2In, regDestEx, regDestMem, regDestWb;
	//Forwarding mux opcode
	output [1:0] reg1Mux = 2'b00, reg2Mux = 2'b00;
	always @ (*) begin
		//Forwarding for reg1
		if (regDestEx == reg1In) begin
			if (opEx != SW || opEx != BRANCH) begin
				reg1Mux = ALU;
			end
		end
		else if (regDestMem == reg1In) begin
			if (opMem != SW || opMem != BRANCH) begin
				reg1Mux = MEM;
			end
		end
		else if (regDestWb == reg1In) begin
			if (opMem != SW || opMem != BRANCH) begin
				reg1Mux = WB;
			end
		end
		
		//Forwarding for reg2
		if (regDestEx == reg2In) begin
			if (opEx != SW || opEx != BRANCH) begin
				reg2Mux = ALU;
			end
		end
		else if (regDestMem == reg2In) begin
			if (opMem != SW || opMem != BRANCH) begin
				reg2Mux = MEM;
			end
		end
		else if (regDestWb == reg2In) begin
			if (opMem != SW || opMem != BRANCH) begin
				reg2Mux = WB;
			end
		end
	end
endmodule