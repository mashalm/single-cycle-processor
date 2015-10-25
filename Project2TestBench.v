`timescale 1ns/1ps

module Project2TestBench;

  reg [9:0] SW;
  reg  [3:0] KEY;
  reg  CLOCK_50;
  
  wire [9:0] LEDR;
  wire [7:0] LEDG;
  wire [6:0] HEX0,HEX1,HEX2,HEX3;
  
  //parameter file	= "simpleTest.mif";
  
  //parameter DBITS = 32;
  
  //reg clk, reset, pcWrtEn;
  //wire[31:0] pcIn;
  
  //wire[31:0] pcOut;
  
  //reg[DBITS - 1:0] dataIn1, dataIn2;
  //reg[4:0] func;
	
	// outputs
  //wire[DBITS - 1:0] dataOut;
  //wire compTrue;
  
  Project2 prj2 (SW,KEY,LEDR,LEDG,HEX0,HEX1,HEX2,HEX3,CLOCK_50); 
  //Register #(.BIT_WIDTH(32), .RESET_VALUE(32'h40)) pc (clk, reset, pcWrtEn, pcIn, pcOut);
  
  //ALU #(.BIT_WIDTH(DBITS)) PcIncrementAlu(.func(5'b00000), .dataIn1(pcOut), .dataIn2(32'd4), 
  //.dataOut(dataOut), .compTrue(dontCare));
  
  //assign pcIn = dataOut;
 
  initial begin
   #100
	CLOCK_50 = 0;
	
	//clk = 0;
	//reset = 1;
	
	//pcWrtEn = 1;
	
	//$display("pcIn: %d, pcOut: %d", pcIn, pcOut);

	//$display("AluDataIn: %d, aluDataOut: %d", pcOut, dataOut);
	
	SW = 10'b0000000001;
	KEY = 4'b0001;
	
	$display("SW = %d, KEY = %d, LEDR = %d, HEX0 = %d, HEX1 = %d, HEX2 = %d, HEX3 = %d", SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);
	
	$finish;
  end
	
  always
	#5 CLOCK_50 <= ~CLOCK_50;
	//#5 clk <= ~clk;
endmodule

