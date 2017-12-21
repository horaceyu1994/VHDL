library ieee;
use ieee.std_logic_1164.all;

entity washer is
    port(
	     clk:in std_logic;
		  reset:in std_logic;
		  start:in std_logic;
		  full:in std_logic;
		  W:out std_logic_vector(2 downto 0);
		  D:out std_logic_vector(6 downto 0);
		  led:out std_logic_vector(0 to 5)
		  );
end washer;

architecture washer_arch of washer is
component fenpin
    port(
	     clk:in std_logic;
		  Hz_11:out std_logic;
		  Hz_366:out std_logic
		  );
end component;
component cnt
    port(
	     clk:in std_logic;
		  clr:in std_logic;
		  cout:out std_logic;
		  Q0:out std_logic_vector(3 downto 0);
		  Q1:out std_logic_vector(3 downto 0);
		  Q2:out std_logic_vector(2 downto 0)
		  );
end component;
component W_X
    port(
	     clk:in std_logic;
		  W:out std_logic_vector(2 downto 0)
		  );
end component;
component D_X
    port(
	     A:in std_logic_vector(3 downto 0);
		  D:out std_logic_vector(6 downto 0)
		  );
end component;
component washer_state
    port(
	     clk:in std_logic;
	     reset:in std_logic;
		  start:in std_logic;
		  full:in std_logic;
		  p_over:in std_logic;
		  f_over:in std_logic;
		  t_over:in std_logic;
		  b_over:in std_logic;
		  state:buffer std_logic_vector(0 to 5);
		  ct:out std_logic_vector(0 to 3)
		  );
end component;
component delay
    port(
	     clk:in std_logic;
		  clr:in std_logic;
		  d_clr:out std_logic
		  );
end component;
 signal Hz_11N,Hz_366N,clrN,d_clrN,coutN,p_overN,f_overN,t_overN,b_overN:std_logic;
 signal QN0,QN1,AN:std_logic_vector(3 downto 0);
 signal QN2,WN:std_logic_vector(2 downto 0);
 signal ctN:std_logic_vector(0 to 3);
 signal stateN:std_logic_vector(0 to 5);
 begin
     clrN<=ctN(0) and ctN(1) and ctN(2) and ctN(3) and stateN(0) and stateN(1);
	  p_overN<=QN2(2);
	  f_overN<=QN2(1) and QN2(0);
	  t_overN<=QN2(1);
	  b_overN<=QN2(0);
	  AN(3)<=(WN(0) and QN0(3)) or (WN(1) and QN1(3));
	  AN(2)<=(WN(0) and QN0(2)) or (WN(1) and QN1(2)) or (WN(2) and QN2(2));
	  AN(1)<=(WN(0) and QN0(1)) or (WN(1) and QN1(1)) or (WN(2) and QN2(1));
	  AN(0)<=(WN(0) and QN0(0)) or (WN(1) and QN1(0)) or (WN(2) and QN2(0));
     u1:fenpin port map(clk,Hz_11N,Hz_366N);
	  u2:cnt port map(Hz_11N,d_clrN,coutN,QN0,QN1,QN2);
	  u3:W_X port map(Hz_366N,WN);
	  u4:washer_state port map(Hz_11N,reset,start,full,p_overN,f_overN,t_overN,b_overN,stateN,ctN);
	  u5:D_X port map(AN,D);
	  u6:delay port map(Hz_11N,clrN,d_clrN);
	  W(2)<=not WN(2);
	  W(1)<=not WN(1);
	  W(0)<=not WN(0);
	  led<=stateN;
end washer_arch;