LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY delay_23_bit IS

	PORT(
      D : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		CLK : IN STD_LOGIC;
		RST: IN STD_LOGIC;
		Q : OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END delay_23_bit;

ARCHITECTURE arch_delay_23_bit OF delay_23_bit IS
	
BEGIN
process(CLK)
 begin 
	 if(rising_edge(CLK)) then
		if(RST='1') then 
		 Q <= "00000000000000000000000";
		else 
		 Q <= D; 
		end if;
	 end if;       
 end process;  
END ARCHITECTURE;