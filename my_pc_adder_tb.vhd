--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:42:53 04/15/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT/my_pc_adder_tb.vhd
-- Project Name:  VLIW_PROJECT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: my_adder
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
 
ENTITY my_pc_adder_tb IS
END my_pc_adder_tb;
 
ARCHITECTURE behavior OF my_pc_adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT my_adder
    PORT(
         d0 : IN  std_logic_vector(4 downto 0);
         d1 : IN  std_logic_vector(4 downto 0);
         e0 : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal d0 : std_logic_vector(4 downto 0) := (others => '0');
   signal d1 : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal e0 : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: my_adder PORT MAP (
          d0 => d0,
          d1 => d1,
          e0 => e0
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
	--	wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for 100 ns;
		d0 <= "00000";
		d1 <= "00001";
		
		wait for 100 ns;
		d0 <= "00001";
		d1 <= "00001";
      wait;
   end process;

END;
