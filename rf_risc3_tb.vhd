--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:15:51 04/25/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/13.3/ISE_DS/examplework/VLIW_PROJECT - 3RISC/rf_risc3_tb.vhd
-- Project Name:  VLIW_PROJECT_3RISC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
 
ENTITY rf_risc3_tb IS
END rf_risc3_tb;
 
ARCHITECTURE behavior OF rf_risc3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Wr_Add_1 : IN  std_logic_vector(4 downto 0);
         Wr_Add_2 : IN  std_logic_vector(4 downto 0);
         Wr_Add_3 : IN  std_logic_vector(4 downto 0);
         Re_Add_1 : IN  std_logic_vector(4 downto 0);
         Re_Add_2 : IN  std_logic_vector(4 downto 0);
         Re_Add_3 : IN  std_logic_vector(4 downto 0);
         Re_Add_4 : IN  std_logic_vector(4 downto 0);
         Re_Add_5 : IN  std_logic_vector(4 downto 0);
         Re_Add_6 : IN  std_logic_vector(4 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         RF_Wr : IN  std_logic;
         RF_Re : IN  std_logic;
         Wr_Dat_1 : IN  std_logic_vector(7 downto 0);
         Wr_Dat_2 : IN  std_logic_vector(7 downto 0);
         Wr_Dat_3 : IN  std_logic_vector(7 downto 0);
         Re_Dat_1 : OUT  std_logic_vector(7 downto 0);
         Re_Dat_2 : OUT  std_logic_vector(7 downto 0);
         Re_Dat_3 : OUT  std_logic_vector(7 downto 0);
         Re_Dat_4 : OUT  std_logic_vector(7 downto 0);
         Re_Dat_5 : OUT  std_logic_vector(7 downto 0);
         Re_Dat_6 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Wr_Add_1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Wr_Add_2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Wr_Add_3 : std_logic_vector(4 downto 0) := (others => '0');
   signal Re_Add_1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Re_Add_2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Re_Add_3 : std_logic_vector(4 downto 0) := (others => '0');
   signal Re_Add_4 : std_logic_vector(4 downto 0) := (others => '0');
   signal Re_Add_5 : std_logic_vector(4 downto 0) := (others => '0');
   signal Re_Add_6 : std_logic_vector(4 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal RF_Wr : std_logic := '0';
   signal RF_Re : std_logic := '0';
   signal Wr_Dat_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal Wr_Dat_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal Wr_Dat_3 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Re_Dat_1 : std_logic_vector(7 downto 0);
   signal Re_Dat_2 : std_logic_vector(7 downto 0);
   signal Re_Dat_3 : std_logic_vector(7 downto 0);
   signal Re_Dat_4 : std_logic_vector(7 downto 0);
   signal Re_Dat_5 : std_logic_vector(7 downto 0);
   signal Re_Dat_6 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Wr_Add_1 => Wr_Add_1,
          Wr_Add_2 => Wr_Add_2,
          Wr_Add_3 => Wr_Add_3,
          Re_Add_1 => Re_Add_1,
          Re_Add_2 => Re_Add_2,
          Re_Add_3 => Re_Add_3,
          Re_Add_4 => Re_Add_4,
          Re_Add_5 => Re_Add_5,
          Re_Add_6 => Re_Add_6,
          clk => clk,
          rst => rst,
          RF_Wr => RF_Wr,
          RF_Re => RF_Re,
          Wr_Dat_1 => Wr_Dat_1,
          Wr_Dat_2 => Wr_Dat_2,
          Wr_Dat_3 => Wr_Dat_3,
          Re_Dat_1 => Re_Dat_1,
          Re_Dat_2 => Re_Dat_2,
          Re_Dat_3 => Re_Dat_3,
          Re_Dat_4 => Re_Dat_4,
          Re_Dat_5 => Re_Dat_5,
          Re_Dat_6 => Re_Dat_6
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
        -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		rst <= '1';
		RF_Re <= '1';
		RF_Wr <= '1';

      wait for clk_period*3;
		
		rst <= '0';
		RF_Re <= '0';
		
		Wr_Add_1 <= "00000";
		Wr_Dat_1 <= "00000001";
		
		Wr_Add_2 <= "00001";
		Wr_Dat_2 <= "00000010";
		
		Wr_Add_3 <= "00010";
		Wr_Dat_3 <= "00000011";
		
		wait for clk_period*3;
		
		Wr_Add_1 <= "00011";
		Wr_Dat_1 <= "00000100";
		
		Wr_Add_2 <= "00100";
		Wr_Dat_2 <= "00000101";
		
		Wr_Add_3 <= "00101";
		Wr_Dat_3 <= "00000111";
		
		wait for clk_period*3;
		
		RF_Wr <= '0';
		RF_Re <= '1';
		
		Re_Add_1 <= "00000";
		Re_Add_2 <= "00001";
		Re_Add_3 <= "00010";
		Re_Add_4 <= "00011";
		Re_Add_5 <= "00100";
		Re_Add_6 <= "00101";
		
		wait for clk_period*3;
		
--		RF_Re <= '1';
--		RF_Wr <= '1';
--		
--		Wr_Add_1 <= "00000";
--		Wr_Dat_1 <= "00000101";
--		
--		Re_Add_1 <= "00011";
--		Re_Add_2 <= "00010";

		wait for clk_period*3;
		
		RF_Re <= '0';
		RF_Wr <= '0';

      wait;
   end process;

END;
