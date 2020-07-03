LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY one_bit_full_adder IS
	PORT( 
		A: IN STD_LOGIC;
		B: IN STD_LOGIC;
		Cin: IN STD_LOGIC;
		Cout: OUT STD_LOGIC;
		Y: OUT STD_LOGIC
	);
END one_bit_full_adder;

ARCHITECTURE arch_one_bit_full_adder OF one_bit_full_adder IS
BEGIN
	Y<= A XOR B XOR Cin;
	Cout <= ((A XOR B) and Cin) or (A AND B);
END ARCHITECTURE;