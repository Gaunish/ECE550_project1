module control(opcode,alu_in,DMwe,Rwe,Rwd,Branch,Jump,jal,jr, Rt, ALUop,ALUinB, rstatus);

input [4:0] opcode;
input [4:0] alu_in;

// DMwe : data memory write enable
// Rwe : reg file write enable
// Rwd : reg file writeback mux
// Branch : if we have to branch to other address
// Jump : if we have to jump to other address
// ALUop : ALU opcode
// ALUinB : ALU B mux
// Rt : alternate between Rt and Rd for R, I type insn 
// flags if shift = 1
output reg DMwe;
output reg Rwe;
output reg Rwd;
output reg Branch;
output reg Jump;
output reg jal;
output reg jr;
output reg [1:0] Rt;
output reg [4:0] ALUop;
output reg ALUinB;
output reg [31:0] rstatus;


//assign Rdst = 1'b1;
always@(opcode,alu_in) begin
	case(opcode)
		
		//opcode = 00000, R type insn
		5'b00000:
		begin
		 
		 // decide flags on basis of alu_in (func)
		 case(alu_in)
	
			//add insn
			5'b00000:
			begin
				Rt = 2'b00;
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				jal = 1'b0;
				jr = 1'b0;
				ALUop = 5'b00000;
				ALUinB = 1'b0;
				rstatus = 32'd1;
			end
			
			//sub insn
	    	5'b00001:
			begin
				Rt = 2'b00;
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				jal = 1'b0;
				jr = 1'b0;
				ALUop = 5'b00001;
				ALUinB = 1'b0;
				rstatus = 32'd3;
			end
		
			//and insn
	    	5'b00010:
			begin
				Rt = 2'b00;
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				jal = 1'b0;
				jr = 1'b0;
				ALUop = 5'b00010;
				ALUinB = 1'b0;
				rstatus = 32'd0;
			end	
			
			//or insn
	    	5'b00011:
			begin
				Rt = 2'b00;
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				jal = 1'b0;
				jr = 1'b0;	
		   	ALUop = 5'b00011;
				ALUinB = 1'b0;
				rstatus = 32'd0;
			end	
			
			//sll insn
	    	5'b00100:
			begin
				Rt = 2'b00;
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				jal = 1'b0;
				jr = 1'b0;	
			   ALUop = 5'b00100;
				ALUinB = 1'bZ;
				rstatus = 32'd0;
			end
			
			//sra insn
	    	5'b00101:
			begin
				Rt = 2'b00;
				DMwe = 1'b0;
				Rwe = 1'b1;
				Rwd = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				jal = 1'b0;
				jr = 1'b0;
				ALUop = 5'b00101;
				ALUinB = 1'bZ;
				rstatus = 32'd0;
			end
		
		 endcase
		
		end
		
		//opcode = 00101
		//I type instruction
		//addi instruction
		5'b00101:
		begin
			Rt = 2'b01;
			DMwe = 1'b0;
			Rwe = 1'b1;
			Rwd = 1'b0;
			Branch = 1'b0;
			Jump = 1'b0;
			jal = 1'b0;
			jr = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'b1;
			rstatus = 32'd2;
		end
		
		//opcode = 00111
		//I type instruction
		//sw instruction
		5'b00111:
		begin
			Rt = 2'b01;
			DMwe = 1'b1;
			Rwe = 1'b0;
			Rwd = 1'b0;
			Branch = 1'b0;
			Jump = 1'b0;
			jal = 1'b0;
			jr = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'b1;
			rstatus = 32'd0;
		end
		
		//opcode = 01000
		//I type instruction
		//lw instruction
		5'b01000:
		begin
			Rt = 2'b01;
			DMwe = 1'b0;
			Rwe = 1'b1;
			Rwd = 1'b1;
			Branch = 1'b0;
			Jump = 1'b0;
			jal = 1'b0;
			jr = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'b1;
			rstatus = 32'd0;
		end
		
		//opcode = 00001
		//JI type instruction
		//j instruction
		5'b00001:
		begin 
			Rt = 2'b10;
			DMwe = 1'b0;
			Rwe = 1'b0;
			Rwd = 1'bZ;
			Branch = 1'b0;
			Jump = 1'b1;
			jal = 1'b0;
			jr = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'bZ;
			rstatus = 32'd0;
		end
		
		//opcode = 00010
		//I type instruction
		//bne instruction
		5'b00010:
		begin 
			Rt = 2'b01;
			DMwe = 1'b0;
			Rwe = 1'b0;
			Rwd = 1'bZ;
			Branch = 1'b1;
			Jump = 1'b0;
			jal = 1'b0;
			jr = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'b0;
			rstatus = 32'd0;
		end
		
		//opcode = 00011
		//JI type instruction
		//jal instruction
		5'b00011:
		begin 
			Rt = 2'b10;
			DMwe = 1'b0;
			Rwe = 1'b1;
			Rwd = 1'bZ;
			Branch = 1'b0;
			Jump = 1'b1;
			jal = 1'b1;
			jr = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'bZ;
			rstatus = 32'd0;
		end
		
		//opcode = 00100
		//JII type instruction
		//jr instruction
		5'b00100:
		begin 
			Rt = 2'b11;
			DMwe = 1'b0;
			Rwe = 1'b0;
			Rwd = 1'bZ;
			Branch = 1'b0;
			Jump = 1'b1;
			jal = 1'b0;
			jr = 1'b1;
			ALUop = 5'b00000;
			ALUinB = 1'bZ;
			rstatus = 32'd0;
		end
		
		//opcode = 00110
		//I type instruction
		//blt instruction
		5'b00110:
		begin 
			Rt = 2'b01;
			DMwe = 1'b0;
			Rwe = 1'b0;
			Rwd = 1'bZ;
			Branch = 1'b1;
			Jump = 1'b0;
			jal = 1'b0;
			jr = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'b0;
			rstatus = 32'd0;
		end
		
		//opcode = 10110
		//JI type instruction
		//bex instruction
		5'b10110:
		begin 
			Rt = 2'b10;
			DMwe = 1'b0;
			Rwe = 1'b0;
			Rwd = 1'bZ;
			Branch = 1'b1;
			Jump = 1'b0;
			jal = 1'b0;
			jr = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'b0;
			rstatus = 32'd0;
		end
		
		//opcode = 10101
		//JI type instruction
		//setx instruction
		5'b10101:
		begin 
			Rt = 2'b10;
			DMwe = 1'b0;
			Rwe = 1'b1;
			Rwd = 1'b0;
			Branch = 1'b0;
			Jump = 1'b0;
			jal = 1'b0;
			jr = 1'b0;
			ALUop = 5'b00000;
			ALUinB = 1'b1;
			rstatus = 32'd0;
		end
endcase
end
endmodule