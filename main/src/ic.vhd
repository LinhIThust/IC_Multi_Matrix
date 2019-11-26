library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all; 

entity eight_bit_register is 
	port(
	DIN: in std_logic_vector(7 downto 0);
	CLK,RST: in std_logic;
	DOUT: out std_logic_vector(7downto 0)
	);
end entity eight_bit_register;	 

architecture eight_register of eight_bit_register is
begin							
	process(CLK,RST,DIN)
		begin
			if(RST='1')then 
				DOUT<="00000000";
			else
				if(rising_edge(CLK)) then 
					DOUT <= DIN;
				end if;	
			end if;
		end process;
end architecture eight_register;  

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all; 

entity nine_byte_register is 
	port(
	DIN: in std_logic_vector(7 downto 0);
	CLK: in std_logic;
	RST: in std_logic;
	DOUT1: out std_logic_vector(7 downto 0);
	DOUT2: out std_logic_vector(7 downto 0);
	DOUT3: out std_logic_vector(7 downto 0);
	DOUT4: out std_logic_vector(7 downto 0);
	DOUT5: out std_logic_vector(7 downto 0);
	DOUT6: out std_logic_vector(7 downto 0);
	DOUT7: out std_logic_vector(7 downto 0);
	DOUT8: out std_logic_vector(7 downto 0);  
	DOUT9: out std_logic_vector(7 downto 0)
	); 	
end entity nine_byte_register;	


architecture write_byte of nine_byte_register is 
	signal s1:std_logic_vector(7 downto 0);	 
	signal s2:std_logic_vector(7 downto 0);
	signal s3:std_logic_vector(7 downto 0);
	signal s4:std_logic_vector(7 downto 0);
	signal s5:std_logic_vector(7 downto 0);
	signal s6:std_logic_vector(7 downto 0);
	signal s7:std_logic_vector(7 downto 0);	
	signal s8:std_logic_vector(7 downto 0);
	signal s9:std_logic_vector(7 downto 0);
	component eight_bit_register 
		port(
		DIN: in std_logic_vector(7 downto 0);
		CLK,RST: in std_logic;
		DOUT: out std_logic_vector(7downto 0)
		);
	end component eight_bit_register;	
	begin
		U1:eight_bit_register port map(DIN,CLK,RST,s1 );
		U2:eight_bit_register port map(s1,CLK,RST,s2 );
		U3:eight_bit_register port map(s2,CLK,RST,s3 );
		U4:eight_bit_register port map(s3,CLK,RST,s4 );
		U5:eight_bit_register port map(s4,CLK,RST,s5 );
		U6:eight_bit_register port map(s5,CLK,RST,s6 );
		U7:eight_bit_register port map(s6,CLK,RST,s7 );
		U8:eight_bit_register port map(s7,CLK,RST,s8 );
		U9:eight_bit_register port map(s8,CLK,RST,s9 );
		DOUT1<=s1;	 
		DOUT2<=s2;
		DOUT3<=s3;
		DOUT4<=s4;
		DOUT5<=s5;
		DOUT6<=s6;
		DOUT7<=s7;
		DOUT8<=s8;
		DOUT9<=s9;	
end architecture write_byte;