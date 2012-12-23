----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:47:18 04/01/2012 
-- Design Name: 
-- Module Name:    FSM - Behavioral 
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

entity FSM is
    Port ( clk 												: in  STD_LOGIC;
           rst 												: in  STD_LOGIC;
           nxt_instruc_flag								: out	std_logic;
			  RF_Wr_ctrl, RF_Re_ctrl						: out STD_LOGIC;
			  execute_flag										: out std_logic;
			  done_flag											: in std_logic;
			  current_state, next_state					: out std_logic_vector(4 downto 0));
end FSM;

architecture Behavioral of FSM is

	signal current_state_s, next_state_s: std_logic_vector (4 downto 0); --state signals

	begin
		
		current_state <= current_state_s;
		next_state <= next_state_s;
		
	process (rst, current_state_s) 
		begin
			if rst = '1' then --reset
				nxt_instruc_flag <= '0';
				execute_flag <= '0';
				RF_Re_ctrl <= '0';
				RF_Wr_ctrl <= '0';
				next_state_s <= "00000";
			end if;
			
			if rst = '0' then
				if current_state_s = "00000" then
					nxt_instruc_flag <= '1'; --fetch
					next_state_s <= "00001";
				elsif current_state_s = "00001" then
					nxt_instruc_flag <= '0'; --fetch end
					next_state_s <= "00010";	
				elsif current_state_s = "00010" then --execute (read)
					execute_flag <= '1';
					next_state_s <= "00011";
				elsif current_state_s = "00011" then --execute (read)
					execute_flag <= '1';
					RF_Re_ctrl <= '1';
					next_state_s <= "00100";	
				elsif current_state_s = "00100" then --extra read cycle(read)
					execute_flag <= '1';
					RF_Re_ctrl <= '1';
					next_state_s <= "00101";	
				elsif current_state_s = "00101" then
					execute_flag <= '1';
					RF_Re_ctrl <= '0';	--execute (write back)
					RF_Wr_ctrl <= '1';
					next_state_s <= "00111";
				elsif current_state_s = "00111" then
					execute_flag <= '0';
					RF_Re_ctrl <= '0';	--turn off signals
					RF_Wr_ctrl <= '0';
					next_state_s <= "01000";	
				elsif current_state_s = "01000" then
					next_state_s <= "00000";	--wait again
				end if; --end of state machine
			end if;
		--
			
	end process; --end process
	
	process(clk, next_state_s)
		begin
			if (clk'event and clk = '0') then
				current_state_s <= next_state_s;
			end if;
	end process;
	


end Behavioral;

		