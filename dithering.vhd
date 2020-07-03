LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
ENTITY dithering IS 
	PORT(
		LED: OUT STD_LOGIC;
		X: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		EN: IN STD_LOGIC;
		CLK: IN STD_LOGIC;
		RST: IN STD_LOGIC;
		Y: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END dithering;

ARCHITECTURE arch_dithering OF dithering IS
	COMPONENT noise_generator_17_bit IS
		PORT(
			CLK: IN STD_LOGIC;
			RST: IN STD_LOGIC;
			Y: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT full_adder_23_bit IS
		PORT( 
			X1: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
			X2: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
			Y1: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
	END COMPONENT;
	

	signal s_noise: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal s_full_noise: STD_LOGIC_VECTOR(22 DOWNTO 0);
begin
  a: noise_generator_17_bit PORT MAP(
		CLK, RST, s_noise
  );
  
  b: full_adder_23_bit PORT MAP(
		s_noise, X, s_full_noise
  );
  
  Y <= s_full_noise WHEN EN = '1' ELSE X;
  
  LED <= EN;
END ARCHITECTURE;