LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY delay_1_bit_i IS
	PORT(
		D : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		RST: IN STD_LOGIC;
		Q : OUT STD_LOGIC
	);
END delay_1_bit_i;

ARCHITECTURE arch_delay_1_bit_i OF delay_1_bit_i IS
	signal s_q: STD_LOGIC:='1';
BEGIN
	Q <= s_q;

process(CLK)
 begin 
	 if(rising_edge(CLK)) then
		if(RST='1') then 
		 s_q <= '1';
		else 
		 s_q <= D; 
		end if;
	 end if;       
 end process;  
END ARCHITECTURE;