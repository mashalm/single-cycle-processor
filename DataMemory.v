module DataMemory(clk, wrtEn, dIn, addrIn, dOut);

//parameters ----- look at iMem

	input clk, wrtEn;
	input[31:0] dIn;
	input[10:0] addrIn; //only 11 bits
	output[31:0] dOut;
	
	reg[31: 0] data[0: 10];

	assign dOut = data[addr];
	
	always @ (posedge clk) begin
		if(wrtEn == 1'b1) //for sw
			data[addr] = dIn;
	end
	
endmodule
	