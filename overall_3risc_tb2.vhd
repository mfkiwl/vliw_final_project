--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:19:42 04/22/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT - 3RISC/overall_3risc_tb2.vhd
-- Project Name:  VLIW_PROJECT_3RISC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: overall_arch
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
 
ENTITY overall_3risc_tb2 IS
END overall_3risc_tb2;
 
ARCHITECTURE behavior OF overall_3risc_tb2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT overall_arch
    PORT(
         op_1a : OUT  std_logic_vector(7 downto 0);
         op_1b : OUT  std_logic_vector(7 downto 0);
         res_1 : OUT  std_logic_vector(7 downto 0);
         op_2a : OUT  std_logic_vector(7 downto 0);
         op_2b : OUT  std_logic_vector(7 downto 0);
         res_2 : OUT  std_logic_vector(7 downto 0);
         op_3a : OUT  std_logic_vector(7 downto 0);
         op_3b : OUT  std_logic_vector(7 downto 0);
         res_3 : OUT  std_logic_vector(7 downto 0);
         curr_sta : OUT  std_logic_vector(4 downto 0);
         nxt_sta : OUT  std_logic_vector(4 downto 0);
         opcode : OUT  std_logic_vector(86 downto 0);
         ex_flag : OUT  std_logic;
         n_i_flag : OUT  std_logic;
         rst : IN  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal op_1a : std_logic_vector(7 downto 0);
   signal op_1b : std_logic_vector(7 downto 0);
   signal res_1 : std_logic_vector(7 downto 0);
   signal op_2a : std_logic_vector(7 downto 0);
   signal op_2b : std_logic_vector(7 downto 0);
   signal res_2 : std_logic_vector(7 downto 0);
   signal op_3a : std_logic_vector(7 downto 0);
   signal op_3b : std_logic_vector(7 downto 0);
   signal res_3 : std_logic_vector(7 downto 0);
   signal curr_sta : std_logic_vector(4 downto 0);
   signal nxt_sta : std_logic_vector(4 downto 0);
   signal opcode : std_logic_vector(86 downto 0);
   signal ex_flag : std_logic;
   signal n_i_flag : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: overall_arch PORT MAP (
          op_1a => op_1a,
          op_1b => op_1b,
          res_1 => res_1,
          op_2a => op_2a,
          op_2b => op_2b,
          res_2 => res_2,
          op_3a => op_3a,
          op_3b => op_3b,
          res_3 => res_3,
          curr_sta => curr_sta,
          nxt_sta => nxt_sta,
          opcode => opcode,
          ex_flag => ex_flag,
          n_i_flag => n_i_flag,
          rst => rst,
          clk => clk
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
		rst	<=	'1';
		
		wait for clk_period*5;
		rst	<= '0';
      wait;
   end process;

END;
