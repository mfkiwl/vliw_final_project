--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:41:31 04/16/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT/fsm_tb.vhd
-- Project Name:  VLIW_PROJECT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FSM
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
 
ENTITY fsm_tb IS
END fsm_tb;
 
ARCHITECTURE behavior OF fsm_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FSM
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         nxt_instruc_flag : OUT  std_logic;
         RF_Wr_ctrl : OUT  std_logic;
         RF_Re_ctrl : OUT  std_logic;
         execute_flag : OUT  std_logic;
         done_flag : IN  std_logic;
         current_state : OUT  std_logic_vector(4 downto 0);
         next_state : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal done_flag : std_logic := '0';

 	--Outputs
   signal nxt_instruc_flag : std_logic;
   signal RF_Wr_ctrl : std_logic;
   signal RF_Re_ctrl : std_logic;
   signal execute_flag : std_logic;
   signal current_state : std_logic_vector(4 downto 0);
   signal next_state : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FSM PORT MAP (
          clk => clk,
          rst => rst,
          nxt_instruc_flag => nxt_instruc_flag,
          RF_Wr_ctrl => RF_Wr_ctrl,
          RF_Re_ctrl => RF_Re_ctrl,
          execute_flag => execute_flag,
          done_flag => done_flag,
          current_state => current_state,
          next_state => next_state
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
		rst <= '1';
		
		wait for clk_period*10;
		rst <= '0';
		
      wait;
   end process;

END;
