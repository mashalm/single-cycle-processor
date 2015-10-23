module Project2(SW,KEY,LEDR,LEDG,HEX0,HEX1,HEX2,HEX3,CLOCK_50);
  input  [9:0] SW;
  input  [3:0] KEY;
  input  CLOCK_50;
  output [9:0] LEDR;
  output [7:0] LEDG;
  output [6:0] HEX0,HEX1,HEX2,HEX3;
 
  parameter DBITS         				 = 32;
  parameter INST_SIZE      			 = 32'd4;
  parameter INST_BIT_WIDTH				 = 32;
  parameter START_PC       			 = 32'h40;
  parameter REG_INDEX_BIT_WIDTH 		 = 4;
  parameter ADDR_KEY  					 = 32'hF0000010;
  parameter ADDR_SW   					 = 32'hF0000014;
  parameter ADDR_HEX  					 = 32'hF0000000;
  parameter ADDR_LEDR 					 = 32'hF0000004;
  parameter ADDR_LEDG 					 = 32'hF0000008;
  
  parameter IMEM_INIT_FILE				 = "Sorter2.mif";
  parameter IMEM_ADDR_BIT_WIDTH 		 = 11;
  parameter IMEM_DATA_BIT_WIDTH 		 = INST_BIT_WIDTH;
  parameter IMEM_PC_BITS_HI     		 = IMEM_ADDR_BIT_WIDTH + 2;
  parameter IMEM_PC_BITS_LO     		 = 2;
  
  parameter DMEMADDRBITS 				 = 13; //why 13?
  parameter DMEMWORDBITS				 = 2;
  parameter DMEMWORDS					 = 2048;
  
  parameter OP1_ALUR 					 = 4'b0000;
  parameter OP1_ALUI 					 = 4'b1000;
  parameter OP1_CMPR 					 = 4'b0010;
  parameter OP1_CMPI 					 = 4'b1010;
  parameter OP1_BCOND					 = 4'b0110;
  parameter OP1_SW   					 = 4'b0101;
  parameter OP1_LW   					 = 4'b1001;
  parameter OP1_JAL  					 = 4'b1011;
  
  // Add parameters for various secondary opcode values
  
  //PLL, clock genration, and reset generation
  wire clk, lock;
  //Pll pll(.inclk0(CLOCK_50), .c0(clk), .locked(lock));
  PLL	PLL_inst (.inclk0 (CLOCK_50),.c0 (clk),.locked (lock));
  wire reset = ~lock;
  
  // Create PC and its logic
  wire pcWrtEn = 1'b1;
  wire[DBITS - 1: 0] pcIn; // Implement the logic that generates pcIn; you may change pcIn to reg if necessary
  wire[DBITS - 1: 0] pcOut;
  // This PC instantiation is your starting point
  Register #(.BIT_WIDTH(DBITS), .RESET_VALUE(START_PC)) pc (clk, reset, pcWrtEn, pcIn, pcOut);

  // Create instruction memory
  wire[IMEM_DATA_BIT_WIDTH - 1: 0] instWord;
  InstMemory #(IMEM_INIT_FILE, IMEM_ADDR_BIT_WIDTH, IMEM_DATA_BIT_WIDTH) instMem (pcOut[IMEM_PC_BITS_HI - 1: IMEM_PC_BITS_LO], instWord);
  
  // Put the code for getting opcode1, rd, rs, rt, imm, etc. here 
 
  //wires controller needs: 
  //func for regFile
  //rs1 for regFile
  //rs2 for regFile
  //wrtIndex for regFile
  //imm for sext
  //regFileWrtEn for regFile
  //dMemWrtEn for dMem
  //aluSrc2Sel for first ALU Mux - 0 for rs2 and 1 for imm
  //not a wire but a mux we need: second ALU Mux - is JAL 0 for output of first ALU Mux and 1 for JAL imm
  //PCSel for first PC Mux - 0 for regular increment, 1 for branch
  //not a wire but: second PC Mux - isJAL 0 for output of first PC Mux and 1 for JAL address
  //regFileWrtSel for first regFile Mux: 0 for aluOut and 1 for memDOut
  //not a wire but: second regFile Mux: isJAL 0 for output of first mux, 1 for output of PCAlu (Pc+4)
  //isJAL: used in the three muxes described above
  wire[4:0] func;
  wire[REG_INDEX_BIT_WIDTH-1:0] rs1Index, rs2Index, destRegIndex;
  wire[15:0] imm;
  wire regFileWrtEn, dMemWrtEn;
  wire aluSrc2Sel, PCSel, regFileWrtSel, isJAL;
  SCProcController controller(.iword(instWord), .aluCompTrue(compTrue), .aluFn(func),
  .rdIndex0(rs1Index), .rdIndex1(rs2Index), .wrtIndex(destRegIndex), .imm(imm), .regFileWrtEn(regFileWrtEn), 
  .dMemWrtEn(dMemWrtEn), .aluSrc2Sel(aluSrc2Sel), .PCSel(PCSel), .regFileWrtSel(regFileWrtSel), .isJAL(isJAL));
  
  // Create the registers
  //not sure how the posedge and negedge registers fit in -- if at all
  
  wire[DBITS-1:0] rs1, rs2;
  RegisterFile #(.DBITS(DBITS), .ABITS(REG_INDEX_BIT_WIDTH), .WORDS(1<<REG_INDEX_BIT_WIDTH)) regFile(
	.clk(clk), .wrtEn(regFileWrtEn), .wrtInd(destReg), .rdInd0(rs1Index), .rdInd1(rs2Index), .dIn(regFileMux2Out), .dOut0(rs1), .dOut1(rs2));
	
	//regFileDataIn muxes:
	wire[DBITS-1:0] regFileMuxSecondInput;
	TwotoOneMux #(.BIT_WIDTH(DBITS)) regFileDataInMuxFirst(.select(regFileWrtSel), .dataIn0(aluOut), 
	.dataIn1(memDOut), .dataOut(regFileMuxSecondInput));
	wire[DBITS-1:0] regFileMux2Out;
	TwotoOneMux #(.BIT_WIDTH(DBITS)) regFileDataInMuxSecond(.select(isJAL), .dataIn0(regFileMuxSecondInput), 
	.dataIn1(PCincrement), .dataOut(regFileMux2Out));
	
  //Create ALU units
 
  //PC increment ALU
  wire[DBITS-1:0] PCincrement;
  ALU #(.BIT_WIDTH(DBITS)) PcIncrementAlu(.func(5'b00000), .dataIn1(pcOut), .dataIn2(32'd4), 
  .dataOut(PCincrement), .compTrue(dontCare));
 
  //PC Branch ALU: takes in PCincrement and sext(imm<<2)
  wire[DBITS-1:0] PCBranchAddr;
  ALU #(.BIT_WIDTH(DBITS)) PcBranchAlu(.func(5'b00000), .dataIn1(PCincrement), 
  .dataIn2(shiftedSextOut), .dataOut(PCBranchAddr), .compTrue(dontCare));
  
  //PC muxes:
  wire[DBITS-1:0] PCMuxSecondInput;
  TwotoOneMux #(.BIT_WIDTH(DBITS)) PCMuxFirst(.select(PCSel), .dataIn0(PCIncrement), 
   .dataIn1(PCBranchAddr), .dataOut(PCMuxSecondInput));
  wire[DBITS-1:0] PCAddrMuxOut;
  TwotoOneMux #(.BIT_WIDTH(DBITS)) PCMuxSecond(.select(isJAL), .dataIn0(PCMuxSecondInput), 
   .dataIn1(aluOut), .dataOut(PCAddrMuxOut));
	
  //IMPORTANT: assign PCIn to PCAddrMuxOut <- how to do that? Use reg orrrr?
  
  //Main ALU
  wire compTrue;
  wire[DBITS-1:0] aluOut;
  ALU #(.BIT_WIDTH(DBITS)) MainAlu(.func(func), .dataIn1(rs1), .dataIn2(aluSrc2MuxOut), 
  .dataOut(aluOut), .compTrue(compTrue));
  //aluSrc2 Muxes:
  wire[DBITS-1:0] aluMuxSecondInput;
  TwotoOneMux #(.BIT_WIDTH(DBITS)) aluMuxFirst(.select(aluSrc2Sel), .dataIn0(rs2), 
   .dataIn1(sextOut), .dataOut(aluMuxSecondInput));
  wire[DBITS-1:0] aluSrc2MuxOut;
  TwotoOneMux #(.BIT_WIDTH(DBITS)) aluMuxSecond(.select(isJAL), .dataIn0(aluMuxSecondInput), 
   .dataIn1(shiftedSextOut), .dataOut(aluSrc2MuxOut));

  //Logic for shifted immediate:
  wire[DBITS-1:0] shiftedSextOut = {sextOut[29:0], 2'b00};
  //^will that work? am i using wire correctly?
  
  //sign extend the immediate values
  wire[DBITS-1:0] sextOut;
  SignExtension #(16, DBITS)sext(.dIn(imm), .dOut(sextOut));
  
  
  // Put the code for data memory and I/O here
  //what are these parameters even?
  wire[9:0] ledrOut;
  wire[7:0] ledgOut;
  wire[15:0] hexOut;
  DataMemory #(.MEM_INIT_FILE(IMEM_INIT_FILE)) dataMem (.clk(clk), .wrtEn(dMemWrtEn), 
   .addr(aluOut[12:2]), .dIn(rs2), .sw(SW), .key(KEY), 
	.ledr(ledr), .ledg(ledg), .hex(hex), .dOut(memDOut));

  // KEYS, SWITCHES, HEXS, and LEDS are memory mapped IO
  assign LEDR = ledrOut;
  assign LEDG = ledgOut;
  assign HEX = hexOut;

endmodule

