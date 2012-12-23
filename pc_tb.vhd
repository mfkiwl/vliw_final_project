--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:38:06 04/15/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT/pc_tb.vhd
-- Project Name:  VLIW_PROJECT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PC
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
 
ENTITY pc_tb IS
END pc_tb;
 
ARCHITECTURE behavior OF pc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         cur_instruc : OUT  std_logic_vector(4 downto 0);
         nxt_instruc : IN  std_logic_vector(4 downto 0);
         instruc_ctrl : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal nxt_instruc : std_logic_vector(4 downto 0) := (others => '0');
   signal instruc_ctrl : std_logic := '0';

 	--Outputs
   signal cur_instruc : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC PORT MAP (
          clk => clk,
          rst => rst,
          cur_instruc => cur_instruc,
          nxt_instruc => nxt_instruc,
          instruc_ctrl => instruc_ctrl
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
		instruc_ctrl <= '1';
		nxt_instruc <= "00000";
		
		wait for clk_period*10;
		rst <='0';
		instruc_ctrl <= '0';
		nxt_instruc <= "00001";
		
		wait for clk_period*10;
		rst <='0';
		instruc_ctrl <= '1';
		nxt_instruc <= "00001";
		
      wait;
   end process;

END;
