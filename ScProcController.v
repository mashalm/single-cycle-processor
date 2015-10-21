module SCProcController(iword, aluCompTrue, aluFn, rdIndex0, rdIndex1, wrtIndex, imm, 
regFileWrtEn, dMemWrtEn, aluSrc2Sel, PCSel, regFileWrtSel);

//use parameters later

	input[31:0] iword;
	input aluCompTrue;
	
	output[4:0] aluFn;
	output[3:0] rdIndex0, rdIndex1, wrtIndex;
	output[15:0] imm;
	output regFileWrtEn, dMemWrtEn;
	output[1:0] PCSel, aluSrc2Sel, regFileWrtSel;
	
	always @(*) (begin
		case(iword[31:28]) //look at primary opcode, output func
			4'b0000: begin //ALU-R instruction
			
			end
			4'b1000: begin //ALU-I instruction
			
			end
			4'b1001: begin //LW instruction
			
			end
			4'b0101: begin //SW instruction
			
			end
			4'b0010: begin //CMP-R instruction
			
			end
			4'b1010: begin //CPM-I instruction
			
			end
			4'b0110: begin //BRANCH instruction
			
			end
			4'b1011: begin //JAL instruction
			
			end
		endcase
	end
	
	
	
endmodule