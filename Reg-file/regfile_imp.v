module regfile_imp(in,
						 enable,
						 clk,
						 clr,
						 first);
	input[31:0] in;
	input[31:0] enable;
	input clk;
	input clr;
	input first;
	wire[31:0] out[0:31];
	 
	 generate 
		genvar i;
			for(i = 0; i < 31; i = i + 1)begin : description
				register reg1(in, enable[i], out[i], clk, clr, first);
		end
	 endgenerate
	 

endmodule