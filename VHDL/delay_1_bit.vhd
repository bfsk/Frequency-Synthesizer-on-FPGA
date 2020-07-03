LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY delay_1_bit IS
	PORT(
		D : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		RST: IN STD_LOGIC;
		Q : OUT STD_LOGIC
	);
END delay_1_bit;

ARCHITECTURE arch_delay_1_bit OF delay_1_bit IS
	
BEGIN
process(CLK)
 begin 
	 if(rising_edge(CLK)) then
		if(RST='1') then 
		 Q <= '0';
		else 
		 Q <= D; 
		end if;
	 end if;       
 end process;  
END ARCHITECTURE;