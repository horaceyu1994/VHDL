library ieee;
use ieee.std_logic_1164.all;

entity light is
    port(
	     clk:in std_logic;
		  rst:in std_logic;
		  start:in std_logic;
		  row:out std_logic_vector(3 downto 0);
		  column:in std_logic_vector(3 downto 0);
		  seg7:out std_logic_vector(6 downto 0);
		  seg7_S:out std_logic_vector(6 downto 0);
		  seg7_G:out std_logic_vector(6 downto 0);
		  led:out std_logic_vector(2 downto 0);
		  w:out std_logic
		  );
end light;

architecture light_arch of light is
component fenpin
    port(
	     clk:in std_logic;
		  Hz_0_36:out std_logic;
		  Hz_1_4:out std_logic;
		  Hz_11:out std_logic;
		  Hz_46:out std_logic;
		  Hz_1465:out std_logic
		  );
end component;
component keyboard
    port(
	     clk:in std_logic;
		  rst:in std_logic;
		  row:out std_logic_vector(3 downto 0);
		  column:in std_logic_vector(3 downto 0);
		  seg7_out:out std_logic_vector(6 downto 0);
		  R_S:out std_logic_vector(3 downto 0);
		  R_G:out std_logic_vector(3 downto 0);
		  G_S:out std_logic_vector(3 downto 0);
		  G_G:out std_logic_vector(3 downto 0);
		  Y_S:out std_logic_vector(3 downto 0);
		  Y_G:out std_logic_vector(3 downto 0)
		  );
end component;
component cnt10
    port(
	     clk:in std_logic;
		  clr:in std_logic;
		  A:in std_logic_vector(3 downto 0);
		  cout:out std_logic;
		  Q:out std_logic_vector(3 downto 0)
		  );
end component;
component D_X
    port(
	     A:in std_logic_vector(3 downto 0);
		  D:out std_logic_vector(6 downto 0)
		  );
end component;
component light_state
    port(
	     clk:in std_logic;
		  d_clk:in std_logic;
		  t_over:in std_logic;
		  reset:in std_logic;
		  start:in std_logic;
		  state:buffer std_logic_vector(2 downto 0);
		  ct:out std_logic_vector(2 downto 0)
		  );
end component;
component delay
    port(
	     clk:in std_logic;
	     clr:in std_logic;
		  d_clr:out std_logic
		  );
end component;
signal Hz_0_36N,Hz_1_4N,Hz_11N,Hz_46N,Hz_1465N,t_overN,cout_temp,coutN,clr,en_D,en_flinker:std_logic;
signal R_SN,R_GN,G_SN,G_GN,Y_SN,Y_GN,Q0,Q1,A0,A1:std_logic_vector(3 downto 0);
signal ctN,ctN1,ctN2,ledN:std_logic_vector(2 downto 0);
signal seg7_GN,seg7_SN:std_logic_vector(6 downto 0);
begin
    w<='0';
	 clr<=ctN1(0) and ctN1(1) and ctN1(2);
	 led(2)<=ledN(2);
	 led(1)<=ledN(1) or (en_flinker and Hz_1_4N);
	 led(0)<=ledN(0);
	 en_D<=ledN(0) and ledN(1) and ledN(2);
	 en_flinker<=(not Q1(3)) and (not Q1(2)) and (not Q1(1)) and (not Q1(0)) and (not Q0(3)) and ((not Q0(2)) or (not Q0(1))) and ledN(0) and (not ledN(1)) and ledN(2);
	 t_overN<=(not Q0(3)) and (not Q0(2)) and (not Q0(1)) and (not Q0(0)) and (not Q1(3)) and (not Q1(2)) and (not Q1(1)) and (not Q1(0));
	 A0(3)<=((not ctN2(0)) and R_GN(3)) or ((not ctN2(2)) and G_GN(3)) or ((not ctN2(1)) and Y_GN(3));
	 A0(2)<=((not ctN2(0)) and R_GN(2)) or ((not ctN2(2)) and G_GN(2)) or ((not ctN2(1)) and Y_GN(2));
	 A0(1)<=((not ctN2(0)) and R_GN(1)) or ((not ctN2(2)) and G_GN(1)) or ((not ctN2(1)) and Y_GN(1));
	 A0(0)<=((not ctN2(0)) and R_GN(0)) or ((not ctN2(2)) and G_GN(0)) or ((not ctN2(1)) and Y_GN(0));
	 A1(3)<=((not ctN2(0)) and R_SN(3)) or ((not ctN2(2)) and G_SN(3)) or ((not ctN2(1)) and Y_SN(3));
	 A1(2)<=((not ctN2(0)) and R_SN(2)) or ((not ctN2(2)) and G_SN(2)) or ((not ctN2(1)) and Y_SN(2));
	 A1(1)<=((not ctN2(0)) and R_SN(1)) or ((not ctN2(2)) and G_SN(1)) or ((not ctN2(1)) and Y_SN(1));
	 A1(0)<=((not ctN2(0)) and R_SN(0)) or ((not ctN2(2)) and G_SN(0)) or ((not ctN2(1)) and Y_SN(0));
	 seg7_G(6)<=seg7_GN(6) or en_D;
	 seg7_G(5)<=seg7_GN(5) or en_D;
	 seg7_G(4)<=seg7_GN(4) or en_D;
	 seg7_G(3)<=seg7_GN(3) or en_D;
	 seg7_G(2)<=seg7_GN(2) or en_D;
	 seg7_G(1)<=seg7_GN(1) or en_D;
	 seg7_G(0)<=seg7_GN(0) or en_D;
	 seg7_S(6)<=seg7_SN(6) or en_D;
	 seg7_S(5)<=seg7_SN(5) or en_D;
	 seg7_S(4)<=seg7_SN(4) or en_D;
	 seg7_S(3)<=seg7_SN(3) or en_D;
	 seg7_S(2)<=seg7_SN(2) or en_D;
	 seg7_S(1)<=seg7_SN(1) or en_D;
	 seg7_S(0)<=seg7_SN(0) or en_D;
	 u1:fenpin port map(clk,Hz_0_36N,Hz_1_4N,Hz_11N,Hz_46N,Hz_1465N);
	 u2:keyboard port map(Hz_1465N,rst,row,column,seg7,R_SN,R_GN,G_SN,G_GN,Y_SN,Y_GN);
	 u3:D_X port map(Q0,seg7_GN);
	 u4:D_X port map(Q1,seg7_SN);
	 u5:light_state port map(Hz_11N,Hz_0_36N,t_overN,rst,start,ledN,ctN);
	 u6:delay port map(Hz_11N,ctN(0),ctN1(0));
	 u7:delay port map(Hz_11N,ctN(1),ctN1(1));
	 u8:delay port map(Hz_11N,ctN(2),ctN1(2));
	 u9:delay port map(Hz_46N,ctN1(0),ctN2(0));
	 u10:delay port map(Hz_46N,ctN1(1),ctN2(1));
	 u11:delay port map(Hz_46N,ctN1(2),ctN2(2));
	 u12:cnt10 port map(Hz_1_4N,clr,A0,cout_temp,Q0);
	 u13:cnt10 port map(cout_temp,clr,A1,coutN,Q1);
end light_arch;