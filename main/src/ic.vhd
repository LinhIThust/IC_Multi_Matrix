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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;


entity demux2to1 is
    Port(DataIn: in std_logic_vector(7 downto 0);
		EnW: in std_logic;
		SelAB: in std_logic;
        OutA,OutB: out std_logic_vector(7 downto 0);
		EnOut: out std_logic
		  );
end entity demux2to1;

architecture demux2to1 of demux2to1 is
begin
	process (DataIn,SelAB,EnW)
	begin
		EnOut <= EnW;
		if EnW= '1' then 
			if SelAB = '1' then
					OutA <= DataIn;
			else
					OutB <= DataIn;
			end if;
		end if;
	end process;
end architecture demux2to1;	  


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all; 

entity multi_matrix is
	Port(
	A11: in std_logic_vector(7 downto 0);
	A12: in std_logic_vector(7 downto 0);
	A13: in std_logic_vector(7 downto 0);
	
	A21: in std_logic_vector(7 downto 0);
	A22: in std_logic_vector(7 downto 0);
	A23: in std_logic_vector(7 downto 0);
	
	A31: in std_logic_vector(7 downto 0);
	A32: in std_logic_vector(7 downto 0);
	A33: in std_logic_vector(7 downto 0);
----------------------------------------------	
	B11: in std_logic_vector(7 downto 0);
	B12: in std_logic_vector(7 downto 0);
	B13: in std_logic_vector(7 downto 0);
	
	B21: in std_logic_vector(7 downto 0);
	B22: in std_logic_vector(7 downto 0);
	B23: in std_logic_vector(7 downto 0);
	
	B31: in std_logic_vector(7 downto 0);
	B32: in std_logic_vector(7 downto 0);
	B33: in std_logic_vector(7 downto 0); 
-----------------------------------------------	
	Result11: out std_logic_vector(7 downto 0);
	Result12: out std_logic_vector(7 downto 0);
	Result13: out std_logic_vector(7 downto 0);
	Result21: out std_logic_vector(7 downto 0);
	Result22: out std_logic_vector(7 downto 0);
	Result23: out std_logic_vector(7 downto 0);
	Result31: out std_logic_vector(7 downto 0);
	Result32: out std_logic_vector(7 downto 0);
	Result33: out std_logic_vector(7 downto 0)
	);
end entity multi_matrix;

architecture multi of multi_matrix is
signal temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9 : std_logic_vector(15 downto 0);
begin
	temp1 <= (A11*B11+A12*B21+A13*B31);
	Result11 <= temp1(7 downto 0);
	temp2 <= (A11*B12+A12*B22+A13*B32);
	Result12 <= temp2(7 downto 0);
	temp3 <= (A11*B13+A12*B23+A13*B33);
	Result13 <= temp3(7 downto 0);
	temp4 <= (A21*B11+A22*B21+A23*B31);
	Result21 <= temp4(7 downto 0);
	temp5 <= (A21*B12+A22*B22+A23*B32);
	Result22 <= temp5(7 downto 0);
	temp6 <= (A21*B13+A22*B23+A23*B33);
	Result23 <= temp6(7 downto 0);
	temp7 <= (A31*B11+A32*B21+A33*B31);
	Result31 <= temp7(7 downto 0);
	temp8 <= (A31*B12+A32*B23+A33*B32);
	Result32 <= temp8(7 downto 0);
	temp9 <= (A31*B33+A32*B23+A33*B33);
	Result33 <= temp9(7 downto 0);
end architecture multi;



