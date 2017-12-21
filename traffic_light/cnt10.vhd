library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt10 is
    port(
	     clk:in std_logic;
		  clr:in std_logic;
		  A:in std_logic_vector(3 downto 0);
		  cout:out std_logic;
		  Q:out std_logic_vector(3 downto 0)
		  );
end cnt10;

architecture cnt10_arch of cnt10 is
signal counter:std_logic_vector(3 downto 0);
begin 
    process(clk)
	 begin
	     if clr='0' then
		  counter<=A;
		  cout<='0';
		  else
	         if clk'event and clk='1' then 
		      if counter="0000" then
				cout<='1';
				counter<="1001";
				else
				cout<='0';
				counter<=counter-1;
				end if;
		      end if;
	     end if;	   
    end process;
    Q<=counter;
end cnt10_arch;	 