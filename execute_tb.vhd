--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:16:36 04/15/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT/execute_tb.vhd
-- Project Name:  VLIW_PROJECT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: execute
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
 
ENTITY execute_tb IS
END execute_tb;
 
ARCHITECTURE behavior OF execute_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT execute
    PORT(
         opcode : IN  std_logic_vector(57 downto 0);
         execute_flag : IN  std_logic;
         done_flag : OUT  std_logic;
         rf_re_ctrl : IN  std_logic;
         rf_wr_ctrl : IN  std_logic;
         y1 : OUT  std_logic_vector(7 downto 0);
         y2 : OUT  std_logic_vector(7 downto 0);
         y3 : OUT  std_logic_vector(7 downto 0);
         y4 : OUT  std_logic_vector(7 downto 0);
         z1 : OUT  std_logic_vector(7 downto 0);
         z2 : OUT  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal opcode : std_logic_vector(57 downto 0) := (others => '0');
   signal execute_flag : std_logic := '0';
   signal rf_re_ctrl : std_logic := '0';
   signal rf_wr_ctrl : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal done_flag : std_logic;
   signal y1 : std_logic_vector(7 downto 0);
   signal y2 : std_logic_vector(7 downto 0);
   signal y3 : std_logic_vector(7 downto 0);
   signal y4 : std_logic_vector(7 downto 0);
   signal z1 : std_logic_vector(7 downto 0);
   signal z2 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: execute PORT MAP (
          opcode => opcode,
          execute_flag => execute_flag,
          done_flag => done_flag,
          rf_re_ctrl => rf_re_ctrl,
          rf_wr_ctrl => rf_wr_ctrl,
          y1 => y1,
          y2 => y2,
          y3 => y3,
          y4 => y4,
          z1 => z1,
          z2 => z2,
          clk => clk,
          rst => rst
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
		opcode <= "0000000000000001000100000001000000000100000110010100000011";
		rf_re_ctrl <= '1';
		execute_flag <= '1';
		wait for clk_period*10;
		rf_re_ctrl <= '0';
		rf_wr_ctrl <= '1';
		
		wait for clk_period*10;
		rst <= '0';
		opcode <= "0000000001000001000000000001000000000011001010010000000011";
		rf_re_ctrl <= '1';
		rf_wr_ctrl <= '0';
		execute_flag <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
