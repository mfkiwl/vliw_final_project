----------------------------------------------------------------------------------
-- Company: 	UMD ECE5752
-- Engineer:	Derrick Wolbert
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    Execution Unit - Behavioral 
-- Project Name:	VLIW Processor	 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: Consists of "decoding", 2 ALUs, 1 RF
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Use IEEE.std_logic_unsigned.all;
Use IEEE.NUMERIC_std.ALL;

entity execute is
	Port( opcode : in std_logic_vector (86 downto 0);
			execute_flag : in std_logic;
			done_flag : out std_logic;
			rf_re_ctrl, rf_wr_ctrl : in std_logic;
			y1, y2, y3, y4, y5, y6 : out std_logic_vector(7 downto 0); ---signals for testing operand  values
			z1, z2, z3 : out std_logic_vector(7 downto 0); ----signals for testing result values
			clk, rst : in std_logic);
end execute;

architecture behave of execute is

		component ALU_8bit is
			Port(	input1, input2	: in std_logic_vector(7 downto 0);
					output			: out std_logic_vector(7 downto 0);
					operation		: in std_logic_vector(3 downto 0));	
		end component;
		
		
		component RF is
			port( Wr_Add_1, Wr_Add_2, Wr_Add_3 											: in std_logic_vector(4 downto 0); 		--write addresses IN to RF
					Re_Add_1, Re_Add_2, Re_Add_3, Re_Add_4, Re_Add_5, Re_Add_6 	: in std_logic_vector(4 downto 0); 		--read addresses IN to RF
					clk, rst 																	: in std_logic; 								--clock, reset
					RF_Wr, RF_Re																: in std_logic; 								--unsure if i want to use this RF_Write signal
					Wr_Dat_1, Wr_Dat_2, Wr_Dat_3											: in std_logic_vector (7 downto 0); 	--write data (8 bits long)
					Re_Dat_1, Re_Dat_2, Re_Dat_3, Re_Dat_4, Re_Dat_5, Re_Dat_6 	: out std_logic_vector(7 downto 0)); 	--read data (8 bits long)
		end component;
		
		component DECODE is
			 port ( opcode : in  STD_LOGIC_VECTOR (86 downto 0);
					  decode_use : in  STD_LOGIC;	
					  --op_type_1 : out STD_LOGIC_VECTOR (5 downto 0);
					  rs_1 : out  STD_LOGIC_VECTOR (4 downto 0);
					  rt_1 : out  STD_LOGIC_VECTOR (4 downto 0);
					  rd_1 : out  STD_LOGIC_VECTOR (4 downto 0);
					  shamt_1 : out  STD_LOGIC_VECTOR (3 downto 0);
					  funct_1 : out  STD_LOGIC_VECTOR (3 downto 0);
					  --op_type_2 : out STD_LOGIC_VECTOR (5 downto 0);
					  rs_2 : out  STD_LOGIC_VECTOR (4 downto 0);
					  rt_2 : out  STD_LOGIC_VECTOR (4 downto 0);
					  rd_2 : out  STD_LOGIC_VECTOR (4 downto 0);
					  shamt_2 : out  STD_LOGIC_VECTOR (3 downto 0);
					  funct_2 : out  STD_LOGIC_VECTOR (3 downto 0);
					    --op_type_3 : out STD_LOGIC_VECTOR (5 downto 0);
					  rs_3 : out  STD_LOGIC_VECTOR (4 downto 0);
					  rt_3 : out  STD_LOGIC_VECTOR (4 downto 0);
					  rd_3 : out  STD_LOGIC_VECTOR (4 downto 0);
					  shamt_3 : out  STD_LOGIC_VECTOR (3 downto 0);
					  funct_3 : out  STD_LOGIC_VECTOR (3 downto 0);
					  
					  clk, rst : std_logic);
		end component;
	
	signal s0 : STD_LOGIC_VECTOR (4 downto 0); --operand 1 address for instruction 1
	signal s1 : STD_LOGIC_VECTOR (4 downto 0); --operand 2 address for instruction 1
	signal s2 : STD_LOGIC_VECTOR (4 downto 0); --result address for instruction 1
	signal s3 : STD_LOGIC_VECTOR (3 downto 0); --shift amount for instruction 1
	signal s4 : STD_LOGIC_VECTOR (3 downto 0); --operation for instruction 1
	
	signal s5 : STD_LOGIC_VECTOR (4 downto 0); --operand 1 address for instruction 2
	signal s6 : STD_LOGIC_VECTOR (4 downto 0); --operand 2 address for instruction 2
	signal s7 : STD_LOGIC_VECTOR (4 downto 0); --result address for instruction 2
	signal s8 : STD_LOGIC_VECTOR (3 downto 0); --shift amount for instruction 2
	signal s9 : STD_LOGIC_VECTOR (3 downto 0); --operation for instruction 2
	
	signal s16 : STD_LOGIC_VECTOR (4 downto 0); --operand 1 address for instruction 3
	signal s17 : STD_LOGIC_VECTOR (4 downto 0); --operand 2 address for instruction 3
	signal s18 : STD_LOGIC_VECTOR (4 downto 0); --result address for instruction 3
	signal s19 : STD_LOGIC_VECTOR (3 downto 0); --shift amount for instruction 3
	signal s20 : STD_LOGIC_VECTOR (3 downto 0); --operation for instruction 3
	
	signal s10: std_logic_vector	(7 downto 0); --alu 1 result
	signal s11: std_logic_vector	(7 downto 0); --alu 2 result
	signal s21: std_logic_vector	(7 downto 0); --alu 3 result
	signal s12: std_logic_vector	(7 downto 0); --alu 1 operand 1
	signal s13: std_logic_vector	(7 downto 0); --alu 1 operand 2
	signal s14: std_logic_vector	(7 downto 0); --alu 2 operand 1
	signal s15: std_logic_vector	(7 downto 0); --alu 2 operand 2
	signal s22: std_logic_vector	(7 downto 0); --alu 3 operand 1
	signal s23: std_logic_vector	(7 downto 0); --alu 3 operand 2
	
	------------------------------------------------------------------------
	------------------------SIGNALS FOR TESTING BEGIN-----------------------
	------------------------------------------------------------------------
	
	--none
	
	
	------------------------------------------------------------------------
	------------------------SIGNALS FOR TESTING END-----------------------
	------------------------------------------------------------------------
	begin
	
		decode_1: DECODE port map(opcode 		=> opcode,
										  decode_use	=> execute_flag,	
										  --op_type_1 : out STD_LOGIC_VECTOR (5 downto 0), --take out for now, dont care about op type
										  rs_1 			=> s0,										--because we're just doing arithmetic operations
										  rt_1 			=> s1,
										  rd_1 			=> s2,
										  shamt_1 		=> s3,
										  funct_1 		=> s4,
										  --op_type_2 : out STD_LOGIC_VECTOR (5 downto 0), --takeout for now
										  rs_2 			=> s5,
										  rt_2 			=> s6,
										  rd_2 			=> s7,
										  shamt_2 		=> s8,
										  funct_2 		=> s9,
										  --op_type_3 : out STD_LOGIC_VECTOR (5 downto 0), --takeout for now
										  rs_3 			=> s16,
										  rt_3 			=> s17,
										  rd_3 			=> s18,
										  shamt_3 		=> s19,
										  funct_3 		=> s20,
										  clk 			=> clk, 
										  rst 			=> rst);
										  
		rf_1: RF port map( 	Wr_Add_1 => s2,
									Wr_Add_2 =>	s7,
									Wr_Add_3 =>	s18,
									Re_Add_1 => s0,
									Re_Add_2 => s1,
									Re_Add_3 => s5, 
									Re_Add_4 => s6,
									Re_Add_5 => s16, 
									Re_Add_6 => s17,
									clk		=> clk,
									rst		=> rst,
									RF_Wr		=>	rf_wr_ctrl, 
									RF_Re		=> rf_re_ctrl,
									Wr_Dat_1 => s10,
									Wr_Dat_2	=> s11,
									Wr_Dat_3	=> s21,
									Re_Dat_1	=> s12, 
									Re_Dat_2	=> s13,
									Re_Dat_3 => s14,
									Re_Dat_4	=> s15,
									Re_Dat_5 => s22,
									Re_Dat_6	=> s23); 	--read data (8 bits long)
		
		alu_1:  ALU_8bit port map(	input1		=>	s12, 
											input2		=>	s13,
											output		=>	s10,
											operation 	=>	s4);

		
		alu_2:  ALU_8bit port map(	input1		=>	s14, 
											input2		=>	s15,
											output		=>	s11,
											operation 	=>	s9);
											
		alu_3:  ALU_8bit port map(	input1		=>	s22, 
											input2		=>	s23,
											output		=>	s21,
											operation 	=>	s20);
											
		y1 <= s12;
		y2 <= s13;
		z1 <= s10;
		
		y3 <= s14;
		y4 <= s15;
		z2 <= s11;
		
		y5 <= s22;
		y6 <= s23;
		z3 <= s21;
											
	end architecture behave;
	




--------------------------------------------------------------------------------
-- Company: 	UMD ECE5752
-- Engineer:	Derrick Wolbert
-- 
-- Create Date:    12:17:48 04/01/2012 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name:	VLIW Processor	 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: ALU used in previous assignment.  Will declare two of these in the overall architecture.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Use IEEE.std_logic_unsigned.all;
Use IEEE.NUMERIC_std.ALL;

entity ALU_8bit is

	Port(	input1, input2	: in std_logic_vector(7 downto 0);
			output			: out std_logic_vector(7 downto 0);
			operation		: in std_logic_vector(3 downto 0));
		
end ALU_8bit;

Architecture ALU_behavior of ALU_8bit is
	Begin
		ALU_proc:process(operation, input1, input2) 
			begin
			
				Case operation is
					when "0000" => --AND 0
						output <= input1 AND input2;
					when "0001" => --OR 1
						output <= input1 OR input2;
					when "0010" => --ADD 2
						output <= input1 + input2;
					when "0011" => --SUBTRACT 3
						output <= input1 - input2;
					when "0100" => --SHIFT INPUT1 LEFT 4
						output <= shl(input1,"1");
					when "0101" => --SHIFT INPUT2 LEFT 5
						output <= shl(input2,"1");
					when "0110" => --SHIFT INPUT1 RIGHT 6
						output <= shr(input1,"1");
					when "0111" => --SHIFT INPUT2 RIGHT 7
						output <= shr(input2,"1");
					when others => output <= "00000000";
				end Case;
			end process;
End ALU_behavior;

----------------------------------------------------------------------------------
-- Company: 	UMD 5752
-- Engineer: 	Derrick Wolbert
-- 
-- Create Date:    19:42:32 03/12/2012 
-- Design Name: 
-- Module Name:    RegisterFile - Behavioral 
-- Project Name:	VLIW	Processor 
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
use ieee.std_logic_unsigned.all;

entity RF is

port( Wr_Add_1, Wr_Add_2, Wr_Add_3 											: in std_logic_vector(4 downto 0); 		--write addresses IN to RF
		Re_Add_1, Re_Add_2, Re_Add_3, Re_Add_4, Re_Add_5, Re_Add_6 	: in std_logic_vector(4 downto 0); 		--read addresses IN to RF
		clk, rst 										: in std_logic; 								--clock, reset
		RF_Wr, RF_Re									: in std_logic; 								--unsure if i want to use this RF_Write signal
		Wr_Dat_1, Wr_Dat_2, Wr_Dat_3				: in std_logic_vector (7 downto 0); 	--write data (8 bits long)
		Re_Dat_1, Re_Dat_2, Re_Dat_3, Re_Dat_4, Re_Dat_5, Re_Dat_6 	: out std_logic_vector(7 downto 0)); 	--read data (8 bits long)
end RF;
	
architecture behave of RF is
	signal 	RF0, RF1, RF2, RF3, RF4, RF5, RF6, RF7 											: std_logic_vector(7 downto 0); --register files RF0-RF31 (total 32)
	signal 	RF8, RF9, RF10, RF11, RF12, RF13, RF14, RF15										: std_logic_vector(7 downto 0);
	signal 	RF16, RF17, RF18, RF19, RF20, RF21, RF22, RF23 									: std_logic_vector(7 downto 0); 
	signal 	RF24, RF25, RF26, RF27, RF28, RF29, RF30, RF31									: std_logic_vector(7 downto 0);
	signal 	Re_Dat_1_s, Re_Dat_2_s, Re_Dat_3_s, Re_Dat_4_s, Re_Dat_5_s, Re_Dat_6_s	: std_logic_vector(7 downto 0);
	
	begin
	
	Re_Dat_1 <= Re_Dat_1_s; --wire register file read signals to outputs
	Re_Dat_2 <= Re_Dat_2_s;
	Re_Dat_3 <= Re_Dat_3_s;
	Re_Dat_4 <= Re_Dat_4_s;
	Re_Dat_5 <= Re_Dat_5_s;
	Re_Dat_6 <= Re_Dat_6_s;
	
	RF_w:process(clk, RF_Wr, rst) 		--write and read process
	
	begin
	
	if(clk'event and clk = '1')then	--positive edge
		if RF_Wr = '1' then			--clock for write
			
			case Wr_Add_1 is											--write address 1 case
			
				when "00000" => RF0 	<= Wr_Dat_1;
				when "00001" => RF1 	<= Wr_Dat_1;
				when "00010" => RF2 	<= Wr_Dat_1;
				when "00011" => RF3 	<= Wr_Dat_1;
				
				when "00100" => RF4 	<= Wr_Dat_1;
				when "00101" => RF5 	<= Wr_Dat_1;
				when "00110" => RF6 	<= Wr_Dat_1;
				when "00111" => RF7 	<= Wr_Dat_1;
				
				when "01000" => RF8 	<= Wr_Dat_1;
				when "01001" => RF9 	<= Wr_Dat_1;
				when "01010" => RF10 <= Wr_Dat_1;
				when "01011" => RF11 <= Wr_Dat_1;
				
				when "01100" => RF12 <= Wr_Dat_1;
				when "01101" => RF13 <= Wr_Dat_1;
				when "01110" => RF14 <= Wr_Dat_1;
				when "01111" => RF15 <= Wr_Dat_1;
				
				when "10000" => RF16 <= Wr_Dat_1;
				when "10001" => RF17 <= Wr_Dat_1;
				when "10010" => RF18 <= Wr_Dat_1;
				when "10011" => RF19 <= Wr_Dat_1;
				
				when "10100" => RF20 <= Wr_Dat_1;
				when "10101" => RF21 <= Wr_Dat_1;
				when "10110" => RF22 <= Wr_Dat_1;
				when "10111" => RF23 <= Wr_Dat_1;
				
				when "11000" => RF24 <= Wr_Dat_1;
				when "11001" => RF25 <= Wr_Dat_1;
				when "11010" => RF26 <= Wr_Dat_1;
				when "11011" => RF27 <= Wr_Dat_1;
				
				when "11100" => RF28 <= Wr_Dat_1;
				when "11101" => RF29 <= Wr_Dat_1;
				when "11110" => RF30 <= Wr_Dat_1;
				when "11111" => RF31 <= Wr_Dat_1;

				when others =>  RF0 	<= x"0f";
			
			end case;
			
			case Wr_Add_2 is													--write address 2 case
			
				when "00000" => RF0 	<= Wr_Dat_2;
				when "00001" => RF1 	<= Wr_Dat_2;
				when "00010" => RF2 	<= Wr_Dat_2;
				when "00011" => RF3 	<= Wr_Dat_2;
				
				when "00100" => RF4 	<= Wr_Dat_2;
				when "00101" => RF5 	<= Wr_Dat_2;
				when "00110" => RF6 	<= Wr_Dat_2;
				when "00111" => RF7 	<= Wr_Dat_2;
				
				when "01000" => RF8 	<= Wr_Dat_2;
				when "01001" => RF9 	<= Wr_Dat_2;
				when "01010" => RF10 <= Wr_Dat_2;
				when "01011" => RF11 <= Wr_Dat_2;
				
				when "01100" => RF12 <= Wr_Dat_2;
				when "01101" => RF13 <= Wr_Dat_2;
				when "01110" => RF14 <= Wr_Dat_2;
				when "01111" => RF15 <= Wr_Dat_2;
				
				when "10000" => RF16 <= Wr_Dat_2;
				when "10001" => RF17 <= Wr_Dat_2;
				when "10010" => RF18 <= Wr_Dat_2;
				when "10011" => RF19 <= Wr_Dat_2;
				
				when "10100" => RF20 <= Wr_Dat_2;
				when "10101" => RF21 <= Wr_Dat_2;
				when "10110" => RF22 <= Wr_Dat_2;
				when "10111" => RF23 <= Wr_Dat_2;
				
				when "11000" => RF24 <= Wr_Dat_2;
				when "11001" => RF25 <= Wr_Dat_2;
				when "11010" => RF26 <= Wr_Dat_2;
				when "11011" => RF27 <= Wr_Dat_2;
				
				when "11100" => RF28 <= Wr_Dat_2;
				when "11101" => RF29 <= Wr_Dat_2;
				when "11110" => RF30 <= Wr_Dat_2;
				when "11111" => RF31 <= Wr_Dat_2;

				when others =>  RF0 	<= x"0f";
			end case;
			
			case Wr_Add_3 is													--write address 2 case
			
				when "00000" => RF0 	<= Wr_Dat_3;
				when "00001" => RF1 	<= Wr_Dat_3;
				when "00010" => RF2 	<= Wr_Dat_3;
				when "00011" => RF3 	<= Wr_Dat_3;
				
				when "00100" => RF4 	<= Wr_Dat_3;
				when "00101" => RF5 	<= Wr_Dat_3;
				when "00110" => RF6 	<= Wr_Dat_3;
				when "00111" => RF7 	<= Wr_Dat_3;
				
				when "01000" => RF8 	<= Wr_Dat_3;
				when "01001" => RF9 	<= Wr_Dat_3;
				when "01010" => RF10 <= Wr_Dat_3;
				when "01011" => RF11 <= Wr_Dat_3;
				
				when "01100" => RF12 <= Wr_Dat_3;
				when "01101" => RF13 <= Wr_Dat_3;
				when "01110" => RF14 <= Wr_Dat_3;
				when "01111" => RF15 <= Wr_Dat_3;
				
				when "10000" => RF16 <= Wr_Dat_3;
				when "10001" => RF17 <= Wr_Dat_3;
				when "10010" => RF18 <= Wr_Dat_3;
				when "10011" => RF19 <= Wr_Dat_3;
				
				when "10100" => RF20 <= Wr_Dat_3;
				when "10101" => RF21 <= Wr_Dat_3;
				when "10110" => RF22 <= Wr_Dat_3;
				when "10111" => RF23 <= Wr_Dat_3;
				
				when "11000" => RF24 <= Wr_Dat_3;
				when "11001" => RF25 <= Wr_Dat_3;
				when "11010" => RF26 <= Wr_Dat_3;
				when "11011" => RF27 <= Wr_Dat_3;
				
				when "11100" => RF28 <= Wr_Dat_3;
				when "11101" => RF29 <= Wr_Dat_3;
				when "11110" => RF30 <= Wr_Dat_3;
				when "11111" => RF31 <= Wr_Dat_3;

				when others =>  RF0 	<= x"0f";
			end case;
			
		end if; --end of write if
		
		if rst = '1' then --initialize/reset register files
			RF0 <= "00000000";
			RF1 <= "00000001";	
			RF2 <= "00000010";
			RF3 <= "00000011";
			RF4 <= "00000100";
			RF5 <= "00000101";
			RF6 <= "00001010";
			RF7 <= "00001011";
			RF8 <= "00001111";
			RF9 <= "00010000";
			RF10 <="00010001";
			RF11 <="00010010";
			RF12 <="00010011";
			RF13 <="00010100";
			RF14 <="00010101";
			RF15 <="00010110";
			RF16 <="00010111";
			RF17 <="00011000";
			RF18 <= x"FF";
			RF19 <= x"FF";
			RF20 <= x"FF";
			RF21 <= x"FF";
			RF22 <= x"FF";
			RF23 <= x"FF";
			RF24 <= x"FF";
			RF25 <= x"FF";
			RF26 <= x"FF";
			RF27 <= x"FF";
			RF28 <= x"FF";
			RF29 <= x"FF";
			RF30 <= x"FF";
			RF31 <= x"FF";
		end if; --end of reset if
		
	end if; --end clock if
	end process RF_w; --end register file read and write on positive edge
	
	RF_r: process(clk, RF_Re, rst)
		begin
		
		if(clk'event and clk = '0')then	--negative edge
		
			if RF_Re = '1' then	--beginning of READ if
				case Re_Add_1 is
				
					when "00000"	=> 	Re_Dat_1_s <= RF0;
					when "00001" 	=> 	Re_Dat_1_s <= RF1;
					when "00010" 	=> 	Re_Dat_1_s <= RF2;
					when "00011" 	=> 	Re_Dat_1_s <= RF3;
					
					when "00100"	=> 	Re_Dat_1_s <= RF4;
					when "00101" 	=> 	Re_Dat_1_s <= RF5;
					when "00110" 	=> 	Re_Dat_1_s <= RF6;
					when "00111" 	=> 	Re_Dat_1_s <= RF7;
					
					when "01000"	=> 	Re_Dat_1_s <= RF8;
					when "01001" 	=> 	Re_Dat_1_s <= RF9;
					when "01010" 	=> 	Re_Dat_1_s <= RF10;
					when "01011" 	=> 	Re_Dat_1_s <= RF11;
					
					when "01100"	=> 	Re_Dat_1_s <= RF12;
					when "01101" 	=> 	Re_Dat_1_s <= RF13;
					when "01110" 	=> 	Re_Dat_1_s <= RF14;
					when "01111" 	=> 	Re_Dat_1_s <= RF15;
					
					when "10000"	=> 	Re_Dat_1_s <= RF16;
					when "10001" 	=> 	Re_Dat_1_s <= RF17;
					when "10010" 	=> 	Re_Dat_1_s <= RF18;
					when "10011" 	=> 	Re_Dat_1_s <= RF19;
					
					when "10100"	=> 	Re_Dat_1_s <= RF20;
					when "10101" 	=> 	Re_Dat_1_s <= RF21;
					when "10110" 	=> 	Re_Dat_1_s <= RF22;
					when "10111" 	=> 	Re_Dat_1_s <= RF23;
					
					when "11000"	=> 	Re_Dat_1_s <= RF24;
					when "11001" 	=> 	Re_Dat_1_s <= RF25;
					when "11010" 	=> 	Re_Dat_1_s <= RF26;
					when "11011" 	=> 	Re_Dat_1_s <= RF27;
					
					when "11100"	=> 	Re_Dat_1_s <= RF28;
					when "11101" 	=> 	Re_Dat_1_s <= RF29;
					when "11110" 	=> 	Re_Dat_1_s <= RF30;
					when "11111" 	=> 	Re_Dat_1_s <= RF31;
					
					when others 	=> 	Re_Dat_1_s <= x"99";
				end case; --end read address 1 case
				
				case Re_Add_2 is
				
					when "00000"	=> 	Re_Dat_2_s <= RF0;
					when "00001" 	=> 	Re_Dat_2_s <= RF1;
					when "00010" 	=> 	Re_Dat_2_s <= RF2;
					when "00011" 	=> 	Re_Dat_2_s <= RF3;
					
					when "00100"	=> 	Re_Dat_2_s <= RF4;
					when "00101" 	=> 	Re_Dat_2_s <= RF5;
					when "00110" 	=> 	Re_Dat_2_s <= RF6;
					when "00111" 	=> 	Re_Dat_2_s <= RF7;
					
					when "01000"	=> 	Re_Dat_2_s <= RF8;
					when "01001" 	=> 	Re_Dat_2_s <= RF9;
					when "01010" 	=> 	Re_Dat_2_s <= RF10;
					when "01011" 	=> 	Re_Dat_2_s <= RF11;
					
					when "01100"	=> 	Re_Dat_2_s <= RF12;
					when "01101" 	=> 	Re_Dat_2_s <= RF13;
					when "01110" 	=> 	Re_Dat_2_s <= RF14;
					when "01111" 	=> 	Re_Dat_2_s <= RF15;
					
					when "10000"	=> 	Re_Dat_2_s <= RF16;
					when "10001" 	=> 	Re_Dat_2_s <= RF17;
					when "10010" 	=> 	Re_Dat_2_s <= RF18;
					when "10011" 	=> 	Re_Dat_2_s <= RF19;
					
					when "10100"	=> 	Re_Dat_2_s <= RF20;
					when "10101" 	=> 	Re_Dat_2_s <= RF21;
					when "10110" 	=> 	Re_Dat_2_s <= RF22;
					when "10111" 	=> 	Re_Dat_2_s <= RF23;
					
					when "11000"	=> 	Re_Dat_2_s <= RF24;
					when "11001" 	=> 	Re_Dat_2_s <= RF25;
					when "11010" 	=> 	Re_Dat_2_s <= RF26;
					when "11011" 	=> 	Re_Dat_2_s <= RF27;
					
					when "11100"	=> 	Re_Dat_2_s <= RF28;
					when "11101" 	=> 	Re_Dat_2_s <= RF29;
					when "11110" 	=> 	Re_Dat_2_s <= RF30;
					when "11111" 	=> 	Re_Dat_2_s <= RF31;
					
					when others 	=> 	Re_Dat_2_s <= x"99";
				end case; --end read address 2 case
				
				case Re_Add_3 is
				
					when "00000"	=> 	Re_Dat_3_s <= RF0;
					when "00001" 	=> 	Re_Dat_3_s <= RF1;
					when "00010" 	=> 	Re_Dat_3_s <= RF2;
					when "00011" 	=> 	Re_Dat_3_s <= RF3;
				
					when "00100"	=> 	Re_Dat_3_s <= RF4;
					when "00101" 	=> 	Re_Dat_3_s <= RF5;
					when "00110" 	=> 	Re_Dat_3_s <= RF6;
					when "00111" 	=> 	Re_Dat_3_s <= RF7;
					
					when "01000"	=> 	Re_Dat_3_s <= RF8;
					when "01001" 	=> 	Re_Dat_3_s <= RF9;
					when "01010" 	=> 	Re_Dat_3_s <= RF10;
					when "01011" 	=> 	Re_Dat_3_s <= RF11;
					
					when "01100"	=> 	Re_Dat_3_s <= RF12;
					when "01101" 	=> 	Re_Dat_3_s <= RF13;
					when "01110" 	=> 	Re_Dat_3_s <= RF14;
					when "01111" 	=> 	Re_Dat_3_s <= RF15;
					
					when "10000"	=> 	Re_Dat_3_s <= RF16;
					when "10001" 	=> 	Re_Dat_3_s <= RF17;
					when "10010" 	=> 	Re_Dat_3_s <= RF18;
					when "10011" 	=> 	Re_Dat_3_s <= RF19;
					
					when "10100"	=> 	Re_Dat_3_s <= RF20;
					when "10101" 	=> 	Re_Dat_3_s <= RF21;
					when "10110" 	=> 	Re_Dat_3_s <= RF22;
					when "10111" 	=> 	Re_Dat_3_s <= RF23;
					
					when "11000"	=> 	Re_Dat_3_s <= RF24;
					when "11001" 	=> 	Re_Dat_3_s <= RF25;
					when "11010" 	=> 	Re_Dat_3_s <= RF26;
					when "11011" 	=> 	Re_Dat_3_s <= RF27;

					when "11100"	=> 	Re_Dat_3_s <= RF28;
					when "11101" 	=> 	Re_Dat_3_s <= RF29;
					when "11110" 	=> 	Re_Dat_3_s <= RF30;
					when "11111" 	=> 	Re_Dat_3_s <= RF31;
					
					when others 	=> 	Re_Dat_3_s <= x"99";
				end case; --end read adress 3 case
				
					case Re_Add_4 is
				
					when "00000"	=> 	Re_Dat_4_s <= RF0;
					when "00001" 	=> 	Re_Dat_4_s <= RF1;
					when "00010" 	=> 	Re_Dat_4_s <= RF2;
					when "00011" 	=> 	Re_Dat_4_s <= RF3;
					
					when "00100"	=> 	Re_Dat_4_s <= RF4;
					when "00101" 	=> 	Re_Dat_4_s <= RF5;
					when "00110" 	=> 	Re_Dat_4_s <= RF6;
					when "00111" 	=> 	Re_Dat_4_s <= RF7;
					
					when "01000"	=> 	Re_Dat_4_s <= RF8;
					when "01001" 	=> 	Re_Dat_4_s <= RF9;
					when "01010" 	=> 	Re_Dat_4_s <= RF10;
					when "01011" 	=> 	Re_Dat_4_s <= RF11;
					
					when "01100"	=> 	Re_Dat_4_s <= RF12;
					when "01101" 	=> 	Re_Dat_4_s <= RF13;
					when "01110" 	=> 	Re_Dat_4_s <= RF14;
					when "01111" 	=> 	Re_Dat_4_s <= RF15;
					
					when "10000"	=> 	Re_Dat_4_s <= RF16;
					when "10001" 	=> 	Re_Dat_4_s <= RF17;
					when "10010" 	=> 	Re_Dat_4_s <= RF18;
					when "10011" 	=> 	Re_Dat_4_s <= RF19;
					
					when "10100"	=> 	Re_Dat_4_s <= RF20;
					when "10101" 	=> 	Re_Dat_4_s <= RF21;
					when "10110" 	=> 	Re_Dat_4_s <= RF22;
					when "10111" 	=> 	Re_Dat_4_s <= RF23;
					
					when "11000"	=> 	Re_Dat_4_s <= RF24;
					when "11001" 	=> 	Re_Dat_4_s <= RF25;
					when "11010" 	=> 	Re_Dat_4_s <= RF26;
					when "11011" 	=> 	Re_Dat_4_s <= RF27;
					
					when "11100"	=> 	Re_Dat_4_s <= RF28;
					when "11101" 	=> 	Re_Dat_4_s <= RF29;
					when "11110" 	=> 	Re_Dat_4_s <= RF30;
					when "11111" 	=> 	Re_Dat_4_s <= RF31;
					
					when others 	=> 	Re_Dat_4_s <= x"99";
				end case; --end read address 4 case
				
				case Re_Add_5 is
				
					when "00000"	=> 	Re_Dat_5_s <= RF0;
					when "00001" 	=> 	Re_Dat_5_s <= RF1;
					when "00010" 	=> 	Re_Dat_5_s <= RF2;
					when "00011" 	=> 	Re_Dat_5_s <= RF3;
				
					when "00100"	=> 	Re_Dat_5_s <= RF4;
					when "00101" 	=> 	Re_Dat_5_s <= RF5;
					when "00110" 	=> 	Re_Dat_5_s <= RF6;
					when "00111" 	=> 	Re_Dat_5_s <= RF7;
					
					when "01000"	=> 	Re_Dat_5_s <= RF8;
					when "01001" 	=> 	Re_Dat_5_s <= RF9;
					when "01010" 	=> 	Re_Dat_5_s <= RF10;
					when "01011" 	=> 	Re_Dat_5_s <= RF11;
					
					when "01100"	=> 	Re_Dat_5_s <= RF12;
					when "01101" 	=> 	Re_Dat_5_s <= RF13;
					when "01110" 	=> 	Re_Dat_5_s <= RF14;
					when "01111" 	=> 	Re_Dat_5_s <= RF15;
					
					when "10000"	=> 	Re_Dat_5_s <= RF16;
					when "10001" 	=> 	Re_Dat_5_s <= RF17;
					when "10010" 	=> 	Re_Dat_5_s <= RF18;
					when "10011" 	=> 	Re_Dat_5_s <= RF19;
					
					when "10100"	=> 	Re_Dat_5_s <= RF20;
					when "10101" 	=> 	Re_Dat_5_s <= RF21;
					when "10110" 	=> 	Re_Dat_5_s <= RF22;
					when "10111" 	=> 	Re_Dat_5_s <= RF23;
					
					when "11000"	=> 	Re_Dat_5_s <= RF24;
					when "11001" 	=> 	Re_Dat_5_s <= RF25;
					when "11010" 	=> 	Re_Dat_5_s <= RF26;
					when "11011" 	=> 	Re_Dat_5_s <= RF27;

					when "11100"	=> 	Re_Dat_5_s <= RF28;
					when "11101" 	=> 	Re_Dat_5_s <= RF29;
					when "11110" 	=> 	Re_Dat_5_s <= RF30;
					when "11111" 	=> 	Re_Dat_5_s <= RF31;
					
					when others 	=> 	Re_Dat_5_s <= x"99";
				end case; --end read adress 5 case
				
					case Re_Add_6 is
				
					when "00000"	=> 	Re_Dat_6_s <= RF0;
					when "00001" 	=> 	Re_Dat_6_s <= RF1;
					when "00010" 	=> 	Re_Dat_6_s <= RF2;
					when "00011" 	=> 	Re_Dat_6_s <= RF3;
					
					when "00100"	=> 	Re_Dat_6_s <= RF4;
					when "00101" 	=> 	Re_Dat_6_s <= RF5;
					when "00110" 	=> 	Re_Dat_6_s <= RF6;
					when "00111" 	=> 	Re_Dat_6_s <= RF7;
					
					when "01000"	=> 	Re_Dat_6_s <= RF8;
					when "01001" 	=> 	Re_Dat_6_s <= RF9;
					when "01010" 	=> 	Re_Dat_6_s <= RF10;
					when "01011" 	=> 	Re_Dat_6_s <= RF11;
					
					when "01100"	=> 	Re_Dat_6_s <= RF12;
					when "01101" 	=> 	Re_Dat_6_s <= RF13;
					when "01110" 	=> 	Re_Dat_6_s <= RF14;
					when "01111" 	=> 	Re_Dat_6_s <= RF15;
					
					when "10000"	=> 	Re_Dat_6_s <= RF16;
					when "10001" 	=> 	Re_Dat_6_s <= RF17;
					when "10010" 	=> 	Re_Dat_6_s <= RF18;
					when "10011" 	=> 	Re_Dat_6_s <= RF19;
					
					when "10100"	=> 	Re_Dat_6_s <= RF20;
					when "10101" 	=> 	Re_Dat_6_s <= RF21;
					when "10110" 	=> 	Re_Dat_6_s <= RF22;
					when "10111" 	=> 	Re_Dat_6_s <= RF23;
					
					when "11000"	=> 	Re_Dat_6_s <= RF24;
					when "11001" 	=> 	Re_Dat_6_s <= RF25;
					when "11010" 	=> 	Re_Dat_6_s <= RF26;
					when "11011" 	=> 	Re_Dat_6_s <= RF27;
					
					when "11100"	=> 	Re_Dat_6_s <= RF28;
					when "11101" 	=> 	Re_Dat_6_s <= RF29;
					when "11110" 	=> 	Re_Dat_6_s <= RF30;
					when "11111" 	=> 	Re_Dat_6_s <= RF31;
					
					when others 	=> 	Re_Dat_6_s <= x"99";
				end case; --end read address 6 case
			
			end if; --end read if
			
		end if; --end clock if
		
	end process	RF_r;--end read process
	
end architecture behave;
				
				

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
    port ( opcode : in  STD_LOGIC_VECTOR (86 downto 0);
           decode_use : in  STD_LOGIC;	
			  --op_type_1 : out STD_LOGIC_VECTOR (5 downto 0);
           rs_1 : out  STD_LOGIC_VECTOR (4 downto 0);
           rt_1 : out  STD_LOGIC_VECTOR (4 downto 0);
           rd_1 : out  STD_LOGIC_VECTOR (4 downto 0);
           shamt_1 : out  STD_LOGIC_VECTOR (3 downto 0);
           funct_1 : out  STD_LOGIC_VECTOR (3 downto 0);
			  --op_type_2 : out STD_LOGIC_VECTOR (5 downto 0);
           rs_2 : out  STD_LOGIC_VECTOR (4 downto 0);
           rt_2 : out  STD_LOGIC_VECTOR (4 downto 0);
           rd_2 : out  STD_LOGIC_VECTOR (4 downto 0);
           shamt_2 : out  STD_LOGIC_VECTOR (3 downto 0);
           funct_2 : out  STD_LOGIC_VECTOR (3 downto 0);
			  --op_type_3 : out STD_LOGIC_VECTOR (5 downto 0);
           rs_3 : out  STD_LOGIC_VECTOR (4 downto 0);
           rt_3 : out  STD_LOGIC_VECTOR (4 downto 0);
           rd_3 : out  STD_LOGIC_VECTOR (4 downto 0);
           shamt_3 : out  STD_LOGIC_VECTOR (3 downto 0);
           funct_3 : out  STD_LOGIC_VECTOR (3 downto 0);
			  clk, rst : std_logic);
end DECODE;

architecture Behavioral of DECODE is
			begin
				process(opcode, decode_use, clk)
					begin
						if (decode_use = '1' and clk'event and clk = '1') then --is it r-type? 
							--op_type_1 	<= opcode	(57 downto 52);
							rs_1 			<= opcode	(51 downto 47);
							rt_1 			<= opcode	(46 downto 42);
							rd_1 			<= opcode	(41 downto 37);
							shamt_1 		<= opcode	(36 downto 33);
							funct_1 		<= opcode	(32 downto 29);
							
							--op_type_2 	<= opcode	(28 downto 23);
							rs_2 			<= opcode	(22 downto 18);
							rt_2 			<= opcode	(17 downto 13);
							rd_2 			<= opcode	(12 downto 8);
							shamt_2 		<= opcode	(7 downto 4);
							funct_2 		<= opcode	(3 downto 0);
							
							--op_type_3 	<= opcode	(86 downto 81);
							rs_3 			<= opcode	(80 downto 76);
							rt_3 			<= opcode	(75 downto 71);
							rd_3 			<= opcode	(70 downto 66);
							shamt_3 		<= opcode	(65 downto 62);
							funct_3 		<= opcode	(61 downto 58);
						end if;
				end process;
end architecture Behavioral;


				
				
				
				
				
				
