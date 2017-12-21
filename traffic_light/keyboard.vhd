library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity keyboard is
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
end keyboard;

architecture keyboard_arch of keyboard is
signal count:std_logic_vector(1 downto 0);
signal en,fn:std_logic;
signal seg7:std_logic_vector(6 downto 0);
signal data:std_logic_vector(3 downto 0);
signal key:std_logic_vector(9 downto 0);
signal temp:std_logic_vector(23 downto 0);
begin
    p1:process(clk,en)
	 begin
	     if clk'event and clk='1' and en='1' then
		  count<=count+1;
		  end if;
	 end process;
	 row<="0111" when(count="00") else
	      "1011" when(count="01") else
			"1101" when(count="10") else
			"1110" when(count="11") else
			"1111";
	 p2:process(rst)
	 begin
	     if rst='0' then
		  seg7<="1111111";
		  else
		  case count is
		      when "00" => case column is
				                 when "0111" => seg7<="0000001";
									                 data<="0000";
									  when "1011" => seg7<="1001111";
									                 data<="0001";
									  when "1101" => seg7<="0010010";
									                 data<="0010";
									  when "1110" => seg7<="0000110";
									                 data<="0011";
									  when others => seg7<="1111111";
									                 data<="1111";
									  end case;
				when "01" => case column is
				                 when "0111" => seg7<="1001100";
									                 data<="0100";
									  when "1011" => seg7<="0100100";
									                 data<="0101";
									  when "1101" => seg7<="0100000";
									                 data<="0110";
									  when "1110" => seg7<="0001111";
									                 data<="0111";
									  when others => seg7<="1111111";
									                 data<="1111";
									  end case;
				when "10" => case column is
				                 when "0111" => seg7<="0000000";
									                 data<="1000";
									  when "1011" => seg7<="0000100";
									                 data<="1001";
									  when others => seg7<="1111111";
									                 data<="1111";
									  end case;
				when others=> seg7<="1111111";
								  data<="1111";
		  end case;
		  end if;
	 end process;
    en<=data(3) and data(2) and data(1) and data(0);
	 p3:process(clk)
	 variable reg10:std_logic_vector(9 downto 0);
	 begin
	     if clk'event and clk='1' then
		  reg10:=reg10(8 downto 0)& en;
		  end if;
		  key<=reg10;
    end process;
    fn<=key(0) and key(1) and key(2) and key(3) and key(4) and key(5) and key(6) and key(7) and key(8) and key(9);	 
	 p4:process(fn,rst)
	 begin
	     if rst='0' then
		  seg7_out<="1111111";
		  temp<="000000000000000000000000";
	     elsif fn'event and fn='0' then
		  seg7_out<=seg7;
		  temp<=temp(19 downto 0)& data;
		  end if;
	 end process;
	 R_S<=temp(23 downto 20);
	 R_G<=temp(19 downto 16);
	 G_S<=temp(15 downto 12);
	 G_G<=temp(11 downto 8);
	 Y_S<=temp(7 downto 4);
	 Y_G<=temp(3 downto 0);
end keyboard_arch;