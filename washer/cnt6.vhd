library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt6 is
    port(
	     clk:in std_logic;
		  clr:in std_logic;
		  cout:out std_logic;
		  Q:out std_logic_vector(2 downto 0)
		  );
end cnt6;

architecture cnt6_arch of cnt6 is
signal counter:std_logic_vector(2 downto 0);
begin 
    process(clk)
	 begin
	     if clr='0' then
		  counter<="000";
		  cout<='0';
		  else
	         if clk'event and clk='1' then 
		      if counter="101" then
				cout<='1';
				counter<="000";
				elsif counter="100" then
				cout<='0';
				counter<=counter+1;
				else
				cout<='0';
				counter<=counter+1;
				end if;
		      end if;
	     end if;	   
    end process;
    Q<=counter;
end cnt6_arch;	 