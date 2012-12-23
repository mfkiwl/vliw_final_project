--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:24:21 04/15/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT/fetch_tb.vhd
-- Project Name:  VLIW_PROJECT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fetch
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY fetch_tb IS
END fetch_tb;
 
ARCHITECTURE behavior OF fetch_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fetch
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         nxt_instruc_flag : IN  std_logic;
         instruc : OUT  std_logic_vector(57 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal nxt_instruc_flag : std_logic := '0';

 	--Outputs
   signal instruc : std_logic_vector(57 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fetch PORT MAP (
          clk => clk,
          rst => rst,
          nxt_instruc_flag => nxt_instruc_flag,
          instruc => instruc
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
		rst <='1';
	
		wait for clk_period*10;
		rst <='0';
		nxt_instruc_flag <= '1';
		
		wait for clk_period;
		nxt_instruc_flag <= '0';
		
		wait for clk_period*5;
		nxt_instruc_flag <= '1';
		
		wait for clk_period;
		nxt_instruc_flag <= '0';
		
		wait for clk_period*5;
		rst <= '1';
		nxt_instruc_flag <= '1';
		
		wait for clk_period;
		rst <= '0';
		nxt_instruc_flag <= '0';
		
		
		
		

      -- insert stimulus here 

      wait;
   end process;

END;
