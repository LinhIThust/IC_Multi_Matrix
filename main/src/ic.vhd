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
			if RST='1'then 
				DOUT<="00000000";
			else
				if rising_edge(CLK) then 
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
		clk:in std_logic;
		DataIn,MatrixIn1,MatrixIn2: in std_logic_vector(7 downto 0);
		SelF:in std_logic_vector(1 downto 0);
        outB: out std_logic_vector(7 downto 0)
		);
end entity mux;

architecture chooseIn of mux is
begin
	process (SelF,clk)
	begin
		if SelF = "01" then
			outB <= MatrixIn1;
		elsif SelF ="10" then
			outB <= MatrixIn2;
		elsif SelF ="00" then
			outB <= DataIn;
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
	DOUT1,DOUT2,DOUT3,DOUT4,DOUT5,DOUT6,DOUT7,DOUT8,DOUT9: out std_logic_vector(7 downto 0)
	); 	
end entity nine_byte_register;	

architecture write_byte of nine_byte_register is 
	signal s1,s2,s3,s4,s5,s6,s7,s8,s9:std_logic_vector(7 downto 0);	 
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
			clk:in std_logic;
			DataIn,MatrixIn1,MatrixIn2: in std_logic_vector(7 downto 0);
			SelF:in std_logic_vector(1 downto 0);
	        outB: out std_logic_vector(7 downto 0)
			);
	end component mux;
	
	begin
		matrixb1(0) <="00000010";matrixb1(1) <="00000000";matrixb1(2) <="11111110";
		matrixb1(3) <="00000011";matrixb1(4) <="00000000";matrixb1(5) <="11111101";
		matrixb1(6) <="00000010";matrixb1(7) <="00000000";matrixb1(8) <="00000010";	   
		matrixb2(0) <="00000000";matrixb2(1) <="00000001";matrixb2(2) <="00000010";
		matrixb2(3) <="00000011";matrixb2(4) <="00000100";matrixb2(5) <="00000101";
		matrixb2(6) <="00000110";matrixb2(7) <="00000111";matrixb2(8) <="00001000";
		M1:mux port map(CLK,DIN,matrixb1(0),matrixb2(0),SelF,DIN1);
		U1:eight_bit_register port map(DIN1,CLK,RST,s1 );
		M2:mux port map(CLK,s1,matrixb1(1),matrixb2(1),SelF,DIN2);
		U2:eight_bit_register port map(DIN2,CLK,RST,s2 );
		M3:mux port map(CLK,s2,matrixb1(2),matrixb2(2),SelF,DIN3);
		U3:eight_bit_register port map(DIN3,CLK,RST,s3 );
		M4:mux port map(CLK,s3,matrixb1(3),matrixb2(3),SelF,DIN4); 
		U4:eight_bit_register port map(DIN4,CLK,RST,s4 );
		M5:mux port map(CLK,s4,matrixb1(4),matrixb2(4),SelF,DIN5);
		U5:eight_bit_register port map(DIN5,CLK,RST,s5 );
		M6:mux port map(CLK,s5,matrixb1(5),matrixb2(5),SelF,DIN6);
		U6:eight_bit_register port map(DIN6,CLK,RST,s6 );
		M7:mux port map(CLK,s6,matrixb1(6),matrixb2(6),SelF,DIN7);
		U7:eight_bit_register port map(DIN7,CLK,RST,s7 );
		M8:mux port map(CLK,s7,matrixb1(7),matrixb2(7),SelF,DIN8);
		U8:eight_bit_register port map(DIN8,CLK,RST,s8 );
		M9:mux port map(CLK,s8,matrixb1(8),matrixb2(8),SelF,DIN9); 
		U9:eight_bit_register port map(DIN9,CLK,RST,s9 ); 
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
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;


entity demux2to1 is
    Port(
		CLK:in std_logic;
		DataIn: in std_logic_vector(7 downto 0);
		SelAB: in std_logic;
        OutA,OutB: out std_logic_vector(7 downto 0)
		);
end entity demux2to1;

architecture demux2to1 of demux2to1 is
begin
	process (DataIn)
	begin
		if SelAB = '1' then
				OutA <= DataIn;
		else
				OutB <= DataIn;
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
		A11,A12,A13,A21,A22,A23,A31,A32,A33: in std_logic_vector(7 downto 0);	
		B11,B12,B13,B21,B22,B23,B31,B32,B33: in std_logic_vector(7 downto 0);
		--------------------------------------	
		Result11,Result12,Result13,Result21,Result22,Result23,Result31,Result32,Result33: out std_logic_vector(7 downto 0)
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
	temp9 <= (A31*B13+A32*B23+A33*B33);
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
	Out11,Out12,Out13,Out21,Out22,Out23,Out31,Out32,Out33: out std_logic_vector(7 downto 0)  
	);
end entity ic_main;

architecture ic of ic_main is

component demux2to1
    Port(
		CLK:in std_logic;
		DataIn: in std_logic_vector(7 downto 0);
		SelAB: in std_logic;
        OutA,OutB: out std_logic_vector(7 downto 0)
		);
end component demux2to1;

component multi_matrix 
	Port(
	A11,A12,A13,A21,A22,A23,A31,A32,A33: in std_logic_vector(7 downto 0);	
	B11,B12,B13,B21,B22,B23,B31,B32,B33: in std_logic_vector(7 downto 0);
	--------------------------------------	
	Result11,Result12,Result13,Result21,Result22,Result23,Result31,Result32,Result33: out std_logic_vector(7 downto 0)
	);
end component multi_matrix;

component nine_byte_register 
	port(
	DIN: in std_logic_vector(7 downto 0);
	CLK: in std_logic;
	RST: in std_logic;
	SelF:in std_logic_vector(1 downto 0);
	DOUT1,DOUT2,DOUT3,DOUT4,DOUT5,DOUT6,DOUT7,DOUT8,DOUT9: out std_logic_vector(7 downto 0)
	); 	
end component nine_byte_register;

signal toA,a11,a12,a13,a21,a22,a23,a31,a32,a33: std_logic_vector(7 downto 0);
signal toB,b11,b12,b13,b21,b22,b23,b31,b32,b33: std_logic_vector(7 downto 0);
signal out1,out2,out3,out4,out5,out6,out7,out8,out9:std_logic_vector(7 downto 0);


begin
	A:nine_byte_register port map(toA,Clock,Reset,"00",a11,a12,a13,a21,a22,a23,a31,a32,a33);
	B:nine_byte_register port map(toB,Clock,Reset,SelF,b11,b12,b13,b21,b22,b23,b31,b32,b33);
	Multi:multi_matrix port map(a11,a12,a13,a21,a22,a23,a31,a32,a33,b11,b12,b13,b21,b22,b23,b31,b32,b33,out1,out2,out3,out4,out5,out6,out7,out8,out9);
	Demux:demux2to1 port map(Clock,DataIn,SelRegister,toA,toB);	 
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


