----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:38:26 04/16/2012 
-- Design Name: 
-- Module Name:    overall_arch - Behavioral 
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

entity overall_arch is
		Port(	op_1a		:	out	std_logic_vector(7 downto 0);
				op_1b		:	out	std_logic_vector(7 downto 0);
				res_1		:	out	std_logic_vector(7 downto 0);
		
				op_2a		:	out	std_logic_vector(7 downto 0);
				op_2b		:	out	std_logic_vector(7 downto 0);
				res_2		:	out	std_logic_vector(7 downto 0);
				
				op_3a		:	out	std_logic_vector(7 downto 0);
				op_3b		:	out	std_logic_vector(7 downto 0);
				res_3		:	out	std_logic_vector(7 downto 0);
		
				curr_sta	:	out	std_logic_vector(4 downto 0);
				nxt_sta	:	out	std_logic_vector(4 downto 0);
				
				opcode	:	out	std_logic_vector(86 downto 0);
				ex_flag	:	out	std_logic;
				n_i_flag	:	out	std_logic;
				
				rst, clk	:	in		std_logic);

end overall_arch;

architecture Behavioral of overall_arch is

		component FSM is
			 Port ( clk 												: in  STD_LOGIC;
					  rst 												: in  STD_LOGIC;
					  nxt_instruc_flag								: out	std_logic;
					  RF_Wr_ctrl, RF_Re_ctrl						: out STD_LOGIC;
					  execute_flag										: out std_logic;
					  done_flag											: in std_logic;
					  current_state, next_state					: out std_logic_vector(4 downto 0));
		end component;
		
		
		component execute is
			Port( opcode 							: in std_logic_vector (86 downto 0);
					execute_flag 					: in std_logic;
					done_flag 						: out std_logic;
					rf_re_ctrl, rf_wr_ctrl 		: in std_logic;
					y1, y2, y3, y4, y5, y6 		: out std_logic_vector(7 downto 0); ---signals for testing operand values
					z1, z2, z3 						: out std_logic_vector(7 downto 0); ----signals for testing result values
					clk, rst 						: in std_logic);
			end component;
			
			
		component fetch is
			port( clk, rst 										: in std_logic; 								--clock, reset
					nxt_instruc_flag								: in std_logic; 								--want to read memory
					instruc											: out std_logic_vector(86 downto 0)); 	--instructions are 87 bit
		end component;
		
		signal s0	:	std_logic; --flag to tell execute to work nxt_instruc_flag => s0 => execute_flag
		signal s1	:	std_logic_vector (86 downto 0); --instruction code
		signal s2	: 	std_logic; --done flag, not used
		signal s3	: 	std_logic; --register read flag
		signal s4	: 	std_logic; --register write flag
		signal s5, s6, s7, s8, s14, s15	:	std_logic_vector(7 downto 0); --operand outputs from execute (y1-y4, y5-y6)
		signal s9, s10, s16					:	std_logic_vector(7 downto 0); --result outputs from execute	(z1-z2, z3)
		signal s11								:	std_logic; --execute flag
		signal s12, s13						: 	std_logic_vector(4 downto 0); --current state, next state, respectively. output from overall arch.
		
		
	begin
		fetch_1: fetch port map(	clk					=>	clk, 
											rst					=>	rst,
											nxt_instruc_flag	=>	s0,
											instruc				=>	s1);
		
		execute_1: execute port map(	opcode 			=> s1,
												execute_flag	=>	s11,
												done_flag 		=>	s2, 
												rf_re_ctrl		=>	s3, 
												rf_wr_ctrl		=>	s4,
												y1					=>	s5, 
												y2 				=>	s6,
												y3					=> s7, 
												y4 				=> s8,
												y5					=>	s14,
												y6					=> s15,
												z1					=> s9, 
												z2 				=> s10,
												z3					=> s16,
												clk				=> clk, 
												rst				=> rst);

		fsm_1: FSM port map(	clk					=>	clk, 												
									rst 					=> rst,											
									nxt_instruc_flag	=>	s0,							
									RF_Wr_ctrl			=>	s4, 
									RF_Re_ctrl			=>	s3,						
									execute_flag		=>	s11,										
									done_flag			=>	s2,											
									current_state		=>	s12, 
									next_state			=>	s13);
		
		op_1a	<=	s5;
		op_1b	<=	s6;
		res_1	<=	s9;
		
		op_2a	<=	s7;
		op_2b	<=	s8;
		res_2	<=	s10;
		
		op_3a	<=	s14;
		op_3b	<=	s15;
		res_3	<=	s16;
		
		curr_sta	<=	s12;
		nxt_sta	<=	s13;
		
		opcode	<=	s1;
		ex_flag	<=	s11;
		n_i_flag	<=	s0;
		
end Behavioral;

