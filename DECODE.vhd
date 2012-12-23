----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:42:02 04/08/2012 
-- Design Name: 
-- Module Name:    DECODE - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECODE is
    port ( opcode : in  STD_LOGIC_VECTOR (57 downto 0);
           decode_use : in  STD_LOGIC;	
			  op_type_1 : out STD_LOGIC_VECTOR (5 downto 0);
           rs_1 : out  STD_LOGIC_VECTOR (4 downto 0);
           rt_1 : out  STD_LOGIC_VECTOR (4 downto 0);
           rd_1 : out  STD_LOGIC_VECTOR (4 downto 0);
           shamt_1 : out  STD_LOGIC_VECTOR (3 downto 0);
           funct_1 : out  STD_LOGIC_VECTOR (3 downto 0);
			  op_type_2 : out STD_LOGIC_VECTOR (5 downto 0);
           rs_2 : out  STD_LOGIC_VECTOR (4 downto 0);
           rt_2 : out  STD_LOGIC_VECTOR (4 downto 0);
           rd_2 : out  STD_LOGIC_VECTOR (4 downto 0);
           shamt_2 : out  STD_LOGIC_VECTOR (3 downto 0);
           funct_2 : out  STD_LOGIC_VECTOR (3 downto 0);
			  clk, rst : std_logic);
end DECODE;

architecture Behavioral of DECODE is
			begin
				process(opcode, decode_use, clk)
					begin
						if (decode_use = '1' and clk'event and clk = '1') then --is it r-type? 
							op_type_1 	<= opcode	(57 downto 52);
							rs_1 			<= opcode	(51 downto 47);
							rt_1 			<= opcode	(46 downto 42);
							rd_1 			<= opcode	(41 downto 37);
							shamt_1 		<= opcode	(36 downto 33);
							funct_1 		<= opcode	(32 downto 29);
							
							op_type_2 	<= opcode	(28 downto 23);
							rs_2 			<= opcode	(22 downto 18);
							rt_2 			<= opcode	(17 downto 13);
							rd_2 			<= opcode	(12 downto 8);
							shamt_2 		<= opcode	(7 downto 4);
							funct_2 		<= opcode	(3 downto 0);
						end if;
				end process;
end architecture Behavioral;

