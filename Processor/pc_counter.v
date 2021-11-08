module pc_counter(clk,rst,pc, loc);
	input clk; //Input clock
	input rst; //Input rst
	input [11:0] loc;
	//input [11:0] pc;//current pc
	output reg [11:0] pc;//next pc
	
	
	always@(posedge clk) begin
		if(rst)
			pc = 12'h000;
		else
			pc = pc + 1;
	
		//pc = new_pc;
	end

endmodule