--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:46:22 04/14/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT/decode_tb.vhd
-- Project Name:  VLIW_PROJECT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECODE
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
 
ENTITY decode_tb IS
END decode_tb;
 
ARCHITECTURE behavior OF decode_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECODE
    PORT(
         opcode : IN  std_logic_vector(57 downto 0);
         decode_use : IN  std_logic;
         op_type_1 : OUT  std_logic_vector(5 downto 0);
         rs_1 : OUT  std_logic_vector(4 downto 0);
         rt_1 : OUT  std_logic_vector(4 downto 0);
         rd_1 : OUT  std_logic_vector(4 downto 0);
         shamt_1 : OUT  std_logic_vector(3 downto 0);
         funct_1 : OUT  std_logic_vector(3 downto 0);
         op_type_2 : OUT  std_logic_vector(5 downto 0);
         rs_2 : OUT  std_logic_vector(4 downto 0);
         rt_2 : OUT  std_logic_vector(4 downto 0);
         rd_2 : OUT  std_logic_vector(4 downto 0);
         shamt_2 : OUT  std_logic_vector(3 downto 0);
         funct_2 : OUT  std_logic_vector(3 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal opcode : std_logic_vector(57 downto 0) := (others => '0');
   signal decode_use : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal op_type_1 : std_logic_vector(5 downto 0);
   signal rs_1 : std_logic_vector(4 downto 0);
   signal rt_1 : std_logic_vector(4 downto 0);
   signal rd_1 : std_logic_vector(4 downto 0);
   signal shamt_1 : std_logic_vector(3 downto 0);
   signal funct_1 : std_logic_vector(3 downto 0);
   signal op_type_2 : std_logic_vector(5 downto 0);
   signal rs_2 : std_logic_vector(4 downto 0);
   signal rt_2 : std_logic_vector(4 downto 0);
   signal rd_2 : std_logic_vector(4 downto 0);
   signal shamt_2 : std_logic_vector(3 downto 0);
   signal funct_2 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECODE PORT MAP (
          opcode => opcode,
          decode_use => decode_use,
          op_type_1 => op_type_1,
          rs_1 => rs_1,
          rt_1 => rt_1,
          rd_1 => rd_1,
          shamt_1 => shamt_1,
          funct_1 => funct_1,
          op_type_2 => op_type_2,
          rs_2 => rs_2,
          rt_2 => rt_2,
          rd_2 => rd_2,
          shamt_2 => shamt_2,
          funct_2 => funct_2,
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
		decode_use <= '1';
		opcode <="0000000000000001000100000001000000000100000110010100000011";
		
		wait for clk_period*10;
		decode_use <='0';
		opcode <="0000000000000000000000000000000000000001111111111111111100";
		
		wait for clk_period*10;
		decode_use <='1';
		opcode <="0000010110001000000000011111110000000000011000000000111100";
		

      -- insert stimulus here 

      wait;
   end process;

END;
