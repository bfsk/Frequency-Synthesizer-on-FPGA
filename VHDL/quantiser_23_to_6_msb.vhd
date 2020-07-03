LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY quantiser_23_to_6_msb IS
	PORT(
		X: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		Y: OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END quantiser_23_to_6_msb;

ARCHITECTURE arch_quantiser_23_to_6_msb OF quantiser_23_to_6_msb IS
begin
	Y <= X(22 DOWNTO 17);
END ARCHITECTURE;