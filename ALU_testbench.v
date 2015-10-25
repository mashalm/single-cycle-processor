`timescale 1ns / 1ps

module ALU_testbench;
	parameter DBITS = 32;
	// inputs
	reg[DBITS - 1:0] dataIn1, dataIn2;
	reg[4:0] func;
	
	// outputs
	wire[DBITS - 1:0] dataOut;
	wire compTrue;
	
	// module instantiation
	ALU #(.BIT_WIDTH(DBITS)) alu(func, dataIn1, dataIn2, dataOut, compTrue);
	
	initial begin
	
		//add
		func = 5'b00000;
		dataIn1 = 2;
		dataIn2 = 3;
		#10;
		$display("add: func = %d, dataIn1 = %d, dataIn2 = %d, dataOut = %d, compTrue = %d", func, dataIn1, dataIn2, dataOut, compTrue);
		
		//add
		func = 5'b00000;
		dataIn1 = -2;
		dataIn2 = 3;
		#10;
		$display("add: func = %d, dataIn1 = %d, dataIn2 = %d, dataOut = %d, compTrue = %d", func, dataIn1, dataIn2, dataOut, compTrue);
	
	
		//sub
		func = 5'b00001;
		dataIn1 = 5;
		dataIn2 = 2;
		#10;
		$display("sub: func = %d, dataIn1 = %d, dataIn2 = %d, dataOut = %d, compTrue = %d", func, dataIn1, dataIn2, dataOut, compTrue);
		
		//and
		func = 5'b00100;
		dataIn1 = 1;
		dataIn2 = 2;
		#10;
		$display("and: func = %d, dataIn1 = %d, dataIn2 = %d, dataOut = %d, compTrue = %d", func, dataIn1, dataIn2, dataOut, compTrue);
		
		//and
		func = 5'b00100;
		dataIn1 = 12;
		dataIn2 = 0;
		#10;
		$display("and: func = %d, dataIn1 = %d, dataIn2 = %d, dataOut = %d, compTrue = %d", func, dataIn1, dataIn2, dataOut, compTrue);
		
		//and
		func = 5'b00100;
		dataIn1 = -1;
		dataIn2 = 2;
		#10;
		$display("and: func = %d, dataIn1 = %d, dataIn2 = %d, dataOut = %d, compTrue = %d", func, dataIn1, dataIn2, dataOut, compTrue);
		
		
		// testing BEQ
		func = 5'b10001;
		dataIn1 = 2;
		dataIn2 = 2;
		#10
		$display("BEQ: func = %d, dataIn1 = %d, dataIn2 = %d, dataOut = %d, compTrue = %d", func, dataIn1, dataIn2, dataOut, compTrue);
		
		// testing BEQ 
		func = 5'b10001;
		dataIn1 = 2;
		dataIn2 = 3;
		#10
		$display("BEQ: func = %d, dataIn1 = %d, dataIn2 = %d, dataOut = %d, compTrue = %d", func, dataIn1, dataIn2, dataOut, compTrue);
				
		$finish;
	end

endmodule