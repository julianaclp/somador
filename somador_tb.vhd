-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  USE work.common.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT somador
          PORT(
                  uReal: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
						uComplex: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
						uPastReal: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
						uPastComplex: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
						clk: IN STD_LOGIC;
						signedReal,
						signedComplex,
						signedPastReal,
						signedPastComplex,
						absolutePresent, 
						absolutePast: BUFFER SIGNED(size-1 DOWNTO 0);
						lutReal,
						lutComplex, 
						lutPastReal,
						lutPastComplex,
						outRealPresent, 
						outRealPast, 
						outComplexPresent,
						outComplexPast: BUFFER SIGNED(size DOWNTO 0);
			--			componentes da multiplicação complexa
						realPresent1,
						realPresent2,
						realPast1,
						realPast2,
						complexPresent1,
						complexPresent2,
						complexPast1,
						complexPast2: BUFFER SIGNED(size*2 DOWNTO 0);
						xReal, xComplex: OUT SIGNED(size DOWNTO 0)
				);
          END COMPONENT;

          SIGNAL clk :  std_logic := '0';
          SIGNAL clk_period :  time := 20 ns;
          

  BEGIN

  -- Component Instantiation
          uut: somador PORT MAP(
                  clk => clk,
                  uReal => uReal,
						uComplex => uComplex,
						uPastReal => uPastReal,
						uPastComplex => uPastComplex,
						signedReal => signedReal,
						signedComplex, signedComplex,
						signedPastReal => signedPastReal,
						signedPastComplex => signedPastComplex,
						absolutePresent => absolutePresent,
						absolutePast => absolutePast,
						lutReal => lutReal,
						lutComplex => lutComplex,
						lutPastReal => lutPastReal,
						lutPastComplex => lutPastComplex,
						outRealPresent => outRealPresent,
						outComplexPresent => outComplexPresent,
						outRealPast => outRealPast,
						outComplexPast => outComplexPast,
						realPresent1 => realPresent1,
						realPresent2 => realPresent2,
						realPast1 => realPast1,
						realPast2 => realPast2,
						complexPresent1 => complexPresent1,
						complexPresent2 => complexPresent2,
						complexPast1 => complexPast1,
						complexPast2 => complexPast2,
						xReal => xReal,
						xComplex => xComplex
          );


  --  Test Bench Statements
     clk_process: PROCESS
		BEGIN
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';	
			wait for clk_period/2; -- wait until global set/reset completes
		END PROCESS tb;
  --  End Test Bench 

  END;
