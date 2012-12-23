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

port( Wr_Add_1, Wr_Add_2 							: in std_logic_vector(4 downto 0); 		--write addresses IN to RF
		Re_Add_1, Re_Add_2, Re_Add_3, Re_Add_4 : in std_logic_vector(4 downto 0); 		--read addresses IN to RF
		clk, rst 										: in std_logic; 								--clock, reset
		RF_Wr, RF_Re									: in std_logic; 								--unsure if i want to use this RF_Write signal
		Wr_Dat_1, Wr_Dat_2							: in std_logic_vector (7 downto 0); 	--write data (8 bits long)
		Re_Dat_1, Re_Dat_2, Re_Dat_3, Re_Dat_4 : out std_logic_vector(7 downto 0)); 	--read data (8 bits long)
end RF;
	
architecture behave of RF is
	signal 	RF0, RF1, RF2, RF3, RF4, RF5, RF6, RF7 			: std_logic_vector(7 downto 0); --register files RF0-RF31 (total 32)
	signal 	RF8, RF9, RF10, RF11, RF12, RF13, RF14, RF15		: std_logic_vector(7 downto 0);
	signal 	RF16, RF17, RF18, RF19, RF20, RF21, RF22, RF23 	: std_logic_vector(7 downto 0); 
	signal 	RF24, RF25, RF26, RF27, RF28, RF29, RF30, RF31	: std_logic_vector(7 downto 0);
	signal 	Re_Dat_1_s, Re_Dat_2_s, Re_Dat_3_s, Re_Dat_4_s	: std_logic_vector(7 downto 0);
	
	begin
	
	Re_Dat_1 <= Re_Dat_1_s; --wire register file read signals to outputs
	Re_Dat_2 <= Re_Dat_2_s;
	Re_Dat_3 <= Re_Dat_3_s;
	Re_Dat_4 <= Re_Dat_4_s;
	
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
		end if; --end of write if
		
		if rst = '1' then --initialize/reset register files
			RF0 <= x"00000000";
			RF1 <= x"00000001";	
			RF2 <= x"00000010";
			RF3 <= x"00000011";
			RF4 <= x"00000100";
			RF5 <= x"00000101";
			RF6 <= x"FF";
			RF7 <= x"FF";
			RF8 <= x"FF";
			RF9 <= x"FF";
			RF10 <= x"FF";
			RF11 <= x"FF";
			RF12 <= x"FF";
			RF13 <= x"FF";
			RF14 <= x"FF";
			RF15 <= x"FF";
			RF16 <= x"FF";
			RF17 <= x"FF";
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
		
		if(clk'event and clk = '1')then	--positive edge
		
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
			
			end if; --end read if
			
		end if; --end clock if
		
	end process	RF_r;--end read process
	
end architecture behave;
				
				
				
				
				
				
				
				
				