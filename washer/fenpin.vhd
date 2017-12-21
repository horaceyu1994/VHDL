library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fenpin is
    port(
	     clk:in std_logic;
		  Hz_11:out std_logic;
		  Hz_366:out std_logic
		  );
end fenpin;

architecture fenpin_arch of fenpin is 
signal counter:std_logic_vector(20 downto 0);
begin
    process(clk)
	 begin
	     if clk'event and clk='1' then 
		  counter<=counter+1;
		  end if;
	 end process;
	 Hz_11<=counter(20);
	 Hz_366<=counter(15);
end fenpin_arch;