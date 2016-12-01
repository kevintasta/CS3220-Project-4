module JalCheck(opCode, isJal, isBr);
	input [3:0] opCode;
	output reg isJal, isBr;
	always @(*) begin
		if (opCode == 4'b0110) begin
			isJal = 1'b1;
		end
		else begin
			isJal = 1'b0;
		end
		if (opCode == 4'b0010) begin
			isBr = 1'b1;
		end
		else begin
			isBr = 1'b0;
		end
	end
endmodule