LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;
USE work.functions.all;
USE work.function_calls.all;

ENTITY somador IS 
	PORT(uReal, uComplex, uPastReal, uPastComplex: IN SIGNED (size-1 DOWNTO 0);
			clk: IN STD_LOGIC;
			outReal, outComplex, outPastReal, outPastComplex: OUT SIGNED (size*2-1 DOWNTO 0));
END somador;

ARCHITECTURE somador OF somador IS
BEGIN
	PROCESS(clk)
	variable realTemp, complexTemp, pastRealTemp, pastComplexTemp: SIGNED(size*2-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			squaredInputCall(uReal, uComplex, uPastReal, uPastComplex, realTemp, complexTemp, pastRealTemp, pastComplexTemp);
			inputSumCall(realTemp, complexTemp, pastRealTemp, pastComplexTemp, realTemp, complexTemp);
			outReal <= realTemp;
			outComplex <= complexTemp;
			outPastReal <= pastRealTemp;
			outPastComplex <= pastComplexTemp;
		END IF;
	END PROCESS;
END somador; 
 