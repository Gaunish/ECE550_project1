module sign_extension(in,out);
	input[16:0] in;
	output[31:0] out;
	
   assign out[15:0] = in[15:0];
	assign out[31] = in[16];
	assign out[30:16] = 4'h0000; 
endmodule