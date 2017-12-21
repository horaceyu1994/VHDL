library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fenpin is
    port(
	     clk:in std_logic;
		  Hz_0_36:out std_logic;
		  Hz_1_4:out std_logic;
		  Hz_11:out std_logic;
		  Hz_46:out std_logic;
		  Hz_1465:out std_logic
		  );
end fenpin;

architecture fenpin_arch of fenpin is 
signal count:std_logic_vector(25 downto 0);
begin
    process(clk)
	 begin
	     if clk'event and clk='1' then 
		  count<=count+1;
		  end if;
	 end process;
	 Hz_0_36<=count(25);
	 Hz_1_4<=count(23);
	 Hz_11<=count(20);
	 Hz_46<=count(18);
	 Hz_1465<=count(13);
end fenpin_arch;