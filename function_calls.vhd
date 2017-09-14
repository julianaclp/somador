LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;
USE work.functions.all;

PACKAGE function_calls IS 
	PROCEDURE squaredInputCall(iReal, iComplex, iPastReal, iPastComplex: IN SIGNED(size-1 DOWNTO 0);
		outReal, outComplex, outPastReal, outPastComplex: OUT SIGNED(size*2-1 DOWNTO 0));
	PROCEDURE inputSumCall(iReal, iComplex, iPastReal, iPastComplex: IN SIGNED(size*2-1 DOWNTO 0);
		outPresent, outPast: OUT SIGNED(size*2-1 DOWNTO 0));
END function_calls;

PACKAGE BODY function_calls IS
	PROCEDURE squaredInputCall(iReal, iComplex, iPastReal, iPastComplex: IN SIGNED(size-1 DOWNTO 0);
		SIGNAL outReal, outComplex, outPastReal, outPastComplex: OUT SIGNED(size*2-1 DOWNTO 0)) IS
		BEGIN
			outReal <= sqr(iReal);
			outComplex <= sqr(iComplex);
			outPastReal <= sqr(iPastReal);
			outPastComplex <= sqr(iPastComplex);
	END squaredInputCall;
	
	PROCEDURE inputSumCall(iReal, iComplex, iPastReal, iPastComplex: IN SIGNED(size*2-1 DOWNTO 0);
		SIGNAL outPresent, outPast: OUT SIGNED(size*2-1 DOWNTO 0)) IS
		BEGIN 
			outPresent <= inputSum(iReal, iComplex);
			outPast <= inputSum(iPastReal, iPastComplex);
		END inputSumCall;
END function_calls;