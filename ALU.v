module ALU(func, dataIn1, dataIn2, dataOut, compTrue);

	input[31:0] dataIn1, dataIn2;
	input[4:0] func; //one bit for whether this is a comp or not
	//so func = {compOrNot, iword[7:4]}
	
	output[31:0] dataOut;
	output compTrue;
	reg compTrue;
	reg[31:0] dataOut;
	
	
	always@(*) begin //for combinational logic
		case(func) begin
		5'b00000: begin //ADD or ADDI or LD or ST - add imm for those, or JAL
					dataOut <= dataIn1 + dataIn2;
					compTrue <= 1'b0; //no comparison happening
					end;
		5'b00001: begin //SUB or SUBI
					dataOut <= dataIn1 - dataIn2;
					compTrue <= 1'b0;
					end;
		5'b00100: begin //AND or ANDI
					dataOut <= dataIn1 & dataIn2;
					compTrue <= 1'b0;
					end;
		5'b00101: begin //OR or ORI
					dataOut <= dataIn1 | dataIn2;
					compTrue <= 1'b0;
					end;
		5'b00110: begin // XOR or XORI
					dataOut <= dataIn1 ^ dataIn2;
					compTrue <= 1'b0;
					end
		5'b01100: begin // NAND or NANDI
					dataOut <= ~(dataIn1 & dataIn2);
					compTrue <= 1'b0;
					end
		5'b01101: begin // NOR or NORI
					dataOut <= ~(dataIn1 | dataIn2);
					compTrue <= 1'b0;
					end
		5'b01110: begin // XNOR or XNORI
					dataOut <= ~(dataIn1 ^ dataIn2);
					compTrue <= 1'b0;
					end
		5'b01011: begin // MVHI
					dataOut <= ((dataIn2 & 32'hFFFF0000));
					compTrue <= 1'b0;
					end
		//below are the comparing instructions
		//so func = {1, iword[7:4]}
		5'b10000: begin //F or FI or BF
					dataOut <= 32'd0;
					compTrue <= 1'b0; //comparison is not "true"
					//what is the purpose of BF??
					end
		5'b10001: begin //EQ or EQI or BEQ
					dataOut <= (dataIn1 == dataIn2) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 == dataIn2) ? 1'b1 : 1'b0;
					end
		5'b10010: begin //LT or LTI or BLT
					dataOut <= (dataIn1 < dataIn2) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 < dataIn2) ? 1'b1 : 1'b0;
					end
		5'b10011: begin //LTE or LTEI or BLTE
					dataOut <= (dataIn1 <= dataIn2) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 <= dataIn2) ? 1'b1 : 1'b0;
					end
		5'b11000: begin //T or TI or BT
					dataOut <= 32'd1;
					compTrue <= 1'b1;
					end
		5'b11001: begin //NE or NEI or BNE
					dataOut <= (dataIn1 != dataIn2) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 != dataIn2) ? 1'b1 : 1'b0;
					end
		5'b11010: begin //GTE or GTEI or BGTE
					dataOut <= (dataIn1 >= dataIn2) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 >= dataIn2) ? 1'b1 : 1'b0;
					end
		5'b11011: begin //GT or GTI or BGT
					dataOut <= (dataIn1 > dataIn2) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 > dataIn2) ? 1'b1 : 1'b0;
					end
					
		//branch instructions below
		// func still = {1, iword[7:4]}
		//still need BEQZ, BLTZ, BLTEZ, BNEZ, BGTEZ, BGTZ
		5'b10101: begin //BEQZ
					//there is no RD so it doesn't matter what we output to dataOut?
					dataOut <= (dataIn1 == 32'd0) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 == 32'd0) ? 1'b1 : 1'b0;
					end
		5'b10110: begin //BLTZ
					dataOut <= (dataIn1 < 32'd0) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 < 32'd0) ? 1'b1 : 1'b0;
					end
		5'b10111: begin //BLTEZ
					dataOut <= (dataIn1 <= 32'd0) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 <= 32'd0) ? 1'b1 : 1'b0;
					end
		5'b11101: begin //BNEZ
					dataOut <= (dataIn1 != 32'd0) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 != 32'd0) ? 1'b1 : 1'b0;
					end
		5'b11110: begin //BGTEZ
					dataOut <= (dataIn1 >= 32'd0) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 >= 32'd0) ? 1'b1 : 1'b0;
					end
		5'b11111: begin //BGTZ
					dataOut <= (dataIn1 > 32'd0) ? 32'd1 : 32'd0;
					compTrue <= (dataIn1 > 32'd0) ? 1'b1 : 1'b0;
					end
		default: begin //required, output whatever?
					dataOut <= 32'd0;
					compTrue <= 1'b0;

		 endcase
   end
endmodule