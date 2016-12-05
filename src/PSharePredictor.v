module PSharePredictor(clk, predictPC, updatePC, predict, update, reality, prediction);	
	
	input clk;						// clock
	input[15:0] predictPC; 		// PC to make prediction for	
	input[15:0] updatePC; 		// PC to update with branch taken
	input predict; 				// predict if hi
	input update; 					// update predictor if hi
	input reality; 				// if branch was actually taken or not 
	output prediction; 			// output prediction

	parameter PC_CHUNK_WIDTH = 12;
	parameter HISTORY_WIDTH = 12;
	parameter TABLE_SIZE = 4096;
	
	reg [HISTORY_WIDTH - 1:0] PHT[TABLE_SIZE - 1:0]; 		// initialize Pattern History Table
	reg [1:0] BHT[TABLE_SIZE - 1:0]; 							// initialize Branch History Table
	
	reg predReg = 1'b0;
	assign prediction = predReg;
	integer k;
	
	initial begin
		for(k = 0; k < TABLE_SIZE; k = k + 1) begin
			PHT[k] = 12'b0000_0000_0000;
			BHT[k] = 2'b10;
		end
	end
			
	always @(posedge clk) begin
		if(predict == 1'b1) begin
			predReg <= BHT[PHT[predictPC[PC_CHUNK_WIDTH - 1:0]]^ predictPC[PC_CHUNK_WIDTH - 1:0]][1];
		end
		
		if(update == 1'b1) begin
			// update BHT
			if(reality == 1'b1) begin
				if(BHT[PHT[updatePC[PC_CHUNK_WIDTH - 1:0]] ^ updatePC[PC_CHUNK_WIDTH - 1:0]] != 2'b11) begin
					BHT[PHT[updatePC[PC_CHUNK_WIDTH - 1:0]] ^ updatePC[PC_CHUNK_WIDTH - 1:0]] <= BHT[PHT[updatePC[PC_CHUNK_WIDTH - 1:0]] ^ updatePC[PC_CHUNK_WIDTH - 1:0]] + 1;
				end
			end else begin
				if(BHT[PHT[updatePC[PC_CHUNK_WIDTH - 1:0]] ^ updatePC[PC_CHUNK_WIDTH - 1:0]] != 2'b00) begin
					BHT[PHT[updatePC[PC_CHUNK_WIDTH - 1:0]] ^ updatePC[PC_CHUNK_WIDTH - 1:0]] <= BHT[PHT[updatePC[PC_CHUNK_WIDTH - 1:0]] ^ updatePC[PC_CHUNK_WIDTH - 1:0]] - 1;
				end
			end
			
			// update PHT
			PHT[updatePC[PC_CHUNK_WIDTH - 1:0]] <= PHT[updatePC[PC_CHUNK_WIDTH - 1:0]] << 1;
			PHT[updatePC[PC_CHUNK_WIDTH - 1:0]][0] <= reality;
		end
	end

endmodule