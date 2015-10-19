module ALU(func, dataIn1, dataIn2, dataOut);

	input[31:0] dataIn1, dataIn2;
	input[4:0] func; //one bit for whether this is a comp or not
	
	output[31:0] dataOut;
	reg[31:0] dataOut;
	
	always@(*) begin //for combinational logic
		case(func) begin
		5'b00000: begin //ADD or ADDI or LD or ST - add imm for those
					dataOut <= dataIn1 + dataIn2;
					end;
		5'b00001: begin //SUB or SUBI
					dataOut <= dataIn1 - dataIn2;
					end;
		5'b00100: begin //AND or ANDI
					dataOut <= dataIn1 & dataIn2;
					end;
		5'b00101: begin //OR or ORI
					dataOut <= dataIn1 | dataIn2;
					end;
		5'b00110:begin // XOR or XORI
					dataOut <= dataIn1 ^ dataIn2;
					end
		5'b01100:begin // NAND or NANDI
					dataOut <= ~(dataIn1 & dataIn2);
					end
		5'b01101:begin // NOR or NORI
					dataOut <= ~(dataIn1 | dataIn2);
					end
		5'b01110:begin // XNOR or XNORI
					dataOut <= ~(dataIn1 ^ dataIn2);
					end
		5'b01011:begin // MVHI
					dataOut <= ((dataIn2 & 32'hFFFF0000));
					end
					
		//implement cmp, branch and ld/st
		 
		 
		 endcase
   end
endmodule