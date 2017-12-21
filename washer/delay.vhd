library ieee;
use ieee.std_logic_1164.all;

entity delay is
    port(
	     clk:in std_logic;
		  clr:in std_logic;
		  d_clr:out std_logic
		  );
end delay;

architecture delay_arch of delay is
begin
    process(clk)
	 begin
	     if clk'event and clk='1' then
		  d_clr<=clr;
		  end if;
	 end process;
end delay_arch;