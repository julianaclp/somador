LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;

PACKAGE lookupTable IS 
	PROCEDURE lut(input: IN SIGNED(size*2-1 DOWNTO 0); outReal, outComplex: OUT SIGNED(size-1 DOWNTO 0));
END lookupTable;

PACKAGE BODY lookupTable IS
	PROCEDURE lut(input: IN SIGNED(size*2-1 DOWNTO 0); outReal, outComplex: OUT SIGNED(size-1 DOWNTO 0)) IS
	BEGIN
		CASE input IS
			WHEN "000000" => outReal := "011"; outComplex := "001";
			WHEN "000001" => outReal := "011"; outComplex := "101";
			WHEN "000010" => outReal := "111"; outComplex := "101";
			WHEN "000011" => outReal := "110"; outComplex := "001";
			WHEN "000100" => outReal := "111"; outComplex := "010";
			WHEN "000101" => outReal := "001"; outComplex := "010";
			WHEN "000110" => outReal := "000"; outComplex := "001";
			WHEN "000111" => outReal := "111"; outComplex := "011";
			WHEN "001000" => outReal := "101"; outComplex := "011";
			WHEN "001001" => outReal := "000"; outComplex := "100";
			WHEN "001010" => outReal := "010"; outComplex := "111";
			WHEN "001011" => outReal := "100"; outComplex := "010";
			WHEN "001100" => outReal := "000"; outComplex := "111";
			WHEN "001101" => outReal := "001"; outComplex := "101";
			WHEN "001110" => outReal := "010"; outComplex := "001";
			WHEN "001111" => outReal := "010"; outComplex := "101";
			WHEN "010000" => outReal := "000"; outComplex := "010";
			WHEN "010001" => outReal := "111"; outComplex := "101";
			WHEN "010010" => outReal := "110"; outComplex := "000";
			WHEN "010011" => outReal := "101"; outComplex := "010";
			WHEN "010100" => outReal := "101"; outComplex := "000";
			WHEN "010101" => outReal := "010"; outComplex := "000";
			WHEN "010110" => outReal := "101"; outComplex := "111";
			WHEN "010111" => outReal := "101"; outComplex := "001";
			WHEN "011000" => outReal := "111"; outComplex := "010";
			WHEN "011001" => outReal := "010"; outComplex := "111";
			WHEN "011010" => outReal := "011"; outComplex := "110";
			WHEN "011011" => outReal := "011"; outComplex := "110";
			WHEN "011100" => outReal := "101"; outComplex := "001";
			WHEN "011101" => outReal := "000"; outComplex := "001";
			WHEN "011110" => outReal := "011"; outComplex := "111";
			WHEN "011111" => outReal := "110"; outComplex := "000";
			WHEN "100000" => outReal := "101"; outComplex := "000";
			WHEN "100001" => outReal := "001"; outComplex := "000";
			WHEN "100010" => outReal := "100"; outComplex := "001";
			WHEN "100011" => outReal := "101"; outComplex := "010";
			WHEN "100100" => outReal := "111"; outComplex := "010";
			WHEN "100101" => outReal := "001"; outComplex := "011";
			WHEN "100110" => outReal := "111"; outComplex := "010";
			WHEN "100111" => outReal := "111"; outComplex := "110";
			WHEN "101000" => outReal := "010"; outComplex := "111";
			WHEN "101001" => outReal := "000"; outComplex := "111";
			WHEN "101010" => outReal := "101"; outComplex := "110";
			WHEN "101011" => outReal := "011"; outComplex := "110";
			WHEN "101100" => outReal := "010"; outComplex := "001";
			WHEN "101101" => outReal := "000"; outComplex := "110";
			WHEN "101110" => outReal := "000"; outComplex := "111";
			WHEN "101111" => outReal := "101"; outComplex := "011";
			WHEN "110000" => outReal := "001"; outComplex := "010";
			WHEN "110001" => outReal := "111"; outComplex := "001";
			WHEN "110010" => outReal := "111"; outComplex := "010";
			WHEN "110011" => outReal := "101"; outComplex := "000";
			WHEN "110100" => outReal := "101"; outComplex := "101";
			WHEN "110101" => outReal := "110"; outComplex := "100";
			WHEN "110110" => outReal := "010"; outComplex := "011";
			WHEN "110111" => outReal := "001"; outComplex := "001";
			WHEN "111000" => outReal := "010"; outComplex := "010";
			WHEN "111001" => outReal := "011"; outComplex := "011";
			WHEN "111010" => outReal := "100"; outComplex := "100";
			WHEN "111011" => outReal := "101"; outComplex := "101";
			WHEN "111100" => outReal := "110"; outComplex := "110";
			WHEN "111101" => outReal := "111"; outComplex := "111";
			WHEN "111110" => outReal := "001"; outComplex := "101";
			WHEN "111111" => outReal := "001"; outComplex := "100";
		END CASE;
	END lut;
END lookupTable;	
	