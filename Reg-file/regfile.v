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
	wire[31:0] out[0:31];
	
	//Write Port
	wire [31:0] ctrl_decode_write;
	decoder_5 dWrite(ctrl_writeReg[4:0],ctrl_decode_write[31:0]);
	wire[31:0] enable;
	generate
		genvar j;
			for(j = 0;j < 32;j = j +1) begin: write
				and(enable[j],ctrl_decode_write[j],ctrl_writeEnable);
			end
	endgenerate
  
	//register
	generate 
		genvar i;
			register reg0(data_writeReg[31:0], enable[0], out[0], clock, ctrl_reset,1);
			for(i = 1; i < 32; i = i + 1)begin : description
			register reg1(data_writeReg[31:0], enable[i], out[i], clock, ctrl_reset,0);
		end
	 endgenerate
	 
	wire [31:0] decode_readA;
	wire [31:0] decode_readB;

	decoder_5 dReadA(ctrl_readRegA[4:0],decode_readA[31:0]);
	decoder_5 dReadB(ctrl_readRegB[4:0],decode_readB[31:0]);
	
	wire[31:0] buffer_A[0:31];
	wire[31:0] buffer_B[0:31];

	 generate 
		genvar read;
			for(read = 0; read < 32; read = read + 1)begin : read_out
			tristate T1(out[read], decode_readA[read], buffer_A[read]);
			tristate T2(out[read], decode_readB[read], buffer_B[read]);
		end
	 endgenerate
	
	assign data_readRegA = buffer_A[ctrl_readRegA[4:0]];
	assign data_readRegB = buffer_B[ctrl_readRegB[4:0]];

	

endmodule
