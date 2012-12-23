--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:13 04/01/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT/alu_test.vhd
-- Project Name:  VLIW_PROJECT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU_8bit
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
 
ENTITY alu_test IS
END alu_test;
 
ARCHITECTURE behavior OF alu_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU_8bit
    PORT(
         input1 : IN  std_logic_vector(7 downto 0);
         input2 : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(7 downto 0);
         operation : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input1 : std_logic_vector(7 downto 0) := (others => '0');
   signal input2 : std_logic_vector(7 downto 0) := (others => '0');
   signal operation : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU_8bit PORT MAP (
          input1 => input1,
          input2 => input2,
          output => output,
          operation => operation
        );

   -- Clock process definitions
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
		
		operation <= "0011"; 
		input1 <= "00000011";
		input2 <= "00000010";

--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
