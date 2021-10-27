Contributors :
1) Gaunish garg, netid : gg147
2) Zhou Sijie, netid :

Implementation
-----------------------------------------------------------------------------------------------------------------------

1) We instantiated Imem, Dmem by syncram components

2) We used our earlier implemented 32 bit mux

3) We used provided processor, register file for more accuracy

4) We implemented a sign extension component for immediate data bits

5) We implemented a control logic module which generated required flags according to the input instruction
    like DMwe, Rwe etc.

-------------------------------------------------------------------------------------------------------------------------

Flow 

1) Firstly we recieved IMEM address to read from PC

2) We read the intruction from PC

3) Then, we generated appropriate control signals from instruction via control module

4) We read stored data from registers via register file

5) We did sign extension to immediate bits ( if neccessary)

6) We performed the required instruction via ALU

7) We read/write data from/to data memory as required

8) We wroteback output data from mux to register file as required (ALU, data memory as input to mux)