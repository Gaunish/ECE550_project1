module pc_counter(clk,rst,pc,new_pc);
	input clk; //Input clock
	input rst; //Input rst
	
	input [11:0] pc;//current pc
	output reg [11:0] new_pc;//next pc
	
	
	always@(posedge clk) begin
		if(rst)
			new_pc = 12'h000;
		else
			adder_4 A1(pc, new_pc);
			
	end

endmodule