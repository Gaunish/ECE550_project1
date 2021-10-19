module pc_counter(clk,rst,pc);
	input clk; //Input clock
	input rst; //Input rst
	
	//input [11:0] pc;//current pc
	output reg [11:0] pc;//next pc
	
	
	always@(posedge clk) begin
		if(rst)
			pc = 12'h000;
		else
<<<<<<< HEAD
			adder_4 A1(pc, new_pc);
			
=======
			pc = pc + 1;
	
		//pc = new_pc;
>>>>>>> f31abf467396d06ba32c41a13a9d3afdfda9e9c3
	end

endmodule