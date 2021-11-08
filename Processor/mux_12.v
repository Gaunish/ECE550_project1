module mux_12(in0,in1,out,sel);
input [11:0] in0;
input [4:0] in1;
input sel;
output [11:0] out;
assign out = (sel==1'b0)?in0:in1;

endmodule