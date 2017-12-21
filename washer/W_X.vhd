library ieee;
use ieee.std_logic_1164.all;

entity W_X is
    port(
	     clk:in std_logic;
		  W:out std_logic_vector(2 downto 0)
		  );
end W_X;

architecture W_X_arch of W_X is
signal WN:std_logic_vector(2 downto 0);
begin
    process(clk)
	 begin
	     if clk'event and clk='1' then 
	     WN(2)<=not(WN(2))and WN(1) and not(WN(0));
	     WN(1)<=not(WN(2))and not(WN(1)) and WN(0);
	     WN(0)<=WN(2) or (WN(1) xnor WN(0));
	 end if;
	 end process;
	 W<=WN;
end W_X_arch;