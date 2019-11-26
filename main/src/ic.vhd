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