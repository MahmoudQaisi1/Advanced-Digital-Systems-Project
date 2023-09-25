
--Priority Encoder 8x3--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity Encoder8x3 is
	port (x: in std_logic_vector(7 downto 0); y: out std_logic_vector(2 downto 0);v: out std_logic);
end Encoder8x3;
-- x(7-0)--a,b,c,d,e,f,g,h
architecture simple of Encoder8x3 is
signal reg: std_logic_vector(9 downto 0);

-- reg9 -- 6'
-- reg8 -- 5'
-- reg7 -- 4'
-- reg6 -- 3'
-- reg5 -- 2'
-- reg4 -- 5'4'2
-- reg3 -- 5'4'3
-- reg2 -- 6'4'2'1
-- reg1 -- 6'4'3
-- reg0 -- 6'5

begin
	g1: entity work.or4(simple) port map(x(7),x(6),x(5),x(4),y(2));
	g2: entity work.not1(simple) port map(x(6),reg(9));
	g3: entity work.not1(simple) port map(x(5),reg(8));
	g4: entity work.not1(simple) port map(x(4),reg(7));
	g5: entity work.not1(simple) port map(x(3),reg(6));
	g6: entity work.not1(simple) port map(x(2),reg(5));
	g7: entity work.and3(simple) port map(reg(8),reg(7),x(2),reg(4));
	g8: entity work.and3(simple) port map(reg(8),reg(7),x(3),reg(3));
	g9: entity work.or4(simple) port map(reg(4),reg(3),x(6),x(7),y(1));
	g10: entity work.and4(simple) port map(reg(9),reg(7),reg(5),x(1),reg(2));
	g11: entity work.and3(simple) port map(reg(9),reg(7),x(3),reg(1));
	g12: entity work.and2(simple) port map(reg(9),x(5),reg(0));
	g13: entity work.or4(simple) port map(reg(2),reg(1),reg(0),x(7),y(0));
	v <= x(7); 
	
end simple;

--Mux8x1--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity Mux8x1 is
	port (x: in std_logic_vector(7 downto 0); s: in std_logic_vector(2 downto 0);y: out std_logic);
end Mux8x1;

architecture simple of Mux8x1 is
signal s1: std_logic_vector(2 downto 0);
signal x1: std_logic_vector(7 downto 0);
begin
g0: entity work.not1(simple) port map(s(0),s1(0));
g1: entity work.not1(simple) port map(s(1),s1(1));
g2: entity work.not1(simple) port map(s(2),s1(2));
g3: entity work.and4(simple) port map(x(0),s1(0),s1(1),s1(2),x1(0));
g4: entity work.and4(simple) port map(x(1),s(0),s1(1),s1(2),x1(1));
g5: entity work.and4(simple) port map(x(2),s1(0),s(1),s1(2),x1(2));
g6: entity work.and4(simple) port map(x(3),s(0),s(1),s1(2),x1(3));
g7: entity work.and4(simple) port map(x(4),s1(0),s1(1),s(2),x1(4));
g8: entity work.and4(simple) port map(x(5),s(0),s1(1),s(2),x1(5));
g9: entity work.and4(simple) port map(x(6),s1(0),s(1),s(2),x1(6));
g10: entity work.and4(simple) port map(x(7),s(0),s(1),s(2),x1(7));
g11: entity work.or8(simple) port map(x1,y);

end simple;

--One Bit/ Sign Comparator--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity oneBitComp is
	port (x,y,sn: in std_logic;b,e,s: out std_logic);
end oneBitComp;

architecture simple of oneBitComp is
signal xn,yn,snn,c1,c2,c3,c4: std_logic;
begin
	g1: entity work.not1(simple) port map(x,xn);
	g2: entity work.not1(simple) port map(y,yn);
	g3: entity work.not1(simple) port map(sn,snn);	
	g4: entity work.and3(simple) port map(snn,x,yn,c1);
	g5: entity work.and3(simple) port map(sn,xn,y,c2);
	g6: entity work.or2(simple) port map(c1,c2,b);
	g7: entity work.and3(simple) port map(snn,xn,y,c3);
	g8: entity work.and3(simple) port map(sn,x,yn,c4);
	g9: entity work.or2(simple) port map(c3,c4,s);
	g10: entity work.xnor2(simple) port map(x,y,e);	

end simple;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--Test Generator--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.numeric_std.ALL;

entity TestGenerator is
	port(clk: in std_logic; x,y: out std_logic_vector(7 downto 0);b,e,s: out std_logic);
end TestGenerator;

architecture simple of TestGenerator is
signal x1,y1: std_logic_vector(7 downto 0);
signal b1,e1,s1: std_logic;
begin
	process
	begin
		WAIT UNTIL RISING_EDGE(CLK);
		FOR i IN -128 TO 127 LOOP
			FOR j IN -128 TO 127 LOOP
			x1 <= std_logic_vector( to_signed(i,8));
			y1 <= std_logic_vector( to_signed(j,8));
			WAIT UNTIL RISING_EDGE(CLK);
			END LOOP;
		END LOOP;
		wait;
	end process;
	x<=x1;
	y<=y1;
	b1 <= '1' when x1 > y1 else '0';
	e1<= '1' when x1 = y1 else '0';
	s1<= '1' when x1 < y1 else '0';	
	reg0: entity work.DFF port map(b1,clk,b);
	reg1: entity work.DFF port map(e1,clk,e);
	reg2: entity work.DFF port map(s1,clk,s);
end simple;

--Test Analyzer--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity Analyzer is
	port (b1,e1,s1,b2,e2,s2,clk:in std_logic);	
end Analyzer;

architecture simple of Analyzer is
begin
	 process	
	begin  
		assert b1 = b2
		report "Practical Resuls differ from theoraticly obtained observastions"
		severity ERROR;
		assert e1 = e2
		report "Practical Resuls differ from theoraticly obtained observastions"
		severity ERROR;
		assert s1 = s2
		report "Practical Resuls differ from theoraticly obtained observastions"
		severity ERROR;
		WAIT UNTIL rising_edge(CLK);
	end process;
end simple;

	