LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY frequency_selector IS 
	PORT(
			LEDG: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			BTN_UP: IN STD_LOGIC;
			BTN_DOWN: IN STD_LOGIC;
			CLK: IN STD_LOGIC;
			RST: IN STD_LOGIC;
			Y: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
END frequency_selector;

ARCHITECTURE arch_frequency_selector OF frequency_selector IS
	COMPONENT debounce IS
	  GENERIC(
		 clk_freq    : INTEGER := 50_000_000;  --system clock frequency in Hz
		 stable_time : INTEGER := 10);         --time button must remain stable in ms
	  PORT(
		 clk     : IN  STD_LOGIC;  --input clock
		 reset_n : IN  STD_LOGIC;  --asynchronous active low reset
		 button  : IN  STD_LOGIC;  --input signal to be debounced
		 result  : OUT STD_LOGIC); --debounced signal
	END COMPONENT;
	
	COMPONENT delay_23_bit IS
			PORT(
				D : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
				CLK : IN STD_LOGIC;
				RST: IN STD_LOGIC;
				Q : OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
	END COMPONENT;	
	
	COMPONENT delay_1_bit IS
		PORT(
			D : IN STD_LOGIC;
			CLK : IN STD_LOGIC;
			RST: IN STD_LOGIC;
			Q : OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT full_adder_23_bit IS
		PORT( 
			X1: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
			X2: IN STD_LOGIC_VECTOR(22 DOWNTO 0);
			Y1: OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
		);
	END COMPONENT;
	
	signal s_btn_up: STD_LOGIC;
	signal s_btn_down: STD_LOGIC;
	signal s_sum_plus: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal s_sum_minus: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal s_sum_minus_a: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal s_sum: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal s_frequency: STD_LOGIC_VECTOR(22 DOWNTO 0);
	signal s_increment: STD_LOGIC_VECTOR(22 DOWNTO 0):="00000000000011010001101";
	signal s_initial_frequency: STD_LOGIC_VECTOR(22 DOWNTO 0):="00000000100000110001001"; 
	
	
	--10kHz = "00000000000011010001101"
	--100kHz= "00000000100000110001001";
	--1 MHz = "00000101000111101011100";
	--10 MHz ="00110011001100110011001";
	
	
	
	signal s_1:STD_LOGIC;
	signal s_2:STD_LOGIC;
BEGIN
	a: debounce PORT MAP(
		clk => CLK,
		reset_n => not(RST),
		button => BTN_UP,
		result => s_btn_up
	);	
	b: debounce PORT MAP(
			clk => CLK,
			reset_n => not(RST),
			button => BTN_DOWN,
			result => s_btn_down
		);	

	
	c:delay_23_bit PORT MAP(
		Q=> s_frequency,
		CLK => s_2 or (CLK and RST),
		RST => RST,
		D => s_sum
	);
	
	d:delay_1_bit PORT MAP(
		Q => s_2,
		CLK => CLK,
		RST => RST,
		D => s_1
	);

	s_1 <= s_btn_down xor s_btn_up;
	
	e: full_adder_23_bit PORT MAP(
		s_frequency, s_increment, s_sum_plus
	);
	
	f: full_adder_23_bit PORT MAP(
		not(s_increment), "00000000000000000000001", s_sum_minus_a
	);
	
	g: full_adder_23_bit PORT MAP(
		s_frequency, s_sum_minus_a, s_sum_minus
	);
	
	h: full_adder_23_bit PORT MAP(
		s_frequency, s_initial_frequency, Y
	);
	
	
	s_sum <= s_sum_minus when s_btn_down = '1' ELSE s_sum_plus;
	

	
	LEDG(0)<=s_btn_down;
	LEDG(1)<=s_btn_up;
	
END ARCHITECTURE;