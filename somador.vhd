LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;
USE work.functions.all;
USE work.lookuptable.all;

ENTITY somador IS 
	PORT(uReal, uComplex, uPastReal, uPastComplex: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
			clk: IN STD_LOGIC;
--			outComplex, outReal, outPastReal, outPastComplex: OUT STD_LOGIC_VECTOR(size DOWNTO 0) := (OTHERS => 'X');
			sumPresent, 
			sumPast: BUFFER SIGNED(size-1 DOWNTO 0);
			outComplex, 
			outReal,
			outPastReal, 
			outPastComplex: BUFFER SIGNED(size DOWNTO 0)
			);
END somador;

ARCHITECTURE somador OF somador IS
SIGNAL signedReal, signedComplex, signedPastReal, signedPastComplex: SIGNED(size-1 DOWNTO 0);
BEGIN
	stage1: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			signedReal <= signed(uReal);
			signedComplex <= signed(uComplex);
			signedPastReal <= signed(uPastReal);
			signedPastComplex <= signed(uPastComplex); 
		END IF;
	END PROCESS stage1;
	stage2Present: PROCESS(clk)
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := absolute(signedReal, signedComplex);
			sumPresent <= tempSum;
		END IF;
	END PROCESS stage2Present;
	
	stage2Past: PROCESS(clk)
	variable tempSumPast: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSumPast := absolute(signedPastReal, signedPastComplex);
			sumPast <= tempSumPast;
		END IF;
	END PROCESS stage2Past;

	stage3Present: PROCESS(clk)
	variable realPresent, complexPresent: SIGNED(size DOWNTO 0);
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := sumPresent;
			lut(tempSum, realPresent, complexPresent);
			outComplex <= complexPresent;
			outReal <= realPresent;
		END IF;
	END PROCESS stage3Present;
	
	stage3Past: PROCESS(clk)
	variable realPast, complexPast: SIGNED(size DOWNTO 0);
	variable tempSumPast: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSumPast := sumPast;
			lut(tempSumPast, realPast, complexPast);
			outPastReal <= realPast;
			outPastComplex <= complexPast;
		END IF;
	END PROCESS stage3Past;
	
	stage4PresentReal: PROCESS(clk) 
	variable tempReal, tempComplex: SIGNED(size*2 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempReal := outReal*signedReal;
			tempComplex := outComplex*signedComplex;
		END IF;
	END process stage4PresentReal;
	
	stage4PresentComplex: PROCESS(clk) 
	variable tempReal, tempComplex: SIGNED(size*2 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempReal := outReal*signedComplex;
			tempComplex := outComplex*signedReal;
		END IF;
	END process stage4PresentComplex;
	
	stage4PastReal: PROCESS(clk) 
	variable tempPastReal, tempPastComplex: SIGNED(size*2 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempPastReal := outPastReal*signedPastReal;
			tempPastComplex := outPastComplex*signedPastComplex;
		END IF;
	END process stage4PastReal;
	
	stage4PastComplex: PROCESS(clk) 
	variable tempPastReal, tempPastComplex: SIGNED(size*2 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempPastReal := outPastReal*signedPastComplex;
			tempPastComplex := outPastComplex*signedPastReal;
		END IF;
	END process stage4PastComplex;
END somador; 
 