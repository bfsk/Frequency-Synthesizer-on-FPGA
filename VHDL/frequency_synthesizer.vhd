LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
ENTITY frequency_synthesizer IS
	PORT(
		SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		DA: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
		DB: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
		FPGA_CLK_A_N: INOUT STD_LOGIC;
		FPGA_CLK_A_P: INOUT STD_LOGIC;
		FPGA_CLK_B_P: INOUT STD_LOGIC;
		FPGA_CLK_B_N: INOUT STD_LOGIC;
		LEDG: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		OSC_50: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
END frequency_synthesizer;

ARCHITECTURE arch_frequency_synthesizer OF frequency_synthesizer IS
	
	
	COMPONENT frequency_selector IS 
		PORT(
			LEDG: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			BTN_UP: IN STD_LOGIC;
			BTN_DOWN: IN STD_LOGIC;
			CLK: IN STD_LOGIC;
			RST: IN STD_LOGIC;
			Y: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT phase_accumulator IS
		PORT(
			FREQUENCY: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
			CLK :IN STD_LOGIC;
			RST: IN STD_LOGIC;
			PHASE: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT dithering IS 
		PORT(
			LED: OUT STD_LOGIC;
			X: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
			EN: IN STD_LOGIC;
			CLK: IN STD_LOGIC;
			RST: IN STD_LOGIC;
			Y: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT quantiser_23_to_6_msb IS
		PORT(
			X: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
			Y: OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT bit_manipulator IS
		PORT(
			X: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			LOOKUP_TABLE: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			SGN: OUT STD_LOGIC
			);
	END COMPONENT;
	
	COMPONENT lookup_table IS
		PORT(
			X: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			Y: OUT STD_LOGIC_VECTOR(12 DOWNTO 0)
			);
	END COMPONENT;
	
	COMPONENT sine_completer IS
		PORT(
			X: IN STD_LOGIC_VECTOR(12 DOWNTO 0);
			SGN: IN STD_LOGIC;
			Y: OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
		);
	END COMPONENT;
	
	signal s_frequency: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal s_phase: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal s_dither: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal s_quant: STD_LOGIC_VECTOR(5 DOWNTO 0);
	signal s_lut: STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal s_half_sine: STD_LOGIC_VECTOR(12 DOWNTO 0);
	signal s_full_sine: STD_LOGIC_VECTOR(13 DOWNTO 0);
	signal s_sgn: STD_LOGIC;
	
	signal s_rst: STD_LOGIC;
	signal s_clk: STD_LOGIC;
	
begin
	s_clk <= OSC_50(0);
	s_rst <= not(KEY(0));
	

	
	a: frequency_selector PORT MAP(
		LEDG, not KEY(3), not KEY(1),s_clk, s_rst, s_frequency
	);
	b: phase_accumulator PORT MAP(
		s_frequency, s_clk, s_rst, s_phase
	);
	
	c: dithering PORT MAP(
		LEDR(0), s_phase, SW(0), s_clk, s_rst, s_dither
	);
	
	d: quantiser_23_to_6_msb PORT MAP(
		s_dither, s_quant
	);
	
	e: bit_manipulator PORT MAP(
		s_quant, s_lut, s_sgn
	);
	
	f: lookup_table PORT MAP(
		s_lut, s_half_sine
	);
	
	
	g: sine_completer PORT MAP(
		s_half_sine, s_sgn, s_full_sine
	);
	
	
	FPGA_CLK_B_N <= not(s_clk);
	FPGA_CLK_B_P <= not(s_clk);
	FPGA_CLK_A_N <= not(s_clk);
	FPGA_CLK_A_P <= not(s_clk);
	--FPGA_CLK_B_N <= s_clk;
	--FPGA_CLK_B_P <= not(s_clk);
	
	--DA<= s_lut&"0000000000";
	--rampa<=s_phase;
	DB <= s_full_sine;--s_phase(22 DOWNTO 9);
	DA <= s_lut & "000000000";
	--DA<= '0' & s_phase(22 DOWNTO 10);
	--DB <= s_full_sine;
	--DB<=s_phase(22 DOWNTO 10)& '0' ;
END ARCHITECTURE;