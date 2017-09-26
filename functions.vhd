LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;

PACKAGE functions IS 
	FUNCTION absolute(iReal, iComplex: SIGNED(size-1 DOWNTO 0)) 
		RETURN SIGNED;
END functions;

PACKAGE BODY functions IS 
	FUNCTION absolute(iReal, iComplex: SIGNED(size-1 DOWNTO 0)) RETURN SIGNED IS
	variable temp: SIGNED(size*2-1 DOWNTO 0);
	variable output: SIGNED(size-1 DOWNTO 0);
	BEGIN
		temp := (iReal*iReal) + (iComplex*iComplex);
		output := temp(size*2-1 DOWNTO size);
	RETURN output;
	END absolute;
END functions;
	