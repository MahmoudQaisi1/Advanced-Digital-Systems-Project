
--The inverter--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity not1 is 
	port(x: in std_logic;y:out std_logic);
end;

architecture simple of not1 is
begin
	y<= not x after 2ns;
end;
--And Gates (with different number of ports)--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity and2 is 
	port(x0,x1: in std_logic;y:out std_logic);
end;

architecture simple of and2 is
begin
	y<= x0 and x1 after 7ns;
end;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity and3 is 
	port(x0,x1,x2: in std_logic;y:out std_logic);
end;

architecture simple of and3 is
begin
	y<= x0 and x1 and x2 after 7ns;
end;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity and4 is 
	port(x0,x1,x2,x3: in std_logic;y:out std_logic);
end;

architecture simple of and4 is
begin
	y<= x0 and x1 and x2 and x3 after 7ns;
end;

--or gates--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity or2 is 
	port(x0,x1: in std_logic;y:out std_logic);
end;

architecture simple of or2 is
begin
	y<= x0 or x1 after 7ns;
end;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity or4 is 
	port(x0,x1,x2,x3: in std_logic;y:out std_logic);
end;

architecture simple of or4 is
begin
	y<= x0 or x1 or x2 or x3 after 7ns;
end;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity or8 is 
	port(x: in std_logic_vector(7 downto 0);y:out std_logic);
end;

architecture simple of or8 is
begin
	y<= x(0) or x(1) or x(2) or x(3) or x(4) or x(5) or x(6) or x(7) after 7ns;
end;

--nand gate--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity nand2 is 
	port(x0,x1: in std_logic;y:out std_logic);
end;

architecture simple of nand2 is
begin
	y<= x0 nand x1 after 5ns;
end;

--nor gates--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity nor2 is 
	port(x0,x1: in std_logic;y:out std_logic);
end;

architecture simple of nor2 is
begin
	y<= x0 nor x1 after 5ns;
end;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity nor8 is 
	port(x: in std_logic_vector(7 downto 0);y:out std_logic);
end;

architecture simple of nor8 is
signal n:std_logic;
begin
	n<= x(0) or x(1) or x(2) or x(3) or x(4) or x(5) or x(6) or x(7);
	y<= not n after 5ns;
end;

--xnor gates--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity xnor2 is 
	port(x0,x1: in std_logic;y:out std_logic);
end;

architecture simple of xnor2 is
begin
	y<= x0 xnor x1 after 9ns;
end;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity xor2 is 
	port(x0,x1: in std_logic;y:out std_logic);
end;

architecture simple of xor2 is
begin
	y<= x0 xor x1 after 12ns;
end; 

--xor gate--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity xor3 is 
	port(x0,x1,x2: in std_logic;y:out std_logic);
end;

architecture simple of xor3 is
begin
	y<= x0 xor x1 xor x2 after 12ns;
end;

-- D flip flop--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity DFF is
	port (D,clk:in std_logic; Q: out std_logic);
end DFF;

ARCHITECTURE simple OF DFF IS
BEGIN
	PROCESS (clk)
		BEGIN
			IF ( rising_edge(clk) ) THEN
				q <= d;
			END IF;
	END PROCESS;
END ARCHITECTURE simple;

--8 bit register---

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity DFF8 is
	port (D:in std_logic_vector(7 downto 0); clk:in std_logic; Q: out std_logic_vector(7 downto 0));
end DFF8;

ARCHITECTURE simple OF DFF8 IS
BEGIN
	gen1: FOR i IN 0 TO 7 GENERATE
		BEGIN
			g1: entity work.DFF(simple) port map(D(i),clk,Q(i));
		END GENERATE;
END ARCHITECTURE simple;