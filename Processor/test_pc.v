module test_pc(clock,reset,pc_out)
	input clock;
	input reset;
	wire [11:0] pc;
	wire [11:0] pc_wire;
//reg[11:0] pc_wire;
	output [11:0] pc_out;
	assign pc_out = pc_wire;
	assign pc_wire = pc;
pc_counter Pc_counter(
		.clk(clock),
		.rst(reset),
		.pc(pc_wire),
		.new_pc(pc)
		);
)