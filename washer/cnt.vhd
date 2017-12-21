library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt is
    port(
	     clk:in std_logic;
		  clr:in std_logic;
		  cout:out std_logic;
		  Q0:out std_logic_vector(3 downto 0);
		  Q1:out std_logic_vector(3 downto 0);
		  Q2:out std_logic_vector(2 downto 0)
		  );
end cnt;

architecture cnt_arch of cnt is
component cnt10
    port(
	     clk:in std_logic;
		  clr:in std_logic;
		  cout:out std_logic;
		  Q:out std_logic_vector(3 downto 0)
		  );
end component;
component cnt6
    port(
	     clk:in std_logic;
		  clr:in std_logic;
		  cout:out std_logic;
		  Q:out std_logic_vector(2 downto 0)
		  );
end component;
signal cout_temp_1,cout_temp_2:std_logic;
begin 
    u1:cnt10 port map(clk,clr,cout_temp_1,Q0);
	 u2:cnt10 port map(cout_temp_1,clr,cout_temp_2,Q1);
	 u3:cnt6 port map(cout_temp_2,clr,cout,Q2);
end cnt_arch;