LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sine_completer IS
	PORT(
		X: IN STD_LOGIC_VECTOR(12 DOWNTO 0);
		SGN: IN STD_LOGIC;
		Y: OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
	);
END sine_completer;

ARCHITECTURE arch_sine_completer OF sine_completer IS
begin
	Y <= '1' & X WHEN SGN = '0' ELSE not('1' & X);
END ARCHITECTURE;