-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL; 
  USE ieee.numeric_std.ALL;
  USE ieee.std_logic_unsigned.ALL;
  USE work.common.ALL;

  ENTITY somador_tb IS
  END somador_tb;

  ARCHITECTURE behavior OF somador_tb IS 

  -- Component Declaration
          COMPONENT somador
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
          END COMPONENT;

          SIGNAL clk :  std_logic := '0';
			 SIGNAL uReal: STD_LOGIC_VECTOR(size-1 DOWNTO 0) := "1000"; 
			 SIGNAL uComplex: STD_LOGIC_VECTOR(size-1 DOWNTO 0):= "0111"; 
			 SIGNAL uPastReal: STD_LOGIC_VECTOR(size-1 DOWNTO 0) := "1111"; 
			 SIGNAL uPastComplex: STD_LOGIC_VECTOR(size-1 DOWNTO 0) := "0111";
			 
			 SIGNAL signedReal: SIGNED(size-1 DOWNTO 0);
			 SIGNAL signedComplex: SIGNED(size-1 DOWNTO 0);
			 SIGNAL signedPastReal: SIGNED(size-1 DOWNTO 0);
			 SIGNAL signedPastComplex: SIGNED(size-1 DOWNTO 0);
			 SIGNAL absolutePresent: SIGNED(size-1 DOWNTO 0);
			 SIGNAL absolutePast: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutAReal: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutAComplex: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutARealPast: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutAComplexPast: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutBReal: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutBComplex: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutBRealPast: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutBComplexPast: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutReal: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutComplex: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutPastReal: SIGNED(size-1 DOWNTO 0);
			 SIGNAL lutPastComplex: SIGNED(size-1 DOWNTO 0);
			 SIGNAL outRealPresent: SIGNED(size-1 DOWNTO 0);
			 SIGNAL outRealPast: SIGNED(size-1 DOWNTO 0);
			 SIGNAL outComplexPresent: SIGNED(size-1 DOWNTO 0);
			 SIGNAL outComplexPast: SIGNED(size-1 DOWNTO 0);
			 SIGNAL realPresent1: SIGNED(size*2-1 DOWNTO 0);
			 SIGNAL realPresent2: SIGNED(size*2-1 DOWNTO 0);
			 SIGNAL realPast1: SIGNED(size*2-1 DOWNTO 0);
			 SIGNAL realPast2: SIGNED(size*2-1 DOWNTO 0);
			 SIGNAL complexPresent1: SIGNED(size*2-1 DOWNTO 0);
			 SIGNAL complexPresent2: SIGNED(size*2-1 DOWNTO 0);
			 SIGNAL complexPast1: SIGNED(size*2-1 DOWNTO 0);
			 SIGNAL complexPast2: SIGNED(size*2-1 DOWNTO 0);
			 SIGNAL xReal: SIGNED(size-1 DOWNTO 0);
			 SIGNAL xComplex: SIGNED(size-1 DOWNTO 0);
			 
          CONSTANT clk_period :  time := 20 ns;
          

  BEGIN

  -- Component Instantiation
          uut: somador PORT MAP(
                  clk => clk,
                  uReal => uReal,
						uComplex => uComplex,
						uPastReal => uPastReal,
						uPastComplex => uPastComplex,
						signedReal => signedReal,
						signedComplex => signedComplex,
						signedPastReal => signedPastReal,
						signedPastComplex => signedPastComplex,
						absolutePresent => absolutePresent,
						absolutePast => absolutePast,
						lutAReal => lutAReal,
						lutAComplex => lutAComplex,
						lutARealPast => lutARealPast,
						lutAComplexPast => lutAComplexPast,
						lutBReal => lutBReal,
						lutBComplex => lutBComplex,
						lutBRealPast => lutBRealPast,
						lutBComplexPast => lutBComplexPast,
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
		VARIABLE count : integer := 0;
		BEGIN
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			count := count + 1;			
--			IF (count >= 2) THEN 
--				uReal <= uReal + "0001";
--				uComplex <= uComplex + "0001";
--				uPastReal <= uPastReal + "0001";
--				uPastComplex <= uPastComplex + "0001";
--			END IF;
			wait for clk_period/2; -- wait until global set/reset completes
		END PROCESS clk_process;
  --  End Test Bench 

  END;
