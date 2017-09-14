LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.common.all;
USE work.functions.all;


ENTITY somador IS 
	PORT(uReal, uComplex, uPastReal, uPastComplex: IN SIGNED (size-1 DOWNTO 0);
			clk: IN STD_LOGIC;
			outReal, outComplex, outPastReal, outPastComplex: OUT SIGNED (size*2-1 DOWNTO 0));
END somador;


ARCHITECTURE somador OF somador IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN
			outReal <= sqr(uReal);
			outComplex <= sqr(uComplex);
			outPastComplex <= sqr(uPastComplex);
			outPastReal <= sqr(uPastReal);
		END IF;
	END PROCESS;
END somador; 
 