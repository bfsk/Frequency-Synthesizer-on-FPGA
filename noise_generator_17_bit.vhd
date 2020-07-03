LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY noise_generator_17_bit IS 
	PORT(
			CLK: IN STD_LOGIC;
			RST: IN STD_LOGIC;
			Y: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
END noise_generator_17_bit;

ARCHITECTURE arch_noise_generator_17_bit OF noise_generator_17_bit IS
	COMPONENT delay_1_bit_i IS
		PORT(
			D : IN STD_LOGIC;
			CLK : IN STD_LOGIC;
			RST: IN STD_LOGIC;
			Q : OUT STD_LOGIC
		);
	END COMPONENT;

signal s_noise: STD_LOGIC_VECTOR(16 DOWNTO 0);
signal s_o: STD_LOGIC;
begin
	a: for i in 0 to 16 generate
			x: if i /= 0 generate
				aa: delay_1_bit_i PORT MAP(
					Q => s_noise(i),
					CLK => CLK,
					RST => RST,
					D => s_noise(i-1)
					);	
			end generate x;
		y: if i = 0 generate
				aa: delay_1_bit_i PORT MAP(
					Q => s_noise(i),
					CLK => CLK,
					RST => RST,
					D => s_o
					);	
			end generate y;	
	end generate a;
   --Generatorski polinom: x^17 + x^3 + 1
	s_o <= s_noise(16) xor s_noise(2);

	Y<= "000000" & s_noise;
END ARCHITECTURE;