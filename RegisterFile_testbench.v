module RegisterFile_testbench;

//issue: writing is done before reading
//whether on negedge or posedge

	parameter DBITS = 32;
   parameter ABITS = 4;
   parameter WORDS = (1<<ABITS);
	
	//in
	reg clk, wrtEn;
	reg [(ABITS-1): 0] wrtInd, rdInd0, rdInd1;
	reg [(DBITS-1): 0] dIn;
	
	//out
	wire [(DBITS-1): 0] dOut0, dOut1;
	
	//instantiate
	RegisterFile rf(clk, wrtEn, wrtInd, rdInd0, rdInd1, dIn, dOut0, dOut1);
	
	initial begin
		clk = 1'b1;
	
		//write back instruction:
		wrtEn = 1'b1;
		wrtInd = 4'b0110; //write to six
		rdInd0 = 4'b0110; //read from r6
		rdInd1 = 4'b1000;
		dIn = 32'd2;
		#10
		//inputs
		$display("wrtEn = %d, wrtIndex = %d, rdIndex0 = %d,readIndex1 = %d, dataIn = %d", wrtEn, wrtInd, rdInd0, rdInd1, dIn);
		//outputs
		$display("dOut0 = %d, dOut1 = %d", dOut0, dOut1);
		
		//write back instruction:
		wrtEn = 1'b1;
		wrtInd = 4'b1000; //write to eight
		rdInd0 = 4'b0110; //read from six
		rdInd1 = 4'b1000; //read from eight
		dIn = 32'd5;
		#10
		//inputs
		$display("wrtEn = %d, wrtIndex = %d, rdIndex0 = %d, readIndex1 = %d, dataIn = %d", wrtEn, wrtInd, rdInd0, rdInd1, dIn);
		//outputs
		$display("dOut0 = %d, dOut1 = %d", dOut0, dOut1);
		
		//write back instruction:
		wrtEn = 1'b1;
		wrtInd = 4'b1000; //write to eight
		rdInd0 = 4'b0110; //read from six
		rdInd1 = 4'b1000; //read from eight
		dIn = 32'd33;
		#10
		//inputs
		$display("wrtEn = %d, wrtIndex = %d, rdIndex0 = %d, readIndex1 = %d, dataIn = %d", wrtEn, wrtInd, rdInd0, rdInd1, dIn);
		//outputs
		$display("dOut0 = %d, dOut1 = %d", dOut0, dOut1);
		
		
		//read only instruction
		wrtEn = 1'b0;
		wrtInd = 4'b0110; //this should no longer matter
		rdInd0 = 4'b0110; //read from six
		rdInd1 = 4'b1000; //read from eight
		dIn = 32'd2; //also should no longer matter
		#10
		//inputs
		$display("wrtEn = %d, wrtIndex = %d, rdIndex0 = %d,readIndex1 = %d, dataIn = %d", wrtEn, wrtInd, rdInd0, rdInd1, dIn);
		//outputs
		$display("dOut0 = %d, dOut1 = %d", dOut0, dOut1);

		$finish;
	end
	
	always
		#5 clk <= ~clk;
	
endmodule