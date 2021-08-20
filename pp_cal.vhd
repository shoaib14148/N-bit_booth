--this blobk calculates the partial products based on booth recoding matrix

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pp_cal is 
generic (N: integer := 8);
port (control : in std_logic_vector (2 downto 0); A : in std_logic_vector (N-1 downto 0); pp : out std_logic_vector(2*N - 1 downto 0));
end entity;

architecture logic of pp_cal is
signal A_1,A_2,A_p2 : std_logic_vector (2*N-1 downto 0) := (others => '1');
signal a_n : std_logic_vector(N-1 downto 0);
signal A_temp : std_logic_vector(2*N-1 downto 0) := (others => '0');
begin
	a_n <= not A;													--used for finding -A
	A_p2(N downto 1) <= A;										--used for finding 2A
	A_p2((2*N-1) downto (N+1)) <= (others => '0');		--shifting by 2
	A_p2(0) <= '0';
	
	A_1(N-1 downto 0) <= std_logic_vector(to_signed((to_integer(signed(a_n)) + 1),A'length)); --finding -A, adding 1 to 2's complement of A
	
	A_2(N downto 1) <= A_1(N-1 downto 0);       --finding -2A by shifting
	A_2(0) <= '0';
	
	A_temp(N-1 downto 0) <= A;

	--------------------Booth Recoding matrix 
	
	pp <= A_temp when control = "010" or control = "001"
	else A_1 when control = "110" or control = "101"
	else A_2 when control = "100"
	else A_p2 when control = "011"
	else (others => '0');
	


end architecture;