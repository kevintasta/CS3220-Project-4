`timescale 1ns / 1ps
module TestGSharePredictor();

	reg clk;						
	reg[15:0] predictPC; 			
	reg[15:0] updatePC; 		
	reg predict; 				
	reg update; 					
	reg reality; 				
	wire prediction; 			
	
	GSharePredictor predictor(clk, predictPC, updatePC, predict, update, reality, prediction);
	
	initial begin
		// initial setup
		clk 			<= 1'b0;
		predictPC 	<= 16'h0000;
		updatePC 	<= 16'h0000;
		predict 		<= 1'b0;
		update 		<= 1'b0;
		reality 		<= 1'b0;
		#10;
		clk <= 1'b0;
		
		// Update F Predict T
		predictPC 	<= 16'h00AA;
		updatePC 	<= 16'h00AA;
		predict 		<= 1'b1;
		update 		<= 1'b1;
		reality 		<= 1'b0;
		clk 			<= 1'b1;
		#10;
		
		clk <= 1'b0;
		#10;
		
		// Update F Predict F
		predictPC 	<= 16'h00AA;
		updatePC 	<= 16'h00AA;
		predict 		<= 1'b1;
		update 		<= 1'b1;
		reality 		<= 1'b0;
		clk 			<= 1'b1;
		#10;
		
		clk <= 1'b0;
		#10;
		
		// Update T Predict F
		predictPC 	<= 16'h00AA;
		updatePC 	<= 16'h00AA;
		predict 		<= 1'b1;
		update 		<= 1'b1;
		reality 		<= 1'b1;
		clk 			<= 1'b1;
		#10;
		
		clk <= 1'b0;
		#10;
		
		// Predict T
		predictPC 	<= 16'h00AA;
		updatePC 	<= 16'h00AA;
		predict 		<= 1'b1;
		update 		<= 1'b0;
		reality 		<= 1'b0;
		clk 			<= 1'b1;
		#10;
		
		clk <= 1'b0;
		#10;
		

		
		$stop;
		
	end


endmodule