module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

	wire [31:0] decodeA;
	wire [31:0] decodeB;
	wire[31:0] out[0:31];
	
	//Write Port
	wire [31:0] decode_write;
	decoder_5 dWrite(ctrl_writeReg[4:0],decode_write[31:0]);
	wire[31:0] enable;
	generate
		genvar j;
			for(j = 0;j < 31;j = j +1) begin: write
				and(enable[j],decode_write[j],ctrl_writeEnable);
			end
	endgenerate
  
	//register
	generate 
		genvar i;
			register reg0(data_writeReg[4:0], enable[0], out[0], clock, ctrl_reset,1);
			for(i = 1; i < 31; i = i + 1)begin : description
			register reg1(data_writeReg[4:0], enable[i], out[i], clock, ctrl_reset,0);
		end
	 endgenerate
	 
	wire [31:0] decode_readA;
	wire [31:0] decode_readB;

	decoder_5 dReadA(ctrl_readRegA[4:0],decode_readA[31:0]);
	decoder_5 dReadB(ctrl_readRegB[4:0],decode_readB[31:0]);

	assign data_readRegA = out[decode_readA[31:0]];
	assign data_readRegB = out[decode_readB[31:0]];

	

endmodule
