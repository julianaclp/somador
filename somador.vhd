LIBRARY ieee; 
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;
USE work.functions.all;
USE work.lookuptable.all; 

ENTITY somador IS 
	PORT(
			clk: IN STD_LOGIC;
			uReal: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0); 
			uComplex: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0); 
			uPastReal: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0); 
			uPastComplex: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
			signedReal,
			signedComplex,
			signedPastReal,
			signedPastComplex,
			absolutePresent, 
			absolutePast: INOUT SIGNED(size-1 DOWNTO 0);
			lutReal,
			lutComplex, 
			lutPastReal,
			lutPastComplex,
			outRealPresent, 
			outRealPast, 
			outComplexPresent,
			outComplexPast: INOUT SIGNED(size DOWNTO 0);
--			componentes da multiplicação complexa
			realPresent1,
			realPresent2,
			realPast1,
			realPast2,
			complexPresent1,
			complexPresent2,
			complexPast1,
			complexPast2: INOUT SIGNED(size*2 DOWNTO 0);
			xReal, xComplex: OUT SIGNED(size DOWNTO 0)
			);
END somador;

ARCHITECTURE somador OF somador IS
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
			absolutePresent <= tempSum;
		END IF;
	END PROCESS stage2Present;
	
	stage2Past: PROCESS(clk)
	variable tempSumPast: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSumPast := absolute(signedPastReal, signedPastComplex);
			absolutePast <= tempSumPast;
		END IF;
	END PROCESS stage2Past;

	stage3Present: PROCESS(clk)
	variable realPresent, complexPresent: SIGNED(size DOWNTO 0);
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := absolutePresent;
			lut(tempSum, realPresent, complexPresent);
			lutComplex <= complexPresent;
			lutReal <= realPresent;
		END IF;
	END PROCESS stage3Present;
	
	stage3Past: PROCESS(clk)
	variable realPast, complexPast: SIGNED(size DOWNTO 0);
	variable tempSumPast: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSumPast := absolutePast;
			lut(tempSumPast, realPast, complexPast);
			lutPastReal <= realPast;
			lutPastComplex <= complexPast;
		END IF;
	END PROCESS stage3Past;
	
	stage4RealPresent1: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			realPresent1 <= lutReal*signedReal;
		END IF;
	END process stage4RealPresent1;
	
	stage4RealPresent2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			realPresent2 <= lutComplex*signedComplex;
		END IF;
	END process stage4RealPresent2;
	
	stage4ComplexPresent1: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			complexPresent1 <= signedComplex*lutReal;
		END IF;
	END process stage4ComplexPresent1;

	stage4ComplexPresent2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			complexPresent2 <= signedReal*lutComplex;
		END IF;
	END process stage4ComplexPresent2;
	
	stage4RealPast1: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			realPast1 <= lutPastReal*signedPastReal;
		END IF;
	END process stage4RealPast1;
	
	stage4RealPast2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			realPast2 <= lutPastComplex*signedPastComplex;
		END IF;
	END process stage4RealPast2;
	
	stage4ComplexPast1: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			complexPast1 <= signedPastComplex*lutPastReal;
		END IF;
	END process stage4ComplexPast1;

	stage4ComplexPast2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			complexPast2 <= signedPastReal*lutPastComplex;
		END IF;
	END process stage4ComplexPast2;
	
	stage5Real: PROCESS(clk)
	BEGIN	
		IF(clk'EVENT AND clk='1') THEN
			outRealPresent <= realPresent1(size*2 DOWNTO size) - realPresent2(size*2 DOWNTO size);
		END IF;
	END process stage5Real;
	
	stage5Complex: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			outComplexPresent <=  complexPresent1(size*2 DOWNTO size) + complexPresent2(size*2 DOWNTO size);
		END IF;
	END process stage5Complex;
	
	stage5RealPast: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			outRealPast <= realPast1(size*2 DOWNTO size) - realPast2(size*2 DOWNTO size);
		END IF;
	END process stage5RealPast;
	
	stage5ComplexPast: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			outComplexPast <= complexPast1(size*2 DOWNTO size) + complexPast2(size*2 DOWNTO size);
		END IF;
	END process stage5ComplexPast;
	
	stage6Real: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			xReal <= outRealPast + outRealPresent;
		END IF;
	END PROCESS stage6Real;
	
	stage6Complex: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			xComplex <= outComplexPast + outComplexPresent;
		END IF;
	END PROCESS stage6Complex;
 END somador; 