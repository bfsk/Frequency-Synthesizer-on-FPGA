LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY lookup_table IS
	PORT(
		X: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Y: OUT STD_LOGIC_VECTOR(12 DOWNTO 0)
		);
END lookup_table;

ARCHITECTURE arch_lookup_table OF lookup_table IS
begin

process(x) is
begin
	case x is
	when "00000" => y <= "0000000000000";
	when "00001" => y <= "0001100100011";
	when "00010" => y <= "0011000111110";
	when "00011" => y <= "0100101001010";
	when "00100" => y <= "0110000111111";
	when "00101" => y <= "0111100010101";
	when "00110" => y <= "1000111000111";
	when "00111" => y <= "1010001001100";
	when "01000" => y <= "1011010100000";
	when "01001" => y <= "1100010111100";
	when "01010" => y <= "1101010011011";
	when "01011" => y <= "1110000111000";
	when "01100" => y <= "1110110001111";
	when "01101" => y <= "1111010011110";
	when "01110" => y <= "1111101100010";
	when "01111" => y <= "1111111011000";
	when "10000" => y <= "1111111111111";
	when others => y <= "1111111111111";
	end case;
end process;
END ARCHITECTURE;