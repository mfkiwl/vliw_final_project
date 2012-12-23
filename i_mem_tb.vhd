--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:58:00 04/14/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT/i_mem_tb.vhd
-- Project Name:  VLIW_PROJECT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: I_mem
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
 
ENTITY i_mem_tb IS
END i_mem_tb;
 
ARCHITECTURE behavior OF i_mem_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT I_mem
    PORT(
         I_Add_1 : IN  std_logic_vector(4 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         I_Re : IN  std_logic;
         I_Dat_1 : OUT  std_logic_vector(57 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal I_Add_1 : std_logic_vector(4 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal I_Re : std_logic := '0';

 	--Outputs
   signal I_Dat_1 : std_logic_vector(57 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: I_mem PORT MAP (
          I_Add_1 => I_Add_1,
          clk => clk,
          rst => rst,
          I_Re => I_Re,
          I_Dat_1 => I_Dat_1
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
		I_Add_1 <= "00000";
		I_Re <= '1';
		
		wait for clk_period*10;
		I_Add_1 <= "00001";
		I_Re <= '0';
		
		wait for clk_period*10;
		I_Add_1 <= "00010";
		I_Re <= '1';
		

      -- insert stimulus here 

      wait;
   end process;

END;
