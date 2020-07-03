LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY full_adder_23_bit IS
	PORT( 
		X1: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		X2: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		Y1: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END full_adder_23_bit;

ARCHITECTURE arch_full_adder_23_bit OF full_adder_23_bit IS
	COMPONENT one_bit_full_adder IS
		PORT( 
			A: IN STD_LOGIC;
			B: IN STD_LOGIC;
			Cin: IN STD_LOGIC;
			Cout: OUT STD_LOGIC;
			Y: OUT STD_LOGIC
		);
	END COMPONENT;
	signal s_C: STD_LOGIC_VECTOR(22 DOWNTO 0);
BEGIN
	FULL_ADD: for i in 0 to 22 generate
		FIRST_BIT: if i = 0 generate
			a: one_bit_full_adder PORT MAP(
				A => X1(i),
				B => X2(i),
				Cin => '0',
				Cout => s_C(i),
				Y => Y1(i)
				);
		end generate FIRST_BIT;
		OTHER_BITS: if i > 0 generate
			b: one_bit_full_adder PORT MAP(
				A => X1(i),
				B => X2(i),
				Cin => s_C(i-1),
				Cout => s_C(i),
				Y => Y1(i)
				);
		end generate OTHER_BITS;
 	end generate FULL_ADD;
END ARCHITECTURE;