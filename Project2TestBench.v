`timescale 1ns/1ps

module Project2TestBench;

  reg [9:0] SW;
  reg  [3:0] KEY;
  reg  CLOCK_50;
  
  wire [9:0] LEDR;
  wire [7:0] LEDG;
  wire [6:0] HEX0,HEX1,HEX2,HEX3;
  
  Project2 prj2(SW,KEY,LEDR,LEDG,HEX0,HEX1,HEX2,HEX3,CLOCK_50);
  
  initial begin
   #100
	$finish;
  end
	
  always
	#5 CLOCK_50 <= ~CLOCK_50;

endmodule

