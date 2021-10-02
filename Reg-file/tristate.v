module tristate(input[31:0] in,
					 input enable,
					 output[31:0] out);
					
   generate 
		genvar i;
			for(i = 0; i < 32; i = i + 1)begin : description
			assign out[i] = enable ? in[i] : 1'bZ;
		end
	 endgenerate
					
endmodule	