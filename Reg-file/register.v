module register(input[31:0] d,
					 input en,
					 output[31:0] out,
					 input clk,
					 input clr,
					 input first);  
			
			wire[31:0] buffer;
			
			generate 
				genvar i;
				for(i = 0; i < 31; i = i + 1)begin : description
					dffe_ref DFF1(buffer[i], d[i], clk, en, clr);
					assign out[i] = first ? 1'b0 : buffer[i];
				end
			endgenerate
					
			
endmodule