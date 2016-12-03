//                              -*- Mode: Verilog -*-
// Filename        : Project2.v
// Description     : A single-cycle processor
// Author          : Lucas Christian and Joon Choi
//
module Project2(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,CLOCK_50,FPGA_RESET_N);
   input  [9:0] SW;
   input  [3:0] KEY;
   input  CLOCK_50;
   input  FPGA_RESET_N;
   output [9:0] LEDR;
   output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4;

   parameter DBITS         				 = 32;
   parameter INST_SIZE      			 = 32'd4;
   parameter INST_BIT_WIDTH				 = 32;
   parameter START_PC       			 = 32'h40;
   parameter REG_INDEX_BIT_WIDTH 		 = 4;
   parameter ADDR_KEY  					 = 32'hF0000010;
   parameter ADDR_SW   					 = 32'hF0000014;
   parameter ADDR_HEX  					 = 32'hF0000000;
   parameter ADDR_LEDR 					 = 32'hF0000004;

   parameter IMEM_INIT_FILE				 = "Test2.mif";
   parameter IMEM_ADDR_BIT_WIDTH 		 = 11;
   parameter IMEM_DATA_BIT_WIDTH 		 = INST_BIT_WIDTH;
   parameter IMEM_PC_BITS_HI     		 = IMEM_ADDR_BIT_WIDTH + 2;
   parameter IMEM_PC_BITS_LO     		 = 2;

   parameter DMEMADDRBITS 				 = 13;
   parameter DMEMWORDBITS				 = 2;
   parameter DMEMWORDS					 = 2048;

   // Interconnecting wires
   wire clk;                    // Clock
   wire reset;                  // Reset
   wire [15:0] hex;             // Hex output register value

   wire [DBITS - 1:0] pcIn;     // New PC input to PC register
   wire [DBITS - 1:0] pcOut;    // Output of PC register
   wire [DBITS - 1:0] pcIncremented; // Incremented PC (PC + 4)

   wire [DBITS - 1:0] brBase;        // Branch base value (added with offset to form new PC)
   wire [DBITS - 1:0] brBaseOffset;  // Branch offset (added to base to form new PC)

   wire [IMEM_DATA_BIT_WIDTH - 1: 0] instWord; // Instruction word from memory
   wire [3:0] opcode;                          // Decoded opcode
   wire [3:0] func;                            // Decoded function
   wire [3:0] rd;                              // Decoded dest reg. no.
   wire [3:0] rs1;                             // Decoded source reg. 1 no.
   wire [3:0] rs2;                             // Decoded source reg. 2 no.
   wire [15:0] immediate;                      // Decoded immediate bits
   wire [DBITS - 1:0] immval;                  // Sign-extended immediate value
   wire [DBITS - 1:0] instOffset;              // Immediate value shifted to word address
   wire rs1MuxSel;                             // rs1Mux select signal
   wire [1:0] rs2MuxSel;                       // rs2Mux select signal
   wire [1:0] alu2MuxSel;                      // alu2Mux select signal
   wire [3:0] aluOp;                           // ALU arithmetic function opcode
   wire [3:0] cmpOp;                           // ALU comparison function opcode
   wire [1:0] dstRegMuxSel;                    // dstRegMux select signal
   wire wrMem;                                 // write enable for data memory
   wire wrReg;                                 // write enable for register file
   wire [3:0] regWriteNo;                      // destination reg. number
   wire [3:0] regRead1No;                      // source reg. 1 number
   wire [3:0] regRead2No;                      // source reg. 2 number
   wire [DBITS - 1:0] regData1;                // source reg. 1 data
   wire [DBITS - 1:0] regData2;                // source reg. 2 data
   wire [DBITS - 1:0] wrRegData;               // data to write to destination register
   wire [DBITS - 1:0] a;                       // ALU operand A
   wire [DBITS - 1:0] b;                       // ALU operand B
   wire [DBITS - 1:0] aluResult;               // ALU arithmetic output
   wire condFlag;                              // ALU condition flag output
   wire [DBITS - 1:0] condRegResult;           // ALU condition flag result zero-extended
   wire [DBITS - 1:0] dataMemOut;              // Data memory output
   wire [9:0] debounced_SW;                    // debounced switches
	wire iFlush, dFlush, eFlush, mFlush;		  // flush signals for buffers
	
	wire [DBITS - 1:0] ibuffPc;					  // incremented pc from instruction buffer
	wire [DBITS - 1:0] ibuffInst;					  // instruction output from instruction buffer
	
	wire [DBITS - 1:0] dbuffPc;					  // incremented pc from decode buffer
	wire [DBITS - 1:0] dbuffregData1;           // decode buffer source reg. 1 data
   wire [DBITS - 1:0] dbuffregData2;           // decode buffer source reg. 2 data
	wire [DBITS - 1:0] dbuffimmval;             // Sign-extended immediate value from decode buffer
	wire [3:0] dbuffaluOp;                      // ALU arithmetic function opcode from decode buffer
   wire [3:0] dbuffcmpOp;                      // ALU comparison function opcode from decode buffer
	wire [1:0] dbuffalu2MuxSel;                 // alu2Mux select signal from decode buffer
	wire [3:0] dbuffregWriteNo;                 // destination reg. number from decode buffer
	wire dbuffwrMem;                            // write enable for data memory from decode buffer
   wire dbuffwrReg;                            // write enable for register file from decode buffer
	wire dbuffisLoadWord;							  // is load word flag from decode buffer
	wire [3:0] dbuffopcode;									  // opcode from decode buffer
	wire [1:0] dbuffdstRegMuxSel;               // dstRegMux select signal from decode buffer
	wire [DBITS - 1:0] dbuffinstOffset;         // Immediate value shifted to word address
	
	wire [DBITS - 1:0] ebuffPc;					  // incremented pc from execute buffer
	wire [DBITS - 1:0] ebuffregData2;           // execute buffer source reg. 2 data
	wire [DBITS - 1:0] ebuffaluResult;          // ALU arithmetic output from execute buffer
	wire [DBITS - 1:0] ebuffcondRegResult;      // ALU condition flag result zero-extended from execute buffer
	wire [3:0] ebuffregWriteNo;                 // destination reg. number from execute buffer
	wire ebuffwrMem;                            // write enable for data memory from execute buffer
   wire ebuffwrReg;                            // write enable for register file from execute buffer
	wire ebuffisLoadWord;							  // is load word flag from execute buffer
	wire [3:0] ebuffopcode;									  // opcode from execute buffer
	wire [1:0] ebuffdstRegMuxSel;   				  // dstRegMux select signal from execute buffer
	
	wire [DBITS - 1:0] mbuffwrRegData;          // data to write to destination register from memory buffer
	wire [3:0] mbuffregWriteNo;                 // destination reg. number from memory buffer
	wire mbuffwrReg;                            // write enable for register file from memory buffer
	wire [3:0] mbuffopcode;									  // opcode from memory buffer
	
	wire [1:0] reg1Mux, reg2Mux;					  // select for the two forwarding multiplexers
	
	wire [DBITS - 1:0] forwardReg1, forwardReg2; // the true values for reg1 and reg2
	
	wire isBranch, isJal;							  // represents whether the instruction is a branch or a jal
	wire isLoadWord;									  // is the instruction a load word which is used to either select alu result or mem read for writeback
	wire [DBITS - 1:0] truealuResult;               // ALU arithmetic output
	wire lwStall;										  // load word forwarding stall
	wire lwBuffered;
	wire [DBITS-1:0] preStallPc;					  // value of pc before the stall
	wire locked;
   // Clock divider and reset
   assign reset = ~FPGA_RESET_N;
	//assign reset = 1'b0;
   // We run at around 25 MHz. Timing analyzer estimates the design can support
   // around 33 MHz if we really wanted to
   ClockDivider clk_divider(CLOCK_50, clk, locked);
   
   //debounce SW
   Debouncer SW0(clk, SW[0], debounced_SW[0]);
   Debouncer SW1(clk, SW[1], debounced_SW[1]);
   Debouncer SW2(clk, SW[2], debounced_SW[2]);
   Debouncer SW3(clk, SW[3], debounced_SW[3]);
   Debouncer SW4(clk, SW[4], debounced_SW[4]);
   Debouncer SW5(clk, SW[5], debounced_SW[5]);
   Debouncer SW6(clk, SW[6], debounced_SW[6]);
   Debouncer SW7(clk, SW[7], debounced_SW[7]);
   Debouncer SW8(clk, SW[8], debounced_SW[8]);
   Debouncer SW9(clk, SW[9], debounced_SW[9]);   

   // Render HEX digits
   SevenSeg hex0Disp(hex[3:0], HEX0);
   SevenSeg hex1Disp(hex[7:4], HEX1);
   SevenSeg hex2Disp(hex[11:8], HEX2);
   SevenSeg hex3Disp(hex[15:12], HEX3);
	SevenSeg hex4Disp({(3){KEY[0]}}, HEX4);

	//------------------------INSTRUCTION FETCH--------------------------------------
   // Create PC and its logic
   //Register #(DBITS, START_PC) pc(clk, reset, 1'b1, pcIn, pcOut);
	PCRegister #(.BIT_WIDTH(DBITS), .RESET_VALUE(START_PC)) pc (clk, 1'b0, 1'b1, pcIn, pcOut);
   // Increment the PC by 4 for use in several places
   Adder #(DBITS) pcIncrementer(pcOut, 32'd4, pcIncremented);

   // BR/JAL base + offset calculation we choose base on whether the instruction in execute is a branch or a jal
   Multiplexer2bit #(DBITS) brBaseMux(dbuffPc, dbuffregData1, isJal, brBase);
   Adder #(DBITS) brOffsetAdder(brBase, dbuffinstOffset, brBaseOffset);

   // Take branch if we flushed which means that the instruciton in execute is a jal or if it is a branch and branch was taken
   Multiplexer2bit #(DBITS) nextPcMux(pcIncremented, brBaseOffset, iFlush, preStallPc);
	
	//Stalls pc for lw forwarding
	SpecialMultiplexer2bit #(DBITS) stallPc(preStallPc, dbuffPc, dFlush, pcIn);

   // Create instruction memory
   InstMemory #(IMEM_INIT_FILE, IMEM_ADDR_BIT_WIDTH, IMEM_DATA_BIT_WIDTH)
       instMem(pcOut[IMEM_PC_BITS_HI - 1: IMEM_PC_BITS_LO], instWord);
	
	// Create the instruction fetch buffer
	IBUFF instructionBuffer(pcIncremented, instWord, clk, (iFlush | dFlush), ibuffPc, ibuffInst);
	
	//------------------------DECODE--------------------------------------
	// Instruction decoder splits out all pertinent fields
   Decoder #(IMEM_DATA_BIT_WIDTH) decoder(ibuffInst, opcode, func, rd, rs1, rs2, immediate, isLoadWord);
	
	//
	
   // Sign extend the immediate value
   SignExtension #(16, DBITS) immSext(immediate, immval);

   // Instruction offset for use in BR/JAL calculations
   Shiftbit #(DBITS, 2) instOffsetShift(immval, instOffset);

   // Controller for decode. We only need certain signals here
   SCProcController decodeController(// Outputs
                               .rs1Mux          (rs1MuxSel),
                               .rs2Mux          (rs2MuxSel),
                               .alu2Mux         (alu2MuxSel[1:0]),
                               .aluOp           (aluOp[3:0]),
                               .cmpOp           (cmpOp[3:0]),
                               .wrReg           (wrReg),
                               .wrMem           (wrMem),
                               .dstRegMux       (dstRegMuxSel[1:0]),
                               // Inputs
                               .opcode          (opcode[3:0]),
                               .func            (func[3:0]));

   // Create the register file
   assign regWriteNo = rd;
   Multiplexer2bit #(4) rs1Mux(rs1, rd, rs1MuxSel, regRead1No);
   Multiplexer4bit #(4) rs2Mux(rs2, rd, rs1, 4'b0, rs2MuxSel, regRead2No);
   
   RegisterFile #(DBITS) regFile(clk, reset, mbuffwrReg, mbuffregWriteNo, regRead1No,
                                 regRead2No, regData1, regData2, mbuffwrRegData);

	// Create the decode buffer
	DBUFF decodeBuffer(ibuffPc, forwardReg1, forwardReg2, immval, instOffset, aluOp, cmpOp, alu2MuxSel, regWriteNo, wrReg, wrMem, isLoadWord, opcode, dstRegMuxSel, clk, dFlush,
								dbuffPc, dbuffregData1, dbuffregData2, dbuffimmval, dbuffinstOffset, dbuffaluOp, dbuffcmpOp, dbuffalu2MuxSel,
								dbuffregWriteNo, dbuffwrReg, dbuffwrMem, dbuffisLoadWord, dbuffopcode, dbuffdstRegMuxSel);
   //------------------------EXECUTE--------------------------------------
	// Create ALU unit
	assign condRegResult = {{DBITS - 1{1'b0}} ,{condFlag}};
   Alu #(DBITS) procAlu(a, b, dbuffaluOp, dbuffcmpOp, condFlag, aluResult);
	
	
	// Figures out if this instruction is a branch or a jal
	JalCheck BrJalCheck(dbuffopcode, isJal, isBranch);
	
	// Flushes the instruction buffer if this instrution is a jal or if this instruction is a branch and the branch is supposed to be taken or if we need to stall for load word
	assign iFlush = (isJal == 1'b1 || (isBranch == 1'b1 && condFlag == 1'b1)) ? 1'b1 : 1'b0;
	assign dFlush = (dbuffisLoadWord == 1'b1) ? 1'b1 : 1'b0;
	
   // Assign ALU inputs
   assign a = dbuffregData1;
   Multiplexer4bit #(DBITS) alu2Mux(dbuffregData2, dbuffimmval, 32'b0, 32'b0, dbuffalu2MuxSel, b);
	assign truealuResult = (dbuffopcode == 4'b1101 || dbuffopcode == 4'b0101) ? condRegResult : aluResult;
	
	// Create the execute buffer
	EBUFF executeBuffer(dbuffPc, dbuffregData2, aluResult, condRegResult, dbuffregWriteNo, dbuffwrReg, dbuffwrMem, dbuffisLoadWord, dbuffopcode, dbuffdstRegMuxSel, clk, eFlush,
								ebuffPc, ebuffregData2, ebuffaluResult, ebuffcondRegResult, ebuffregWriteNo, ebuffwrReg, ebuffwrMem, ebuffisLoadWord, ebuffopcode, ebuffdstRegMuxSel);
	
	//------------------------MEMORY--------------------------------------
   // Create Data Memory
   DataMemory #(IMEM_INIT_FILE)
      datamem(clk, ebuffwrMem, ebuffaluResult, ebuffregData2, debounced_SW, KEY, LEDR, hex, dataMemOut);
   // KEYS, SWITCHES, HEXS, and LEDS are memory mapped IO
	
	Multiplexer4bit #(DBITS) dstRegMux(ebuffaluResult, dataMemOut, ebuffPc,
                                      ebuffcondRegResult, ebuffdstRegMuxSel, wrRegData);
	
	// Create the memory buffer
	MBUFF memoryBuffer(wrRegData, ebuffregWriteNo, ebuffwrReg, ebuffopcode, clk, mFlush,
								mbuffwrRegData, mbuffregWriteNo, mbuffwrReg, mbuffopcode);
	
	//------------------------WRITEBACK--------------------------------------
	// Pretty much nothing happens here since we already have assigned the relevant values from the mbuff to the reg file
   
	
	//------------------------FORWARDING UNIT--------------------------------------
	//Forwarding transcends states
	Forwarding FU(opcode, dbuffopcode, ebuffopcode, mbuffopcode, regRead1No, regRead2No, dbuffregWriteNo, ebuffregWriteNo, mbuffregWriteNo, reg1Mux, reg2Mux, dbuffisLoadWord, lwStall);
	
	//Forwarding multiplexers
	ForwardMux FM1(regData1, truealuResult, wrRegData, mbuffwrRegData, reg1Mux, forwardReg1);
	ForwardMux FM2(regData2, truealuResult, wrRegData, mbuffwrRegData, reg2Mux, forwardReg2);
endmodule
