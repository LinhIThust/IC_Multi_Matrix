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
 ---------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;


entity mux is
    Port(
		CLK: std_logic;
		DataIn,MatrixIn1,MatrixIn2: in std_logic_vector(7 downto 0);
		SelF:in std_logic_vector(1 downto 0);
        outB: out std_logic_vector(7 downto 0)
		);
end entity mux;

architecture chooseIn of mux is
begin
	process (SelF,CLk)
	begin
		if rising_edge(CLK) then
			if SelF = "01" then
				outB <= MatrixIn1;
			elsif SelF ="10" then
				outB <= MatrixIn2;
			elsif SelF ="00" then
				outB <= DataIn;
			end if;
		end if;
	end process;
end architecture chooseIn;

-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all; 

entity nine_byte_register is 
	port(
	DIN: in std_logic_vector(7 downto 0);
	CLK: in std_logic;
	RST: in std_logic;
	SelF:in std_logic_vector(1 downto 0);
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
	signal DIN1,DIN2,DIN3,DIN4,DIN5,DIN6,DIN7,DIN8,DIN9: std_logic_vector(7 downto 0);
	type matrixB is array(8 downto 0) of std_logic_vector(7 downto 0);
	signal matrixb1: matrixB;
	signal matrixb2:matrixB;
	component eight_bit_register 
		port(
		DIN: in std_logic_vector(7 downto 0);
		CLK,RST: in std_logic;
		DOUT: out std_logic_vector(7downto 0)
		);
	end component eight_bit_register;
	component mux
	    Port(
			clk:std_logic;
			DataIn,MatrixIn1,MatrixIn2: in std_logic_vector(7 downto 0);
			SelF:in std_logic_vector(1 downto 0);
	        outB: out std_logic_vector(7 downto 0)
			);
	end component mux;
	
	begin
		matrixb1(0) <="00001101";matrixb1(1) <="00001111";matrixb1(2) <="00001111";matrixb1(3) <="00001111";
		matrixb1(4) <="00001111";matrixb1(5) <="00001101";matrixb1(6) <="00001111";matrixb1(7) <="00001111";
		matrixb1(8) <="00001111";
		matrixb2(0) <="10101101";matrixb2(1) <="00001111";matrixb2(2) <="00101111";matrixb2(3) <="00001101";
		matrixb2(4) <="10101111";matrixb2(5) <="00001101";matrixb2(6) <="00011111";matrixb2(7) <="00000001";
		matrixb2(8) <="10101111";
		
		M1:mux port map(CLK,DIN,matrixb1(0),matrixb2(0),SelF,DIN1);
		M2:mux port map(CLK,DIN1,matrixb1(1),matrixb2(1),SelF,DIN2);
		M3:mux port map(CLK,DIN2,matrixb1(2),matrixb2(2),SelF,DIN3);
		M4:mux port map(CLK,DIN3,matrixb1(3),matrixb2(3),SelF,DIN4);
		M5:mux port map(CLK,DIN4,matrixb1(4),matrixb2(4),SelF,DIN5);
		M6:mux port map(CLK,DIN5,matrixb1(5),matrixb2(5),SelF,DIN6);
		M7:mux port map(CLK,DIN6,matrixb1(6),matrixb2(6),SelF,DIN7);
		M8:mux port map(CLK,DIN7,matrixb1(7),matrixb2(7),SelF,DIN8);
		M9:mux port map(CLK,DIN8,matrixb1(8),matrixb2(8),SelF,DIN9); 
		U1:eight_bit_register port map(DIN1,CLK,RST,dOUT1 );
		U2:eight_bit_register port map(DIN2,CLK,RST,DOUT2 );
		U3:eight_bit_register port map(DIN3,CLK,RST,DOUT3 );
		U4:eight_bit_register port map(DIN4,CLK,RST,DOUT4 );
		U5:eight_bit_register port map(DIN5,CLK,RST,DOUT5 );
		U6:eight_bit_register port map(DIN6,CLK,RST,DOUT6 );
		U7:eight_bit_register port map(DIN7,CLK,RST,DOUT7 );
		U8:eight_bit_register port map(DIN8,CLK,RST,DOUT8 );
		U9:eight_bit_register port map(DIN9,CLK,RST,DOUT9 );
		
end architecture write_byte;  
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;


entity demux2to1 is
    Port(DataIn: in std_logic_vector(7 downto 0);
		EnW: in std_logic;
		SelAB: in std_logic;
        OutA,OutB: out std_logic_vector(7 downto 0)
		);
end entity demux2to1;

architecture demux2to1 of demux2to1 is
begin
	process (DataIn,SelAB,EnW)
	begin
		if EnW= '1' then 
			if SelAB = '1' then
					OutA <= DataIn;
			else
					OutB <= DataIn;
			end if;
		end if;
	end process;
end architecture demux2to1;	

---------------------------------------------------------------------------------
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


----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity ic_main is
	Port(
	DataIn : in std_logic_vector(7 downto 0);
	SelRegister: in std_logic;
	Reset: in std_logic;
	Clock:in std_logic;
	SelF: in std_logic_vector(1 downto 0);
	
	Out11: out std_logic_vector(7 downto 0);  
	Out12: out std_logic_vector(7 downto 0);
	Out13: out std_logic_vector(7 downto 0);
	Out21: out std_logic_vector(7 downto 0);
	Out22: out std_logic_vector(7 downto 0);
	Out23: out std_logic_vector(7 downto 0);
	Out31: out std_logic_vector(7 downto 0);
	Out32: out std_logic_vector(7 downto 0);
	Out33: out std_logic_vector(7 downto 0)
	);
end entity ic_main;

architecture ic of ic_main is

component demux2to1
    Port(DataIn: in std_logic_vector(7 downto 0);
		EnW: in std_logic;
		SelAB: in std_logic;
        OutA,OutB: out std_logic_vector(7 downto 0)
		);
end component demux2to1;

component multi_matrix 
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
end component multi_matrix;

component nine_byte_register 
	port(
	DIN: in std_logic_vector(7 downto 0);
	CLK: in std_logic;
	RST: in std_logic;
	SelF:in std_logic_vector(1 downto 0);
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
end component nine_byte_register;

signal toA,a11,a12,a13,a21,a22,a23,a31,a32,a33: std_logic_vector(7 downto 0);
signal toB,b11,b12,b13,b21,b22,b23,b31,b32,b33: std_logic_vector(7 downto 0);
signal out1,out2,out3,out4,out5,out6,out7,out8,out9:std_logic_vector(7 downto 0);


begin
	A:nine_byte_register port map(toA,Clock,Reset,SelF,a11,a12,a13,a21,a22,a23,a31,a32,a33);
	B:nine_byte_register port map(toB,Clock,Reset,SelF,b11,b12,b13,b21,b22,b23,b31,b32,b33);
	Multi:multi_matrix port map(a11,a12,a13,a21,a22,a23,a31,a32,a33,b11,b12,b13,b21,b22,b23,b31,b32,b33,out1,out2,out3,out4,out5,out6,out7,out8,out9);
	Demux:demux2to1 port map(DataIn,Clock,SelRegister,toA,toB);	 
	Out11 <= out1;
	Out12 <= out2;
	Out13 <= out3;
	Out21 <= out4;
	Out22 <= out5;
	Out23 <= out6;
	Out31 <= out7;
	Out32 <= out8;
	Out33 <= out9;

end architecture ic;


