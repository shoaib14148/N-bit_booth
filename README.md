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
Ripple carry adders are slow due to rippling of carry. CSA can be used for adding 4 bits the same column. . 
 
The first full adder takes 3 bits of partial product of same weight. The sum output of first FA goes to next FA. The carry output ({cy}_1) goes as intermediate input to the CSA used in the column to the left of this. The second FA accept one more bit from partial product column. Even though {cy}_1 goes to the next CSA it does not ripple all the way horizontally, hence increase speed.
  
Conclusion  
Design for Booth multiplication algorithm with Carry Save Adders is implemented in VHDL. Various test cases are given to check the proper functioning of implemented algorithm. The speed of operation of Booth multiplier is shown to be greater than array multiplier.
