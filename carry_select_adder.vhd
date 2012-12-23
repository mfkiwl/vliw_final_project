----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:58:26 04/08/2012 
-- Design Name: 
-- Module Name:    carry_select_adder - Behavioral 
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
Use IEEE.std_logic_unsigned.all;
Use IEEE.NUMERIC_std.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carry_select_adder is
    Port ( op_1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op_2 : in  STD_LOGIC_VECTOR (7 downto 0);
           result : out  STD_LOGIC_VECTOR (7 downto 0));
end carry_select_adder;

architecture Behavioral of carry_select_adder is
	signal a, b, c, d : std_logic_vector(3 downto 0); --temp variables
	signal r_upper, r_lower : std_logic_vector(3 downto 0);--temp result variable
	
	begin
	
		a <= op_1(7 downto 4);
		b <= op_2(7 downto 4);
		
		c <= op_1(3 downto 0);
		d <= op_2(3 downto 0);
		
		process(op_1, op_2)
			begin
				r_lower <= c + d;
			end process;

		process(r_lower)
			begin
				case r_lower(3) is
				when '0' => r_upper <= a + b;
				when '1' => r_upper <= a + b + "0001";
				when others => r_upper <= "1111";
				end case;
			end process;
			
		result <= r_upper & r_lower;
				


end Behavioral;

