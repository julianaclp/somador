LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;

PACKAGE lookupTable IS 
	PROCEDURE lut(input: IN SIGNED(size-1 DOWNTO 0); outReal, outComplex: OUT SIGNED(size-1 DOWNTO 0));
END lookupTable;

PACKAGE BODY lookupTable IS
	PROCEDURE lut(input: IN SIGNED(size-1 DOWNTO 0); outReal, outComplex: OUT SIGNED(size DOWNTO 0)) IS
	BEGIN
		CASE input IS
			WHEN "0000" => outReal := "10011"; outComplex := "01000"; -- real: -13	// complex:  8
			WHEN "0001" => outReal := "00111"; outComplex := "11011"; -- real:  7	// complex: -5
			WHEN "0010" => outReal := "10001"; outComplex := "01011"; -- real: -15	// complex:  11
			WHEN "0011" => outReal := "10110"; outComplex := "00011"; -- real: -10	// complex:  3
			WHEN "0100" => outReal := "10110"; outComplex := "01010"; -- real: -10	// complex:  10
			WHEN "0101" => outReal := "10000"; outComplex := "00101"; -- real: -16	// complex:  5
			WHEN "0110" => outReal := "01111"; outComplex := "01001"; -- real:  15	// complex:  9
			WHEN "0111" => outReal := "10011"; outComplex := "11110"; -- real: -13	// complex: -2
			WHEN "1000" => outReal := "00001"; outComplex := "10001"; -- real:  1	// complex: -15
			WHEN "1001" => outReal := "00000"; outComplex := "10110"; -- real:  0	// complex: -10
			WHEN "1010" => outReal := "01101"; outComplex := "01110"; -- real:  13	// complex:  7
			WHEN "1011" => outReal := "01100"; outComplex := "01111"; -- real:  12	// complex:  15
			WHEN "1100" => outReal := "00010"; outComplex := "10100"; -- real:  2	// complex: -12
			WHEN "1101" => outReal := "11001"; outComplex := "10011"; -- real: -7	// complex: -13
			WHEN "1110" => outReal := "10010"; outComplex := "01000"; -- real: -14	// complex: 8
			WHEN "1111" => outReal := "11000"; outComplex := "10100"; -- real: -8	// complex: -12
			WHEN OTHERS => outReal := "XXXXX"; outComplex := "XXXXX"; 
		END CASE;
	END lut;
END lookupTable;	
	