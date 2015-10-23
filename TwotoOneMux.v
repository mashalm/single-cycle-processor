module TwotoOneMux(select, dataIn0, dataIn1, dataOut);
	parameter BIT_WIDTH = 32;

//use two 2to1Muxes back to back for 3 to 1 muxes

	input select;
	input[BIT_WIDTH-1:0] dataIn0, dataIn1;
	
	output reg[BIT_WIDTH-1:0] dataOut;
	
	always @ (*) begin
		if(select) //if select is one
			dataOut <= dataIn1;
		else
			dataOut <= dataIn0;
	end
	
endmodule
