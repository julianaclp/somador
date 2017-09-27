LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;
USE work.functions.all;
USE work.lookuptable.all;

ENTITY somador IS 
	PORT(uReal, uComplex, uPastReal, uPastComplex: IN SIGNED (size-1 DOWNTO 0);
			clk: IN STD_LOGIC;
			outComplex, outReal: OUT SIGNED (size DOWNTO 0) := (OTHERS => 'X'));
END somador;

ARCHITECTURE somador OF somador IS
	SIGNAL sumPresent, sumPast: SIGNED(size-1 DOWNTO 0);
BEGIN
	absoluteProcess: PROCESS(clk)
	variable tempSum, tempSumPast: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := absolute(uReal, uComplex);
			tempSumPast := absolute(uPastReal, uPastComplex);
			sumPresent <= tempSum;
			sumPast <= tempSumPast;
		END IF;
	END PROCESS absoluteProcess;

	lutProcess: PROCESS(clk)
	variable realPresent, complexPresent: SIGNED(size DOWNTO 0);
	variable tempSum, tempSumPast: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := sumPresent;
			tempSumPast := sumPast;
			lut(tempSum, realPresent, complexPresent);
	--		lut(tempSumPast, realPast, complexPast);
			outComplex <= complexPresent;
			outReal <= realPresent;
		END IF;
	END PROCESS lutProcess;
END somador; 
 