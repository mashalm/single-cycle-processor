module TwotoOneMux_testbench;

	parameter BIT_WIDTH = 32;
	
	//in
	reg select;
	reg [BIT_WIDTH-1: 0] dataIn0, dataIn1;
	
	//out
	wire [(BIT_WIDTH-1): 0] dataOut;
	
	//instantiate
	TwotoOneMux tomux(select, dataIn0, dataIn1, dataOut);
	
	initial begin
		//select 0:
		select = 1'b0;
		dataIn0 = 32'd2;
		dataIn1 = 32'd4;
		#10
		$display("select = %d, dataIn0 = %d, dataIn1 = %d,dataOut = %d,",
		select, dataIn0, dataIn1, dataOut);
		
		//select 1:
		select = 1'b1;
		dataIn0 = 32'd2;
		dataIn1 = 32'd4;
		#10
		$display("select = %d, dataIn0 = %d, dataIn1 = %d,dataOut = %d,",
		select, dataIn0, dataIn1, dataOut);

		$finish;
	end
	
endmodule