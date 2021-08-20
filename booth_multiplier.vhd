library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity booth_multiplier is 
generic (N: integer:= 8);
port (
	M,Q : in std_logic_vector ( N-1 downto 0);
	P : out std_logic_vector (2*N-1 downto 0));
end entity;

architecture logic of booth_multiplier is
type ar is array (0 to N) of std_logic_vector(2*N - 1 downto 0);
signal pp,pap,t_sum,t_carry,t_sum1,t_carry1 : ar := (others => (others => '0'));

component pp_cal is 
--generic (N: integer:= 16);
port (control : in std_logic_vector (2 downto 0); A : in std_logic_vector (N-1 downto 0); pp : out std_logic_vector(2*N - 1 downto 0));
end component;

component booth_adder is 
--generic (N: integer := 16);
port (pp0,pp1,pp2,pp3 : in std_logic_vector(2*N-1 downto 0);
sum,carry : out std_logic_vector(2*N-1 downto 0));
end component;


component RA_3_word_adder is 
--generic (N: integer := 16);
port (A,B,C : in std_logic_vector (2*N-1 downto 0); SUM : out std_logic_vector (2*N-1 downto 0));
end component;

signal control,control1 : std_logic_vector (2 downto 0);
signal k : integer := N/2+1;       --no of partial products
signal n1 : integer := (N/2+1)/4;
signal l : integer := 0;
signal P_temp1,p_temp2 : std_logic_vector(2*N - 1 downto 0):= (others=>'0');

begin


	control <= Q(1 downto 0) & '0';
	
	--Finding partial products which are stored temporarily in 2D array pp
	dut : pp_cal port map (control,M,pp(0));      --Finding first partial product by assuming '0' at left
	
	l1 : for i in 1 to (N-2)/2 generate
		dut1 : pp_cal port map(Q((2*i+1) downto (2*i-1)),M,pp(i));    --calculating other partial products
	end generate;
	
	control1 <= '0' & '0' & Q(N-1);
	dut2 : pp_cal port map (control1,M,pp((N/2)));             --calculating last pp, by asssuming '0' at right
	
	--Shifting partial products by appropriate weights and storing result in pap
	
	process (pp) begin
		l2 : for i in 0 to N/2 loop
			
			pap(i)((2*N - 1) downto 2*i) <= pp(i)((2*N-1-(2*i)) downto 0);
			
		end loop;
	end process;

	--Partial products are ready, now we need to add them
	--For adding Carry Save adder is used,which can add 1 column containing 4 bits (as compared to 3 bits in FA)
	--First 4 rows are given to boothadder (contains CSA) which in turn return two arrays of sum and carry
	
	b1 : booth_adder port map (pap(0),pap(1),pap(2),pap(3),t_sum(1),t_carry(1));
	
	--Result of first CSA gives 2 arrays sum and carry
	--Next 2 partial product rows along with results of first CSA are given to next CSA
	--This cycle continues till we are left with last partial product row
	
	l3 : for i in 1 to (N-6)/4 generate
	
		b2 : booth_adder port map (t_sum(i),t_carry(i),pap(i+3),pap(i+4),t_sum(i+1),t_carry(i+1));
		
	end generate;
	
	--Now we have two arrays of sum and carry along with last partial product array
	--these 3 rows are to be added
	--For addition of 3 words of 2N-1 length, RA_3_word_adder is used
	

	b3 : RA_3_word_adder port map (t_sum((N/4)-1),t_carry((N/4)-1),pap(N/2),P_temp1);
	
	b4 : RA_3_word_adder port map (pap(0),pap(1),pap(2),P_temp2);
	
	--4X4 is a special case where we get only 3 partial products
	--Hence in 4X4 case, CSA is used with fourth partial product row as zeroes
	--Then CSA outputs are added
 
	process (P_temp1,P_temp2) begin
	
		if (N = 4) then
			P <= P_temp2;
		else
			P<=P_temp1;
		end if;
	end process;
		
		
end architecture;

