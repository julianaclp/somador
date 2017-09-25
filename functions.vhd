LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;

PACKAGE functions IS 
	-- FUNCTIONS --
	FUNCTION sqr(input: SIGNED(size-1 DOWNTO 0))
		RETURN SIGNED;
	FUNCTION inputSum(iReal, iComplex: SIGNED(size*2-1 DOWNTO 0))
		RETURN SIGNED;
END functions;

PACKAGE BODY functions IS 
	FUNCTION sqr(input: SIGNED(size-1 DOWNTO 0)) RETURN SIGNED IS
	variable inputSquared: SIGNED(size*2-1 DOWNTO 0); 
	BEGIN
		inputSquared := input*input;
	RETURN inputSquared;
	END sqr;
	
	FUNCTION inputSum(iReal, iComplex: SIGNED(size*2-1 DOWNTO 0)) RETURN SIGNED IS
	variable sumOutput: SIGNED(size*2-1 DOWNTO 0);
	BEGIN
		sumOutput := iReal + iComplex;
	RETURN sumOutput;
	END inputSum;
END functions;
	