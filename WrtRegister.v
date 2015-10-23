module WrtRegister(clk, reset, wrtEn, dataIn, dataOut);

//same as Register.v but we only want to 
//write to memory/regFile on the negedge

//actually we probs don't need this if
//always @ negedge is in regFile/dMem

	parameter BIT_WIDTH = 32;
	parameter RESET_VALUE = 0;
	
	input clk, reset, wrtEn;
	input[BIT_WIDTH - 1: 0] dataIn;
	output[BIT_WIDTH - 1: 0] dataOut;
	reg[BIT_WIDTH - 1: 0] dataOut;
	
	always @(negedge clk) begin
		if (reset == 1'b1)
			dataOut <= RESET_VALUE;
		else if (wrtEn == 1'b1)
			dataOut <= dataIn;
	end
	
endmodule