----------------------------------------------------------------------------------
-- Company: 	UMD 5752
-- Engineer: 	Derrick Wolbert
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    Fetch
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

entity fetch is

port( clk, rst 										: in std_logic; 								--clock, reset
		nxt_instruc_flag								: in std_logic; 								--want to read memory
		instruc											: out std_logic_vector(86 downto 0)); 	--instructions are 87 bit
end fetch;

architecture behave of fetch is
	
	component my_adder is
		port (d0, d1	:in std_logic_vector(4 downto 0); 
				e0			:out std_logic_vector(4 downto 0));
	end component;
	
	component I_mem is
		port( I_Add_1			: in std_logic_vector(4 downto 0); 		--read addresses IN to Program (Instruction) Memory
				clk, rst 		: in std_logic; 								--clock, reset
				I_Re				: in std_logic; 								--want to read memory
				I_Dat_1			: out std_logic_vector(86 downto 0)); 	--instructions are 87 bit
	end component; 
	
	component PC is
		 Port(clk 				: in  STD_LOGIC;
				rst 				: in  STD_LOGIC;
				cur_instruc		: out std_logic_vector(4 downto 0);
				nxt_instruc		: in std_logic_vector(4 downto 0);
				instruc_ctrl	: in std_logic);
	end component;
	
	signal s0 : std_logic_vector(4 downto 0); --signal from out of adder to into PC for next instruction address
	signal s1 : std_logic_vector(4 downto 0);	--signal from out of PC to into I_mem for next instruction opcode and to adder to produce next address
	signal s2 : std_logic_vector(4 downto 0);
	
	begin
		s2 <= "00001";
		pc1: PC port map(	clk 				=> clk, 
								rst				=>	rst, 
								cur_instruc		=> s0, 
								nxt_instruc		=>	s1, 
								instruc_ctrl	=>	nxt_instruc_flag);
		
		add1: my_adder port map(d0	=> s0,
										d1 =>	s2,
										e0 =>	s1);
										
										
		i_mem1: I_mem port map(	I_Add_1 	=>	s0, 
										clk		=>	clk,
										rst		=> rst,  
										I_Re		=>	nxt_instruc_flag,
										I_Dat_1	=>	instruc);
		
end architecture behave;


	





----------------------------------------------------------------------------------
-- Company: 	UMD 5752
-- Engineer: 	Derrick Wolbert
-- 
-- Create Date:    19:42:32 03/12/2012 
-- Design Name: 
-- Module Name:    Program (instruction) Memory - Behavioral 
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

entity I_mem is

port( I_Add_1											: in std_logic_vector(4 downto 0); 		--read addresses IN to Program (Instruction) Memory
		clk, rst 										: in std_logic; 								--clock, reset
		I_Re												: in std_logic; 								--want to read memory
		I_Dat_1											: out std_logic_vector(86 downto 0)); 	--instructions are 56 bit
end I_mem;
	
architecture behave of I_mem is
	signal 	I0, I1, I2, I3, I4, I5, I6, I7 				: std_logic_vector(86 downto 0); --register files RF0-RF31 (total 32)
	signal 	I8, I9, I10, I11, I12, I13, I14, I15		: std_logic_vector(86 downto 0);
	signal 	I16, I17, I18, I19, I20, I21, I22, I23 	: std_logic_vector(86 downto 0); 
	signal 	I24, I25, I26, I27, I28, I29, I30, I31		: std_logic_vector(86 downto 0);
	signal 	I_Dat_1_s											: std_logic_vector(86 downto 0);
	
	begin
	
	I_Dat_1 <= I_Dat_1_s; --wire register file read signal to output

	I_r: process(clk, I_Re, rst) --instruction read process
		begin
		
		if rst = '1' then --initialize/reset instruction memory
			I0 <= "000000011001000010001000001000000000000000001000100000001000000000100000110010100000011";
			I1 <= "000000011011000010010000001010000000001000001000000000001000000000011001010010000000011";
			I2 <= "000000100010111010000000001100000000011000111010100000000000000001000010010101100000001";
			I3 <= "000000100100111110100000001110000000101000111001100000000000000001011010010100000000001";
			I4 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000001111";
			I5 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000011111";
			I6 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000111111";
			I7 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000001111111";
			I8 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000011111111";
			I9 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000111111111";
			I10 <= "000000000000000000000000000000000000000000000000000000000000000000000000000001111111111";
			I11 <= "000000000000000000000000000000000000000000000000000000000000000000000000000011111111111";
			I12 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I13 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I14 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I15 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I16 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I17 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I18 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I19 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I20 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I21 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I22 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I23 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I24 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I25 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I26 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I27 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I28 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I29 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I30 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			I31 <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
		end if; --end of reset if
		

		
		if(clk'event and clk = '1')then	--positive edge
		
			if I_Re = '1' then	--beginning of READ if
				case I_Add_1 is
				
					when "00000"	=> 	I_Dat_1_s <= I0;
					when "00001" 	=> 	I_Dat_1_s <= I1;
					when "00010" 	=> 	I_Dat_1_s <= I2;
					when "00011" 	=> 	I_Dat_1_s <= I3;
					
					when "00100"	=> 	I_Dat_1_s <= I4;
					when "00101" 	=> 	I_Dat_1_s <= I5;
					when "00110" 	=> 	I_Dat_1_s <= I6;
					when "00111" 	=> 	I_Dat_1_s <= I7;
					
					when "01000"	=> 	I_Dat_1_s <= I8;
					when "01001" 	=> 	I_Dat_1_s <= I9;
					when "01010" 	=> 	I_Dat_1_s <= I10;
					when "01011" 	=> 	I_Dat_1_s <= I11;
					
					when "01100"	=> 	I_Dat_1_s <= I12;
					when "01101" 	=> 	I_Dat_1_s <= I13;
					when "01110" 	=> 	I_Dat_1_s <= I14;
					when "01111" 	=> 	I_Dat_1_s <= I15;
					
					when "10000"	=> 	I_Dat_1_s <= I16;
					when "10001" 	=> 	I_Dat_1_s <= I17;
					when "10010" 	=> 	I_Dat_1_s <= I18;
					when "10011" 	=> 	I_Dat_1_s <= I19;
					
					when "10100"	=> 	I_Dat_1_s <= I20;
					when "10101" 	=> 	I_Dat_1_s <= I21;
					when "10110" 	=> 	I_Dat_1_s <= I22;
					when "10111" 	=> 	I_Dat_1_s <= I23;
					
					when "11000"	=> 	I_Dat_1_s <= I24;
					when "11001" 	=> 	I_Dat_1_s <= I25;
					when "11010" 	=> 	I_Dat_1_s <= I26;
					when "11011" 	=> 	I_Dat_1_s <= I27;
					
					when "11100"	=> 	I_Dat_1_s <= I28;
					when "11101" 	=> 	I_Dat_1_s <= I29;
					when "11110" 	=> 	I_Dat_1_s <= I30;
					when "11111" 	=> 	I_Dat_1_s <= I31;
					
					when others 	=> 	I_Dat_1_s <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
				end case; --end read address 1 case
				
			end if; --end read if
			
		end if; --end clock if
		
	end process	I_r;--end read process
	
end architecture behave;
				
				
				
				
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
    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				cur_instruc: out std_logic_vector(4 downto 0);
				nxt_instruc: in std_logic_vector(4 downto 0);
				instruc_ctrl: in std_logic);
end PC;

architecture Behavioral of PC is
	begin
		process(clk, instruc_ctrl, nxt_instruc, rst)
			begin
				if (rst = '1') then
					cur_instruc <= "00000";
				elsif (clk'event and clk = '1' and instruc_ctrl = '1') then
					cur_instruc <= nxt_instruc;
				end if;
		end process;
end;				
				
----------------------------------------------------------------------------------
-- Company: UMD
-- Engineer: Derrick Wolbert
-- 
-- Create Date:     
-- Design Name: 	my_adder	
-- Module Name:    
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


Library IEEE;
use IEEE.std_logic_1164.ALL;
Use IEEE.std_logic_unsigned.all;
Use IEEE.NUMERIC_std.ALL;

entity my_adder is
	port (d0, d1	:in std_logic_vector(4 downto 0); 
			e0			:out std_logic_vector(4 downto 0));
end my_adder;

architecture behave of my_adder is
BEGIN
	e0 <= d0 + d1;
end behave;			
				
				