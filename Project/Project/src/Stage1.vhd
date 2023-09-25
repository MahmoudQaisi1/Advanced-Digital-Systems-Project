-- Half Adder--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity halfAdder is
	port(x,y: in std_logic; s,c:out std_logic);
end;

architecture simple of halfAdder is
begin
	g1: entity work.xor2(simple) port map(x,y,s);
	g2: entity work.and2(simple) port map(x,y,c);
end;
-- Full Adder--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity fullAdder is
	port(x,y,z: in std_logic; s,co:out std_logic);
end;

architecture simple of fullAdder is
signal a,b,c,d: std_logic;
begin
	g1: entity work.halfAdder(simple) port map(x,y,a,b);
	g2: entity work.halfAdder(simple) port map(a,z,s,d);
	g3: entity work.or2(simple) port map(b,d,co);
end;

--8-Bit Adder/Subtractor--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

entity Adder8bits is
	port (a,b: in std_logic_vector(7 downto 0);cin:in std_logic;r: out std_logic_vector(7 downto 0); cout: out std_logic);
end Adder8bits;

architecture simple of Adder8bits is
signal ripple,b_neg :std_logic_vector(7 downto 0);
begin
		ripple(0)<=cin;
	gen1: FOR i IN 0 TO 6 GENERATE
		BEGIN
			g1: entity work.xor2(simple) port map(cin,b(i),b_neg(i));
			g2:	entity work.fullAdder(simple) port map(a(i),b_neg(i),ripple(i),r(i),ripple(i+1));
		END GENERATE;
		g3: entity work.xor2(simple) port map(cin,b(7),b_neg(7));
		g4:	entity work.fullAdder(simple) port map(a(7),b_neg(7),ripple(7),r(7),cout);	 
end simple;

--Main Entity--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

entity Comparator is
	port (x,y:in std_logic_vector(7 downto 0);clk:in std_logic;b,e,s:out std_logic);
end Comparator;

-- Stage 1 Archtucture -- 

architecture Stage1 of Comparator is
signal r: std_logic_vector(7 downto 0);
signal c1: std_logic := '1';
signal c2: std_logic;
signal f1,f2,yn,f,g,h: std_logic;
begin
	g1: entity work.Adder8bits(simple) port map(x,y,c1,r,c2);
	g2: entity work.and2(simple) port map(r(7),'1',f1);
	g3: entity work.not1(simple) port map(y(7),yn); 
	g4: entity work.and2(simple) port map(x(7),yn,f2);
	g5: entity work.or2(simple) port map(f1,f2,f);
	g6: entity work.nor8(simple) port map(r,g);
	g7: entity work.nor2(simple) port map(f,g,h);
	reg0: entity work.DFF port map(h,clk,b);
	reg1: entity work.DFF port map(g,clk,e);
	reg2: entity work.DFF port map(f,clk,s);
end Stage1;

--Stage 2 Archtecture--

architecture Stage2 of Comparator is
signal diff: std_logic_vector(7 downto 0);
signal en: std_logic_vector(2 downto 0);
signal v,b1,e1,s1: std_logic;
signal x1,y1:std_logic;
begin
	g1: FOR i IN 0 TO 7 GENERATE
		BEGIN
			g: entity work.xor2(simple) port map (x(i),y(i),diff(i));
		END GENERATE;
	g2: entity work.Encoder8x3 (simple) port map (diff,en,v);
	g3: entity work.Mux8x1(simple) port map(x,en,x1);
	g4: entity work.Mux8x1(simple) port map(y,en,y1);
	g5: entity work.oneBitComp(simple) port map(x1,y1,v,b1,e1,s1);
	reg0: entity work.DFF port map(b1,clk,b);
	reg1: entity work.DFF port map(e1,clk,e);
	reg2: entity work.DFF port map(s1,clk,s);
end Stage2;

--Test Bench-- (just runs the Stages, The generator and the Analyzer)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

entity testb is
end;

architecture bb of testb is
signal x,y:	std_logic_vector(7 downto 0);
signal clk: std_logic := '0';
signal b1,e1,s1,b2,e2,s2:std_logic;
begin
	
	g0: entity work.TestGenerator(simple) port map (clk,x,y,b1,e1,s1);
	g1:	entity work.Comparator(Stage2) port map(x,y,clk,b2,e2,s2);
	g2: entity work.Analyzer(simple) port map (b1,e1,s1,b2,e2,s2,clk);
	
	clk <= not clk after 35ns;
end;
	
	


