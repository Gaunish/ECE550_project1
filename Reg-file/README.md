Group members :
1) Name : Gaunish Garg, Net ID : gg147
2) Name : Zhou Sijie, Net ID : sz232 


Register file (PROJECT CHECKPOINT 3)
-----------------------------------------------------------------------------------------------------------------------------------------------------
Implemented :- 1) 5 bit decoder
	       2) 32 bit Register
  	       3) Tristate buffer
	       4) Register file
	      
	      
Design Process :-  

1) Implemented a 32 bit register module which consists of 32 dffe_ref (given)
	
2) Implemented a 5 bit decoder module hierarchically on basis of 3 bit and 2 bit decoder.
	
3) Implemented Tristate buffer module for 32 bit input with function : (control ? input : Z)

4) Implemented a register file which consists of write port, registers and 2 read ports.
----------------------------------------------------------------------------------------------------------------------------------


Implementation :

1) For wiring of 32 (32-bit) registers, used an array of form (wire[31:0] buffer [0:31])

2) Used 5 bit decoder module 3 times to decode (ctrl_writeReg, ctrl_readRegA, ctrl_readRegB)

3) Ensured Register 0 always gives output 0 on basis of additional conditional statement

4) Used self-implemented tri-state buffer for output of the registers with control bit fanned-in from decoder of control_write bits A, B.

5) used write enable and control write bit to generate own write control bit
----------------------------------------------------------------------------------------------------------------------------------

how fast register file can be clocked?

We ran the regfile waveform with decreasing clock period and found:

Our register file can be clocked with minimum period of 15ns.
