LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;

PACKAGE lookupTable IS 
	PROCEDURE lut(input: IN SIGNED(size-1 DOWNTO 0); check: IN BIT; outA, outB, outAbs: OUT SIGNED(size-1 DOWNTO 0));
END lookupTable;

PACKAGE BODY lookupTable IS
	PROCEDURE lut(input: IN SIGNED(size-1 DOWNTO 0); check: IN BIT; outA, outB, outAbs: OUT SIGNED(size-1 DOWNTO 0)) IS
	BEGIN
--		CASE input IS
--			WHEN "0000" => outReal := "1001"; outComplex := "0100"; -- real: -13	// complex:  8
--			WHEN "0001" => outReal := "0011"; outComplex := "1101"; -- real:  7	// complex: -5
--			WHEN "0010" => outReal := "1000"; outComplex := "0101"; -- real: -15	// complex:  11
--			WHEN "0011" => outReal := "1011"; outComplex := "0001"; -- real: -10	// complex:  3
--			WHEN "0100" => outReal := "1011"; outComplex := "0101"; -- real: -10	// complex:  10
--			WHEN "0101" => outReal := "1000"; outComplex := "0010"; -- real: -16	// complex:  5
--			WHEN "0110" => outReal := "0111"; outComplex := "0100"; -- real:  15	// complex:  9
--			WHEN "0111" => outReal := "1001"; outComplex := "1111"; -- real: -13	// complex: -2
--			WHEN "1000" => outReal := "0000"; outComplex := "1000"; -- real:  1	// complex: -15
--			WHEN "1001" => outReal := "0000"; outComplex := "1011"; -- real:  0	// complex: -10
--			WHEN "1010" => outReal := "0110"; outComplex := "0111"; -- real:  13	// complex:  7
--			WHEN "1011" => outReal := "0110"; outComplex := "0111"; -- real:  12	// complex:  15
--			WHEN "1100" => outReal := "0001"; outComplex := "1010"; -- real:  2	// complex: -12
--			WHEN "1101" => outReal := "1100"; outComplex := "1001"; -- real: -7	// complex: -13
--			WHEN "1110" => outReal := "1001"; outComplex := "0100"; -- real: -14	// complex: 8
--			WHEN "1111" => outReal := "1100"; outComplex := "1010"; -- real: -8	// complex: -12
--			WHEN OTHERS => outReal := "XXXX"; outComplex := "XXXX"; 
--		END CASE;
		IF(check = '1') THEN 
			CASE input(size-1 DOWNTO size-2) IS
				WHEN "00" => outA := "1000"; outB := "1001"; 
				WHEN "01" => outA := "0010"; outB := "0001"; 
				WHEN "10" => outA := "0100"; outB := "0010";
				WHEN "11" => outA := "0010"; outB := "0100"; 
				WHEN OTHERS => outA := "XXXX"; outA := "XXXX"; 
			END CASE;
		ELSE
			CASE input(size-1 DOWNTO size-2) IS
				WHEN "00" => outA := "0100"; outB := "0001"; 
				WHEN "01" => outA := "1000"; outB := "0100"; 
				WHEN "10" => outA := "0101"; outB := "0111";
				WHEN "11" => outA := "0011"; outB := "0110"; 
				WHEN OTHERS => outA := "XXXX"; outA := "XXXX";
			END CASE;
		END IF;
		outAbs := input; 
	END lut;
END lookupTable;