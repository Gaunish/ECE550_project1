module control(opcode,alu_in,DMwe,Rwe,Rwd,ALUop,ALUinB);

input [4:0] opcode;
input [4:0] alu_in;

// DMwe : data memory write enable
// Rwe : reg file write enable
// Rwd : reg file writeback mux
// ALUop : ALU opcode
// ALUinB : ALU B mux
// flags if shift = 1
output reg DMwe;
output reg Rwe;
output reg Rwd;
output reg [4:0] ALUop;
output reg ALUinB;


//assign Rdst = 1'b1;
always@(opcode) begin
	case(opcode)
		
		//opcode = 00000, R type insn
		5'b00000:
		begin
		 
		 // decide flags on basis of alu_in (func)
		 case(alu_in)
	
			//add insn
			5'b00000:
			begin
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				ALUop = 5'b00000;
				ALUinB = 1'b0;
			end
			
			//sub insn
	    	5'b00001:
			begin
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				ALUop = 5'b00001;
				ALUinB = 1'b0;
			end
		
			//and insn
	    	5'b00010:
			begin
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				ALUop = 5'b00010;
				ALUinB = 1'b0;
			end	
			
			//or insn
	    	5'b00011:
			begin
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				ALUop = 5'b00011;
				ALUinB = 1'b0;
			end	
			
			//sll insn
	    	5'b00100:
			begin
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				ALUop = 5'b00100;
				ALUinB = 1'bZ;
			end
			
			//sra insn
	    	5'b00101:
			begin
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				ALUop = 5'b00101;
				ALUinB = 1'bZ;
			end
		
		 endcase
		
		end
		
		//opcode = 00101
		//I type instruction
		//addi instruction
		5'b00101:
		begin
			DMwe = 1'b0;
			Rwe = 1'b1;
			Rwd = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'b1;
		end
		
		//opcode = 00111
		//I type instruction
		//sw instruction
		5'b00111:
		begin
			DMwe = 1'b1;
			Rwe = 1'b0;
			Rwd = 1'bZ;
			ALUop = 5'b00000;
			ALUinB = 1'b1;
		end
		
		//opcode = 01000
		//I type instruction
		//lw instruction
		5'b01000:
		begin
			DMwe = 1'b0;
			Rwe = 1'b1;
			Rwd = 1'b1;
			ALUop = 5'b00000;
			ALUinB = 1'b1;
		end
endcase
end
endmodule