/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB,                   // I: Data from port B of regfile
	 
	//Test ports
	operandA_test,
	operandB_test,
	alucode_test,
	aluresult_test,
	pc_test
	
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 // Test ports
	 // When adding ports to waveform file you can edit this part.
	 // The naming convention is XXXX_test
	 //---------------------------------------------
	 output [31:0] operandA_test,operandB_test,aluresult_test;
	 output [4:0] alucode_test;
	 assign operandA_test = data_readRegA;
	 assign operandB_test = sign_mux_output;
	 assign aluresult_test = data_writeReg;
	 assign alucode_test = q_imem[6:2];
	 output [11:0]pc_test;
	 assign pc_test = pc;
	
	//---------------------------------------------
		//Stage 1

	 //output[11:0] pc_out;
	 wire [11:0] pc;
	 wire [11:0] ref_loc;
	 //assign pc_out = pc;
	 
	 //Get the address of imem where instruction is stored
	 pc_counter Pc_counter(
		.clk(clock),
		.rst(reset),
		.pc(pc),
		.loc(ref_loc)
	 );
	 
	 wire[11:0] ref_loc_buf;
	 assign ref_loc_buf = ref_loc + 12'd1;
	 
	 //fan-out wire to the output address_imem
	 assign address_imem[11:0] = pc[11:0];
	
	//--------------------------------------------------------------------------------------------
		//Stage 2
	
	//Control port initiation.
	//Please check that when new control bits are added
	wire DMwe, Rwe, Rwd, ALUinB, Branch, Jump, jal, jr;
	wire [1:0] insn_t;
	wire [31:0] rstatus;
	wire [4:0] ALUop;
	
	
	//generate the control signals
	control Control(q_imem[31:27],
						 q_imem[6:2], 					
						 DMwe,Rwe,Rwd,Branch,Jump,jal,jr, insn_t,
						 ALUop[4:0],ALUinB,
						 rstatus);
	

	//Different from lecture note.
	//Because Rd is in the higher bits[26:22], while in lecture note Rd is in lower bits.
	//There's no conflicts with instant number so the mux is neglected.
	
	 //Ra selection for bex
	 assign ctrl_readRegA[4:0] = (ALUop == 5'b10110) ? 5'b11110 : q_imem[21:17];//Rs
	
	 //Rb selection
	 wire[4:0] buffer_b;
  	 assign buffer_b[4:0] = (insn_t == 2'b00) ? q_imem[16:12] : q_imem[26:22];//Rt 	 
	 assign ctrl_readRegB[4:0] = (insn_t[0] == 1'b0) ? buffer_b[4:0] : 5'b00000;//Rt
	 
	 
	 
	 //The oval sign extension part
	 wire [31:0]sign_extension;
	 sign_extension Sign_extension(
		.in (q_imem[16:0]),
		.out (sign_extension[31:0])
	 );
	 
	 //The mux for branch instruction  
	 //NOTE : Assumed lower 12 bits of SX output
	 wire[11:0] br_op;
	 assign br_op = sign_extension[11:0] + ref_loc_buf[11:0];

	 //The mux after sign_extension
	 wire [31:0]sign_mux_output;
	 mux_32 Sign_extention_mux_32(
		.in0(data_readRegB[31:0]),
		.in1(sign_extension[31:0]),
		.out(sign_mux_output[31:0]),
		.sel(ALUinB)
	 );
	 
	 //--------------------------------------------------------------------------------------------
		//Stage 3
	 
	 //wires keep track of addnl ALU ops (!=, <, overflow)
	 wire alu_isNotEqual,alu_isLessThan,alu_overflow;
	 
	//store the result of ALU
	 wire[31:0] alu_result;
	 
	 //Alu part
	 alu Alu(
		.data_operandA(data_readRegA[31:0]),
		.data_operandB(sign_mux_output[31:0]),
		.ctrl_ALUopcode(ALUop),
		.ctrl_shiftamt(q_imem[11:7]),
		.data_result(alu_result[31:0]),
		.isNotEqual(alu_isNotEqual),
		.isLessThan(alu_isLessThan),
		.overflow(alu_overflow)
	 );
	
	 //Mux for branching 
	 wire br_ctrl, br_buf; 
	 wire [11:0] br_mux_op;//output of branching mux
	 
	 //buffer to switch between bne and blt
	 assign br_buf = (ALUop[4:0] == 5'b00010) ? alu_isNotEqual : alu_isLessThan;
	 assign br_ctrl = Branch & br_buf;
	 
	 //output of branching selected
	 mux_12 branch(ref_loc_buf[11:0], br_op[11:0], br_mux_op[11:0], br_ctrl);
	
	
    //Mux for jumping 
	 wire [11:0] jp_mux_op; // output of jumping mux
	 mux_12 jp(br_mux_op[11:0], q_imem[11:0], jp_mux_op[11:0], Jump);
	 
	 //Mux for jr
	 wire [11:0] jr_mux_op;
	 mux_12 jr_mux(jp_mux_op[11:0], data_readRegB[11:0], jr_mux_op[11:0], jr);
	
	 //Mux for bex
	 wire bex_buf;
	 wire [11:0] bex_mux_op;
	 assign bex_buf = (ALUop[4:0] == 5'b10110) ? 1'b1 : 1'b0;
	 assign bex_ctrl = bex_buf & alu_isNotEqual;
	 mux_12 bex_mux(jr_mux_op, q_imem[11:0], bex_mux_op, bex_ctrl);
	 
	 //Mux for jal
	 wire [11:0] pc_op;
	 mux_12 jal_mux(bex_mux_op, q_imem[11:0], pc_op, jal);
	 
	
	 //--------------------------------------------------------------------------------------------
		//Stage 4, 5
	 
	 //initiate data memory
	 assign wren = DMwe;
	 assign address_dmem[11:0] = alu_result[11:0];
    assign data[31:0] = data_readRegB[31:0];
	 
		
	 //The mux after data memory
	 wire [31:0]dmem_mux_output;
	 
	 mux_32 dmem_mux_32(
		.in0(alu_result[31:0]),
		.in1(q_dmem[31:0]),
		.out(dmem_mux_output[31:0]),
		.sel(Rwd)
	 );
	 
	 //------------------------------------------------------------------------------------------------
		//Stage 5
		
		
   //write back to reg file
	assign ctrl_writeEnable = Rwe;
	
	//control logic for writing to registers
	wire setx_en;
	assign setx_en = (ALUop[4:0] == 5'b10101) ? 1'b1 : 1'b0;
	
	//special case : overflow, change Rd
	wire [4:0] of_reg_buf;
	assign of_reg_buf[4:0] = (alu_overflow == 1'b1) ? 5'b11110 : q_imem[26:22];//Rd
	
	//special case : setx
	wire[4:0] setx_reg_buf;
	assign setx_reg_buf[4:0] = (setx_en == 1'b1) ? 5'b11110 : of_reg_buf[4:0];//Rd
	
	//final reg
	assign ctrl_writeReg[4:0] = (jal == 1'b1) ? 5'b11111 : setx_reg_buf[4:0];//Rd
	
	
	//special case : overflow, change data to be written by rstatus
	wire [31:0] final_out1;
	assign final_out1[31:0] = (alu_overflow == 1'b1) ? rstatus[31:0] : dmem_mux_output[31:0];
	
	//special case
	//prepare jal, setx output
	wire[31:0] jal_op, setx_op, final_out, final_out2;
	sx_12(ref_loc_buf, jal_op);
	sx_27(q_imem[26:0], setx_op);
	
	//special case : setx
	assign final_out2[31:0] = (setx_en == 1'b1) ? setx_op[31:0] : final_out1[31:0];
	
	//special case : jal
	assign final_out[31:0] = (jal == 1'b1) ? jal_op[31:0] : final_out2[31:0];
	
	//special case : register 0 : always 0
	assign data_writeReg[31:0] = (ctrl_writeReg[4:0] == 5'b00000) ? 32'd0 : final_out[31:0];
	
	//changed the pc finally
	assign ref_loc[11:0] = pc_op[11:0]; 
endmodule