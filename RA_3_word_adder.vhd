--This block adds 3 words of 2N-1 length using conventional Ripple carry adder

library ieee;
use ieee.std_logic_1164.all;

entity RA_3_word_adder is 
generic (N: integer := 8);
port (A,B,C : in std_logic_vector (2*N-1 downto 0); SUM : out std_logic_vector (2*N-1 downto 0));
end entity;

architecture logic of RA_3_word_adder is

component RA is 
--generic (N: integer := 16);
port (A,B : in std_logic_vector (2*N-1 downto 0); SUM : out std_logic_vector (2*N-1 downto 0));
end component;

signal t_sum : std_logic_vector (2*N-1 downto 0) := (others => '0');

begin

	dut_ra : RA port map (A,B,t_sum);
	dut_ra2 : RA port map (t_sum,C,SUM);

end architecture;