`timescale 1ns / 1ps

module SCProcController_testbench;
	parameter DBIT_SIZE = 32;
	
	// inputs
	reg[DBIT_SIZE - 1:0] iword;
	reg aluCompTrue;
	
	// outputs
	wire [4:0] aluFn;
	wire [3:0] rdIndex0, rdIndex1, wrtIndex;
	wire [15:0] imm;
	wire regFileWrtEn, dMemWrtEn;
	wire PCSel, aluSrc2Sel, regFileWrtSel, isJAL;	
	
	// instantiation
	SCProcController controller(iword, aluCompTrue, aluFn, rdIndex0, rdIndex1, wrtIndex, imm, regFileWrtEn, dMemWrtEn, aluSrc2Sel, PCSel, regFileWrtSel, isJAL);
	
	initial begin
		iword = 32'b01100111100000000000000000000000; // ADD s0, s1, s2
		aluCompTrue = 1'b0;
		#10;
		$display("ADD s0, s1, s2: aluFn: %d, rdIndex0: %d, rdIndex1: %d, wrtIndex: %d, imm: %d, regFileWrtEn: %d, dMemWrtEn: %d, PCSel: %d, aluSrc2Sel: %d, regFileWrtSel%d, isJAL: %d", aluFn, rdIndex0, rdIndex1, wrtIndex, imm, regFileWrtEn, dMemWrtEn, PCSel, aluSrc2Sel, regFileWrtSel, isJAL);
		
		
		
		$finish;
	end
endmodule