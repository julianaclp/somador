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
			outPresent, outPast: OUT SIGNED (size-1 DOWNTO 0));
END somador;

ARCHITECTURE somador OF somador IS
BEGIN
	PROCESS(clk)
	variable sumPresent, sumPast: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			outPresent <= absolute(uReal, uComplex);
			outPast <= absolute(uPastReal, uPastComplex);
--			lut(sumPresent, realPresent, complexPresent);
--			lut(sumPast, realPast, complexPast);
		END IF;
	END PROCESS;
END somador; 
 