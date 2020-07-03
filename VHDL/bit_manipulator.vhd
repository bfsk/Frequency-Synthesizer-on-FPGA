LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
ENTITY bit_manipulator IS
	PORT(
		X: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		LOOKUP_TABLE: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		SGN: OUT STD_LOGIC
		);
END bit_manipulator;

ARCHITECTURE arch_bit_manipulator OF bit_manipulator IS

	COMPONENT full_adder_23_bit IS
		PORT( 
			X1: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
			X2: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
			Y1: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
	END COMPONENT;
	
	signal s_1: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal log: STD_LOGIC;
begin
	SGN <= X(5);
	
	a: full_adder_23_bit PORT MAP(
		"0000000000000000000"&(not(X(3 DOWNTO 0))), "00000000000000000000001", s_1
	);
	
	log <= (X(4) and (not(X(3))) and (not(X(2))) and not(X(1)) and not(X(0))) or not(X(4));
	LOOKUP_TABLE <= X(4 DOWNTO 0) WHEN log='1' ELSE s_1(4 DOWNTO 0);
END ARCHITECTURE;