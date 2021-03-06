module DataMemory(clk, wrtEn, addr, dIn, dIn2, addr2, sw, key, ledr, hex, dOut, dOut2);
	parameter MEM_INIT_FILE;
	parameter ADDR_BIT_WIDTH = 32;
	parameter DATA_BIT_WIDTH = 32;
	parameter TRUE_ADDR_BIT_WIDTH = 11;
	parameter N_WORDS = (1 << TRUE_ADDR_BIT_WIDTH);
	
	input clk, wrtEn;
	input [3:0] key;
	input [9:0] sw;
	input [ADDR_BIT_WIDTH - 1 : 0] addr;
	input [DATA_BIT_WIDTH - 1 : 0] dIn;
	input dIn2;
	input [ADDR_BIT_WIDTH - 1 : 0] addr2;
	output [DATA_BIT_WIDTH - 1 : 0] dOut;
	output reg [9:0] ledr;	
	output reg [15:0] hex;
	output dOut2;
    
	(* ram_init_file = MEM_INIT_FILE *)
	reg [DATA_BIT_WIDTH - 1 : 0] data [0 : N_WORDS - 1];
	reg [TRUE_ADDR_BIT_WIDTH - 1 :0] addr_reg;
	reg [DATA_BIT_WIDTH - 1 : 0] sw_reg;
	reg [DATA_BIT_WIDTH - 1 : 0] key_reg;

	always @(posedge clk) begin
		if (addr[29]) begin
			if (wrtEn) begin
	  			if (addr[2]) ledr <= dIn[9:0];
				else if (addr[3]) begin end
				else hex <= (dIn[15:0] == 4'h0bad) ? 4'h0 : dIn[15:0];
	      	end else begin
	      		if (addr[2]) sw_reg <= sw;
	      		else key_reg <= (~key & 4'hf);
	      	end
      	end
    end
	 
	assign dOut2 = dOut21;

	always @(negedge clk) begin
		if (wrtEn && !addr[29]) data[addr[13:2]] <= dIn;	
		addr_reg <= addr[13:2];									
	end
	
	reg dOut21 = 1'b0;
	reg last = 1'b0;
	reg[1:0] counts = 2'b00;
	reg countsEn = 1'b0;
	
	always @(posedge dIn2) begin
		if(addr2 !== 32'h000002ac) begin
			dOut21 <= ~dOut21;
		end else begin
			if(countsEn == 1'b1) begin
				counts = counts + 1;
			end
			if(counts == 2'b11) begin
				dOut21 <= ~dOut21;
			end
			if(key == 4'b1111 && last == 1'b1) begin
				countsEn = 1'b1;
			end
			if(key != 4'b1111) begin
				last <= 1'b1;
			end
		end
	end

	assign dOut = addr[29] ? (addr[2] ? sw_reg : key_reg) : data[addr_reg];
endmodule







