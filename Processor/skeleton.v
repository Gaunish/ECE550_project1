/**
 * NOTE: you should not need to change this file! This file will be swapped out for a grading
 * "skeleton" for testing. We will also remove your imem and dmem file.
 *
 * NOTE: skeleton should be your top-level module!
 *
 * This skeleton file serves as a wrapper around the processor to provide certain control signals
 * and interfaces to memory elements. This structure allows for easier testing, as it is easier to
 * inspect which signals the processor tries to assert when.
 */

module skeleton(clock, reset, imem_clock, dmem_clock, processor_clock, regfile_clock,
 //Test ports
 data_writeReg_test,
 q_imem_test,
 ctrl_writeEnable_test,
 operandA_test,
 operandB_test,
 alucode_test,
 aluresult_test,
 ctrl_readRegA_test,
 ctrl_readRegB_test,
 pc_test,
 q_dmem_test,
 address_dmem_test,
 dmem_data_test,
 wren_test
 
	
);
    input clock, reset;
    /* 
        Create four clocks for each module from the original input "clock".
        These four outputs will be used to run the clocked elements of your processor on the grading side. 
        You should output the clocks you have decided to use for the imem, dmem, regfile, and processor 
        (these may be inverted, divided, or unchanged from the original clock input). Your grade will be 
        based on proper functioning with this clock.
    */
	 
	 //Clock dividingd
	 wire clk_div2, clk_div4, clk_div8;
	 frequency_divider_by2 frediv_1(clock,reset,clk_div2);
	 frequency_divider_by2 frediv_2(clk_div2,reset,clk_div4);
//	 assign imem_clock = ~clock;
//	 assign regfile_clock = clock;
//	 assign processor_clock = clk_div4; 
//	 assign dmem_clock = ~clk_div2;
//	 
//	 frequency_divider_by2 frediv_3(clk_div4,reset,clk_div8);
	 assign imem_clock = clock;
	 assign regfile_clock = clock;
	 assign processor_clock = clk_div4; 
	 assign dmem_clock = clock;
	 
	 //Test ports
	 //-----------------------------------------------------------------------------
	 output [31:0]data_writeReg_test;
	 assign data_writeReg_test = data_writeReg;
	 output [4:0]ctrl_readRegA_test,ctrl_readRegB_test;
	 assign ctrl_readRegA_test = ctrl_readRegA;
	 assign ctrl_readRegB_test = ctrl_readRegB;
	 
	 
	 output [31:0]q_imem_test;
	 assign q_imem_test = q_imem;
	 output ctrl_writeEnable_test;
	 assign ctrl_writeEnable_test = ctrl_writeEnable;
    output imem_clock, dmem_clock, processor_clock, regfile_clock;
	 
	 //alu testing
	 output [31:0] operandA_test,operandB_test,aluresult_test;
	 output [4:0] alucode_test;
	 
	 output [11:0]pc_test;
	 
	 output [11:0] address_dmem_test;
	 assign address_dmem_test = address_dmem;
    output [31:0] dmem_data_test;
    assign dmem_data_test = data;
    output [31:0] q_dmem_test;
	 assign q_dmem_test[31:0] = q_dmem[31:0];
	 output wren_test;
	 assign wren_test = wren;
	 //-----------------------------------------------------------------------------
	
	 
	 
    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_imem;
    wire [31:0] q_imem;
    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (imem_clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_dmem;
    wire [31:0] data;
    wire wren;
    wire [31:0] q_dmem;
    dmem my_dmem(
        .address    (address_dmem),       // address of data
        .clock      (dmem_clock),                  // may need to invert the clock
        .data	    (data),    // data you want to write
        .wren	    (wren),      // write enable
        .q          (q_dmem)    // data from dmem
    );

    /** REGFILE **/
    // Instantiate your regfile
    wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
    regfile my_regfile(
        regfile_clock,
        ctrl_writeEnable,
        reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB
    );

    /** PROCESSOR **/
    processor my_processor(
        // Control signals
        processor_clock,                          // I: The master clock
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
		  
		 //test
		 operandA_test,
		operandB_test,
		alucode_test,
		aluresult_test,
		pc_test
		 
    );

endmodule
