--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:57:11 04/14/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT/carry_select_tb.vhd
-- Project Name:  VLIW_PROJECT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: carry_select_adder
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
 
ENTITY carry_select_tb IS
END carry_select_tb;
 
ARCHITECTURE behavior OF carry_select_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT carry_select_adder
    PORT(
         op_1 : IN  std_logic_vector(7 downto 0);
         op_2 : IN  std_logic_vector(7 downto 0);
         result : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal op_2 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: carry_select_adder PORT MAP (
          op_1 => op_1,
          op_2 => op_2,
          result => result
        );
--
--   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for 100 ns;
		op_1 <= "00000001";
		op_2 <= "00000010";
		
		wait for 100 ns;
		op_1 <= "00000011";
		op_2 <= "00000110";

      -- insert stimulus here 

      wait;
   end process;

END;
