module control(opcode,BR,JP,DMwe,Rwe,Rwd,Rdst,ALUop,ALUinB);
input [4:0] opcode;
output reg BR;
output reg JP;
output reg DMwe;
output reg Rwe;
output reg Rwd;
output reg Rdst;
output reg ALUop;
output reg ALUinB;

//assign Rdst = 1'b1;
always@(opcode) begin
	case(opcode)
		5'b00000:
		begin
		 BR = 1'b0;
       JP = 1'b0;
       DMwe = 1'b0;
       Rwd = 1'b0;
       ALUop = 1'b0;
       ALUinB = 1'b0;
		 Rdst = 1'b1;
		 Rwe = 1'b1;
		end
		5'b00101:
		begin
		 BR = 1'b0;
       JP = 1'b0;
       DMwe = 1'b0;
  		 Rwd = 1'b0;
 		 Rdst = 1'b0;
 		 ALUop = 1'b0;
		 Rwe = 1'b1;
		 ALUinB = 1'b1;
		end
endcase
end
endmodule