library ieee;
use ieee.std_logic_1164.all;

entity RA is 
generic (N: integer := 8);
port (A,B : in std_logic_vector (2*N-1 downto 0); SUM : out std_logic_vector (2*N-1 downto 0));
end entity;


architecture logic of RA is


component FA is 
	port (x,y,z : in std_logic ; s,c : out std_logic);
end component;
signal c : std_logic_vector (2*N downto 0) := (others=>'0');
begin

	dut0 : FA port map (A(0),B(0),'0',SUM(0),c(1));
	
	l1 : for i in 1 to 2*N-1 generate
	
		dut1 : FA port map (A(i),B(i),c(i),SUM(i),c(i+1));
	
	end generate;

end architecture;
