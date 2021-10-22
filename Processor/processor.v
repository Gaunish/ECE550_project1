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
	 assign operandB_test = sign_extension;
	 assign aluresult_test = data_writeReg;
	 assign alucode_test = q_imem[6:2];
	 output [11:0]pc_test;
	 assign pc_test = pc;
	 //---------------------------------------------


	 //output[11:0] pc_out;
	 wire [11:0] pc;
	 //assign pc_out = pc;
	 
	 //Get the address of imem where instruction is stored
	 pc_counter Pc_counter(
		.clk(clock),
		.rst(reset),
		.pc(pc)		
	 );
	 
	 
	 //fan-out wire to the output address_imem
	 assign address_imem[11:0] = pc[11:0];
	
	//--------------------------------------------------------------------------------------------
	
	
	//Control port initiation.
	//Please check that when new control bits are added
	wire DMwe, Rwe, Rwd, ALUinB, shift, type;
	wire [4:0] ALUop;
	
	
	//generate the control signals
	control Control(q_imem[31:27],
						 q_imem[6:2], 					
						 DMwe,Rwe,Rwd,
						 ALUop,ALUinB, shift);
	
	assign ctrl_writeEnable = Rwe;

	//Different from lecture note.
	//Because Rd is in the higher bits[26:22], while in lecture note Rd is in lower bits.
	//There's no conflicts with instant number so the mux is neglected.
	 assign ctrl_writeReg[4:0] = q_imem[26:22];//Rd
	 assign ctrl_readRegA[4:0] = q_imem[21:17];//Rs
	 assign ctrl_readRegB[4:0] = q_imem[16:12];//Rt
	 
	 //The oval sign extension part
	 wire [31:0]sign_extension;
	 sign_extension Sign_extension(
		.in (q_imem[16:0]),
		.out (sign_extension[31:0])
	 );
	 

	 //The mux after sign_extension
	 wire [31:0]sign_mux_output;
	 mux_32 Sign_extention_mux_32(
		.in0(data_readRegB[31:0]),
		.in1(sign_extension[31:0]),
		.out(sign_mux_output[31:0]),
		.sel(ALUinB)
	 );
	 
	 wire alu_isNotEqual,alu_isLessThan,alu_overflow;
	 wire[31:0] alu_result;
	 
	 //Alu part
	 alu Alu(
		.data_operandA(data_readRegA[31:0]),
		.data_operandB(sign_mux_output[31:0]),
		.ctrl_ALUopcode(5'b00000),//Assign to 0 right now because only add operation is performed
		.ctrl_shiftamt(q_imem[11:7]),
		.data_result(data_writeReg[31:0]),
		.isNotEqual(alu_isNotEqual),
		.isLessThan(alu_isLessThan),
		.overflow(alu_overflow)
	 );
	

	 
	 
	// pc_counter pc_counter()

endmodule