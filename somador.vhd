LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;
USE work.functions.all;
USE work.function_calls.all;
USE work.lookuptable.all;

ENTITY somador IS 
	PORT(uReal, uComplex, uPastReal, uPastComplex: IN SIGNED (size-1 DOWNTO 0);
			clk: IN STD_LOGIC;
			outReal, outComplex, outPastReal, outPastComplex: OUT SIGNED (size*2-1 DOWNTO 0));
END somador;

ARCHITECTURE somador OF somador IS
BEGIN
	PROCESS(clk)
	variable realTemp, complexTemp, pastRealTemp, pastComplexTemp, sumPresent, sumPast: SIGNED(size*2-1 DOWNTO 0);
	variable realPresent, complexPresent, realPast, complexPast: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			realTemp := sqr(uReal);
			complexTemp := sqr(uComplex);
			pastRealTemp := sqr(uPastReal);
			pastComplexTemp := sqr(uPastComplex);
			sumPresent := inputSum(realTemp, complexTemp);
			sumPast := inputSum(pastRealTemp, pastComplexTemp);
			lut(sumPresent, realPresent, complexPresent);
			lut(sumPast, realPast, complexPast);
		END IF;
	END PROCESS;
END somador; 
 