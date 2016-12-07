`timescale 1ns / 1ps
module TestDataMemory();

	parameter MEM_INIT_FILE;
	parameter ADDR_BIT_WIDTH = 32;
	parameter DATA_BIT_WIDTH = 32;
	parameter TRUE_ADDR_BIT_WIDTH = 11;
	parameter N_WORDS = (1 << TRUE_ADDR_BIT_WIDTH);
	
	reg clk, wrtEn;
	reg [3:0] key;
	reg [9:0] sw;
	reg [ADDR_BIT_WIDTH - 1 : 0] addr;
	reg [DATA_BIT_WIDTH - 1 : 0] dIn;
	reg dIn2;
	reg [ADDR_BIT_WIDTH - 1 : 0] addr2;
	wire [DATA_BIT_WIDTH - 1 : 0] dOut;
	reg [9:0] ledr;	
	reg [15:0] hex;
	wire dOut2;
	
	DataMemory stuff(clk, wrtEn, addr, dIn, dIn2, addr2, sw, key, ledr, hex, dOut, dOut2);
	
	initial begin
		clk <= 1'b0;
		wrtEn <= 1'b0;
		key <= 4'b0000;
		sw <= 10'b0000000000;
		addr <= 32'd0;
		dIn <= 32'd0;
		ledr <= 10'd0;
		hex <= 16'd0;
		
		
		$stop;
		
	end


endmodule