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
			absolutePast,
			lutAReal,
			lutAComplex,
			lutARealPast,
			lutAComplexPast,
			lutBReal,
			lutBComplex,
			lutBRealPast,
			lutBComplexPast,
			lutReal,
			lutComplex, 
			lutPastReal,
			lutPastComplex,
			outRealPresent, 
			outRealPast, 
			outComplexPresent,
			outComplexPast: INOUT SIGNED(size-1 DOWNTO 0);
--			componentes da multiplicação complexa
			realPresent1,
			realPresent2,
			realPast1,
			realPast2,
			complexPresent1,
			complexPresent2,
			complexPast1,
			complexPast2: INOUT SIGNED(size*2-1 DOWNTO 0);
			xReal, xComplex: OUT SIGNED(size-1 DOWNTO 0)
			);
END somador;

ARCHITECTURE somador OF somador IS

--	TYPE memory is array (0 to 5) of SIGNED(size-1 DOWNTO 0);
--	SIGNAL memReal: memory;
--	SIGNAL memComplex: memory;
--	SIGNAL memPastReal: memory;
--	SIGNAL memPastComplex: memory;
	SIGNAL counter: INTEGER range 0 to 5 := 5;
	SIGNAL absoluteReal, 
			 absoluteComplex,
			 absolutePastReal,
			 absolutePastComplex, 
			 lutARealInterpol,
			 lutAComplexInterpol,
			 lutAPastRealInterpol,
			 lutAPastComplexInterpol: SIGNED(size*2-1 DOWNTO 0);
	
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
	
	counter_pr: PROCESS(clk) 
	BEGIN
		IF(clk'EVENT and clk='1') THEN 
			IF(counter < 5) THEN
				counter <= counter + 1;
			ELSE
				counter <= 0;
			END IF;
		END IF;
	END PROCESS counter_pr;
	
--	memory_pr: PROCESS(clk)
--	BEGIN 
--		IF(clk'EVENT and clk='1') THEN
--			memReal(counter) <= signedReal;
--			memComplex(counter) <= signedComplex;
--			memPastReal(counter) <= signedPastReal;
--			memPastComplex(counter) <= signedPastComplex;
--		END IF;
--	END PROCESS memory_pr;
	
	absoluteReal1: PROCESS(clk)
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			absoluteReal <= signedReal*signedReal;
		END IF;
	END PROCESS absoluteReal1;
	
	absoluteComplex1: PROCESS(clk)
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			absoluteComplex <= signedComplex*signedComplex;
		END IF;
	END PROCESS absoluteComplex1;
	
	absolutePastReal1: PROCESS(clk)
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			absolutePastReal <= signedPastReal*signedPastReal;
		END IF;
	END PROCESS absolutePastReal1;
	
	absolutePastComplex2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			absolutePastComplex <= signedPastComplex*signedPastComplex;
		END IF;
	END PROCESS absolutePastComplex2;
	
	absoluteReal2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN 
			absolutePresent <= absoluteReal(size*2-1 DOWNTO size) + absoluteComplex(size*2-1 DOWNTO size);
		END IF;
	END PROCESS absoluteReal2;
	
	absolutePast2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN 
			absolutePast <= absolutePastReal(size*2-1 DOWNTO size) + absolutePastComplex(size*2-1 DOWNTO size);
		END IF;
	END PROCESS absolutePast2;

	lutReal1: PROCESS(clk)
	variable a, b, absolute: SIGNED(size-1 DOWNTO 0);
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := absolutePresent;
			lut(tempSum, '1', a, b, absolute);
			lutAReal <= a;
			lutBReal <= b;
		END IF;
	END PROCESS lutReal1;
	
	lutPast1: PROCESS(clk)
	variable a, b, absolute: SIGNED(size-1 DOWNTO 0);
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := absolutePast;
			lut(tempSum, '1', a, b, absolute);
			lutARealPast <= a;
			lutBRealPast <= b;
		END IF;
	END PROCESS lutPast1;
	
	lutComplexPresent1: PROCESS(clk)
	variable a, b, absolute: SIGNED(size-1 DOWNTO 0);
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := absolutePresent;
			lut(tempSum, '0', a, b, absolute);
			lutAComplex <= a;
			lutBComplex <= b;
		END IF;
	END PROCESS lutComplexPresent1;
	
	lutComplexPast1: PROCESS(clk)
	variable a, b, absolute: SIGNED(size-1 DOWNTO 0);
	variable tempSum: SIGNED(size-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := absolutePast;
			lut(tempSum, '0', a, b, absolute);
			lutAComplexPast <= a;
			lutBComplexPast <= b;
		END IF;
	END PROCESS lutComplexPast1;
	
	lutRealInterpol: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			lutARealInterpol <= lutAReal*absolutePresent;
		END IF;
	END PROCESS lutRealInterpol; 
	
	lutComplexInterpol: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			lutAComplexInterpol <= lutAComplex*absolutePresent;
		END IF;
	END PROCESS lutComplexInterpol;
	
	lutRealPastInterpol: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			lutAPastRealInterpol <= lutARealPast*absolutePast;
		END IF;
	END PROCESS lutRealPastInterpol;
	
	lutComplexPastInterpol: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			lutAPastComplexInterpol <= lutAComplexPast*absolutePast;
		END IF;
	END PROCESS lutComplexPastInterpol;
	
	lutReal2: PROCESS(clk)
	variable tempSum: SIGNED(size*2-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := lutARealInterpol + lutBReal;
			lutReal <= tempSum(size*2-1 DOWNTO size); 
		END IF;
	END PROCESS lutReal2;
	
	lutPast2: PROCESS(clk)
	variable tempSum: SIGNED(size*2-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := lutAComplexInterpol + lutBComplex;
			lutComplex <= tempSum(size*2-1 DOWNTO size); 
		END IF;
	END PROCESS lutPast2;
	
	lutComplexPresent2: PROCESS(clk)
	variable tempSum: SIGNED(size*2-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := lutAPastRealInterpol + lutBRealPast;
			lutPastReal <= tempSum(size*2-1 DOWNTO size); 
		END IF;
	END PROCESS lutComplexPresent2;
	
	lutComplexPast2: PROCESS(clk)
	variable tempSum: SIGNED(size*2-1 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			tempSum := lutAPastComplexInterpol + lutBComplexPast;
			lutPastComplex <= tempSum(size*2-1 DOWNTO size); 
		END IF;
	END PROCESS lutComplexPast2;
	
--	stage4Past: PROCESS(clk)
--	variable realPast, complexPast: SIGNED(size-1 DOWNTO 0);
--	variable tempSumPast: SIGNED(size-1 DOWNTO 0);
--	BEGIN
--		IF(clk'EVENT AND clk='1') THEN
--			tempSumPast := absolutePast;
--			lut(tempSumPast, realPast, complexPast);
--			lutPastReal <= realPast;
--			lutPastComplex <= complexPast;
--		END IF;
--	END PROCESS stage4Past;
	
	stage5RealPresent1: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			realPresent1 <= lutReal*signedReal;
--			realPresent1 <= memReal(0)*memReal(0); 
		END IF;
	END process stage5RealPresent1;
	
	stage5RealPresent2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			realPresent2 <= lutComplex*signedComplex;
		END IF;
	END process stage5RealPresent2;
	
	stage5ComplexPresent1: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			complexPresent1 <= signedComplex*lutReal;
		END IF;
	END process stage5ComplexPresent1;

	stage5ComplexPresent2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			complexPresent2 <= signedReal*lutComplex;
		END IF;
	END process stage5ComplexPresent2;
	
	stage5RealPast1: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			realPast1 <= lutPastReal*signedPastReal;
		END IF;
	END process stage5RealPast1;
	
	stage5RealPast2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			realPast2 <= lutPastComplex*signedPastComplex;
		END IF;
	END process stage5RealPast2;
	
	stage5ComplexPast1: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			complexPast1 <= signedPastComplex*lutPastReal;
		END IF;
	END process stage5ComplexPast1;

	stage5ComplexPast2: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			complexPast2 <= signedPastReal*lutPastComplex;
		END IF;
	END process stage5ComplexPast2;
	
	stage6Real: PROCESS(clk)
	BEGIN	
		IF(clk'EVENT AND clk='1') THEN
			outRealPresent <= realPresent1(size*2-1 DOWNTO size) - realPresent2(size*2-1 DOWNTO size);
		END IF;
	END process stage6Real;
	
	stage6Complex: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			outComplexPresent <=  complexPresent1(size*2-1 DOWNTO size) + complexPresent2(size*2-1 DOWNTO size);
		END IF;
	END process stage6Complex;
	
	stage6RealPast: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			outRealPast <= realPast1(size*2-1 DOWNTO size) - realPast2(size*2-1 DOWNTO size);
		END IF;
	END process stage6RealPast;
	
	stage6ComplexPast: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			outComplexPast <= complexPast1(size*2-1 DOWNTO size) + complexPast2(size*2-1 DOWNTO size);
		END IF;
	END process stage6ComplexPast;
	
	stage7Real: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			xReal <= outRealPast + outRealPresent;
		END IF;
	END PROCESS stage7Real;
	
	stage7Complex: PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			xComplex <= outComplexPast + outComplexPresent;
		END IF;
	END PROCESS stage7Complex;
 END somador; 