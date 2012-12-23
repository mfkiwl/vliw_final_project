----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:31:51 04/08/2012 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  cur_instruc, nxt_instruc: out std_logic_vector(4 downto 0);
           instruc_ctrl : in  STD_LOGIC);
end PC;

architecture Behavioral of PC is
	signal cur_instruc_s, nxt_instruc_s : STD_LOGIC_VECTOR(4 downto 0);
	
	begin
	
	process (rst, cur_instruc_s, instruc_ctrl) --right now only I-type opcode
		variable nxt : std_logic_vector(4 downto 0);
		begin
		
			cur_instruc <= cur_instruc_s;
			nxt_instruc <= nxt_instruc_s;
			nxt:=nxt_instruc_s;
			
			if rst = '1' then --reset
				cur_instruc <= "00000";
				nxt_instruc <= "00001";
			end if;
			
			if instruc_ctrl = '1' then
				nxt:=nxt + "00001"; 
				nxt_instruc_s <= nxt;
			end if;

	end process;
	
	process(clk, nxt_instruc_s)
		begin
			if (clk'event and clk = '0') then
				cur_instruc_s <= nxt_instruc_s;
			end if;
	end process;
	
end;