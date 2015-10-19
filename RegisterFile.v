module RegisterFile(clk, wrtEn, wrtInd, RdInd0, RdInd1, dIn, dOut0, dOut1);

   parameter DBITS; // Number of data bits
   parameter ABITS; // Number of address bits
   parameter WORDS = (1<<ABITS);

	input clk, wrtEn;
	input [(ABITS-1): 0] wrtInd, rdInd0, rdInd1;
	input [(DBITS-1): 0] dIn;
	output wire [(DBITS-1): 0] dOut0, dOut1;
	
	reg[(DBITS-1):0] registers[0: 1<<WORDS];
	
	always @ (posedge clk) begin
		if(wrtEn == 1'b1) //for writing to regs
			registers[wrtInd] <= dIn;
	end
	
	//should this be synchronized to clock?
	assign dOut0 = registers[RdInd0];
	assign dOut1 = registers[RdInd1];


endmodule