# N-bit_booth
N-bit generic booth multiplier with carry save adders
Introduction
The conventional array multiplier computes partial product for every bit of multiplier by using AND gates. To speed up the multiplier, the number of partial products can be reduced by multiplying 2 bits at time. Since we have to add more than two bits at a time, we can design an adder architecture optimized for this. Booth algorithm and carry save adders can significantly speed up the multiplication.
Booth Encoding
	Let the multiplicand be M and multiplier be Q
	Depending upon the last two bits of Q (00,01,10,11), the partial products will be 0, A, 2A, and 3A
	0 and A can be produced easily
	2A and 3A can be generated as 4A-2A and 4A-A
	The task of adding 4A is passed on to the next group of 2 bits of the multiplier
	Since the place value of the next group of 2 bits is 4 times the current one, adding 4A is equivalent to adding 1 to the next group
The following table summarize the effective multiplier for generating the partial products
Current 2-bits	Multiplier of these	Previous MSB	Pending Increment	Total Multiplier
00	0	0	0	0
01	+1	0	0	1
10	-2	0	0	-2
11	-1	0	0	-1
00	0	1	+1	1
01	+1	1	+1	2
10	-2	1	+1	-1
11	-1	1	+1	0

Carry Save Adders
Ripple carry adders are slow due to rippling of carry. CSA can be used for adding 4 bits the same column. A 4 input 2 output CSA is shown in the following figure. 
 
The first full adder takes 3 bits of partial product of same weight. The sum output of first FA goes to next FA. The carry output ({cy}_1) goes as intermediate input to the CSA used in the column to the left of this. The second FA accept one more bit from partial product column. Even though {cy}_1 goes to the next CSA it does not ripple all the way horizontally, hence increase speed.
The following figure shows addition of 4 columns of 4 bits each. Rows are labelled as a, b, c, and d. Columns are 0, 1, 2, and 3.
 
Outputs are collected in two separate registers shown in dotted lines known as sum and carry registers. The contents are added using conventional ripple carry adder. 
 Simulation and Results
A VHDL code is written in Quartus and simulated in Modelsim. Following figure is taken from Modelsim window showing result of multiplication of two 8 bits numbers. 
 


Comparison with Array Multiplier using Timing Analysis
Timing analysis for 8-bit Booth multiplier and 8-bit array multiplier is done in Quartus. The result for worst case timing path for both the multipliers is shown in following figures.
 

  
Conclusion  
Design for Booth multiplication algorithm with Carry Save Adders is implemented in VHDL. Various test cases are given to check the proper functioning of implemented algorithm. The speed of operation of Booth multiplier is shown to be greater than array multiplier.
