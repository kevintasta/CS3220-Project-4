module TournamentPredictor(clk, predictPC, updatePC, predict, update, gReality, pReality, reality, gPrediction, pPrediction, prediction);	
	
	input clk;						// clock
	input[15:0] predictPC; 		// PC to make prediction for	
	input[15:0] updatePC; 		// PC to update with branch taken
	input predict; 				// predict if hi
	input update; 					// update predictor if hi
	input gReality; 
	input pReality; 
	input reality; 				// if branch was actually taken or not
	output gPrediction; 
	output pPrediction; 
	output prediction; 			// output prediction

	parameter PC_CHUNK_WIDTH = 12;
	parameter HISTORY_WIDTH = 12;
	parameter TABLE_SIZE = 4096;
	
	reg [1:0] META[TABLE_SIZE - 1:0]; 	// initialize Meta Predictor Table
	
	wire gSharePred, pSharePred;
	assign gPrediction = gSharePred;
	assign pPrediction = pSharePred;
	
	//reg predReg = 1'b0;
	//assign prediction = predReg;
	integer k;
	
	GSharePredictor gshare(clk, predictPC, updatePC, predict, update, reality, gSharePred);
	PSharePredictor pshare(clk, predictPC, updatePC, predict, update, reality, pSharePred);
	
	initial begin
		for(k = 0; k < TABLE_SIZE; k = k + 1) begin
			META[k] = 2'b10;
		end
	end
	
	assign prediction = (META[predictPC[PC_CHUNK_WIDTH - 1:0]][1] == 1'b1) ? pSharePred :
																									 gSharePred ;
	//gshare = NT, pshare = T
	always @(posedge clk) begin

		
		// update predictions
		if(update == 1'b1) begin
			// 10 g good / p bad
			if(gReality == reality && pReality != reality) begin
				if(META[predictPC[PC_CHUNK_WIDTH - 1:0]] == 2'b00) begin
					META[predictPC[PC_CHUNK_WIDTH - 1:0]] <= META[predictPC[PC_CHUNK_WIDTH - 1:0]] - 1;
				end
			// 01 g bad / p good
			end else if(gReality != reality && pReality == reality) begin
				if(META[predictPC[PC_CHUNK_WIDTH - 1:0]] == 2'b11) begin
					META[predictPC[PC_CHUNK_WIDTH - 1:0]] <= META[predictPC[PC_CHUNK_WIDTH - 1:0]] + 1;
				end
			end
		end
		
	end

endmodule