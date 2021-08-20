--This block is for Carry Save adder
--It is a specific adder which adds 4 bits at a time
--It gives 3 outputs
library ieee;
use ieee.std_logic_1164.all;

entity CSA is 

	port (a,b,c,d,cy_in : in std_logic; cy1,cy2,sum : out std_logic);
end entity;


architecture logic of CSA is

component FA is 
	port (x,y,z : in std_logic ; s,c : out std_logic);
end component;

signal s : std_logic := '0';

begin

 dut1 : FA port map (a,b,c,s,cy1);
 dut2 : FA port map (s,d,cy_in,sum,cy2);
end architecture;



