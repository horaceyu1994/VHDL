library ieee;
use ieee.std_logic_1164.all;

entity D_X is
    port(
	     A:in std_logic_vector(3 downto 0);
		  D:out std_logic_vector(6 downto 0)
		  );
end D_X;

architecture D_X_arch of D_X is
begin
    D<="1001111" when(A="0001") else
			"0010010" when(A="0010") else
			"0000110" when(A="0011") else
			"1001100" when(A="0100") else
			"0100100" when(A="0101") else
			"0100000" when(A="0110") else
			"0001111" when(A="0111") else
			"0000000" when(A="1000") else
			"0000100" when(A="1001") else
			"0000001";
end D_X_arch;