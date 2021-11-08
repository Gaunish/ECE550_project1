module sx_27(in,out);
	input[26:0] in;
	output[31:0] out;
	
   assign out[11:0] = in[11:0];
	
	//sign extend
	generate
		genvar i;
		
		for(i = 27; i < 32; i = i + 1) begin : L1
			
			assign out[i] = in[26];
		
		end
	endgenerate
	 
endmodule