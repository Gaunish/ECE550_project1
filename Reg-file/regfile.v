module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB,
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

	wire [31:0] decodeA;
	wire [31:0] decodeB;
	
	//Array used as a buffer to store output of registers
	wire[31:0] out[0:31];
	
	//Write Port
//----------------------------------------------------------------------------------------------------------------------	
	//Decode the input write control bit
	wire [31:0] ctrl_decode_write;
	decoder_5 dWrite(ctrl_writeReg[4:0],ctrl_decode_write[31:0]);
	
	//enable is the final write control bit
	//It is calculated by ANDing write enable, decoded write control bit
	wire[31:0] enable;
	
	//calculate the value of enable
	generate
		genvar j;
			for(j = 0;j < 32;j = j +1) begin: write
				and(enable[j],ctrl_decode_write[j],ctrl_writeEnable);
			end
	endgenerate
//----------------------------------------------------------------------------------------------------------------------	

  
	//Registers
//----------------------------------------------------------------------------------------------------------------------	
	//loop is used to write input data(if any) and store the output on buffer array out 
	generate 
		genvar i;
			register reg0(data_writeReg[31:0], enable[0], out[0], clock, ctrl_reset,1);
			for(i = 1; i < 32; i = i + 1)begin : description
			register reg1(data_writeReg[31:0], enable[i], out[i], clock, ctrl_reset,0);
		end
	 endgenerate
	 
//----------------------------------------------------------------------------------------------------------------------	


	//Read Port
//----------------------------------------------------------------------------------------------------------------------	
	//decode the input read control bits A, B
	wire [31:0] decode_readA;
	wire [31:0] decode_readB;
	
	decoder_5 dReadA(ctrl_readRegA[4:0],decode_readA[31:0]);
	decoder_5 dReadB(ctrl_readRegB[4:0],decode_readB[31:0]);
	
	//loop is used to calculate output for read port A,B
	// by adding the register buffer wire via tristates
	generate 
		genvar read;
			for(read = 0; read < 32; read = read + 1)begin : read_out
			tristate T1(out[read], decode_readA[read], data_readRegA);
			tristate T2(out[read], decode_readB[read], data_readRegB);
		end
	 endgenerate
//----------------------------------------------------------------------------------------------------------------------	
		
endmodule
