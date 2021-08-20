library ieee;
use ieee.std_logic_1164.all;


entity FA is 
	port (x,y,z : in std_logic ; s,c : out std_logic);
end entity;


architecture logic of FA is

begin

	s <= x xor y xor z;
	c <= (x and y) or (y and z) or (z and x);
 
end architecture;