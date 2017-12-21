library ieee;
use ieee.std_logic_1164.all;

entity light_state is
    port(
	     clk:in std_logic;
		  d_clk:in std_logic;
		  t_over:in std_logic;
		  reset:in std_logic;
		  start:in std_logic;
		  state:buffer std_logic_vector(2 downto 0);
		  ct:out std_logic_vector(2 downto 0)
		  );
end light_state;

architecture light_state_arch of light_state is
type statetype is(st0,st1,st2,st3);
signal sta:statetype;
signal d_state:std_logic_vector(2 downto 0);
begin
    process(clk)
	 begin
	     if reset='0' then
		  sta<=st0;
		  elsif clk'event and clk='1' then
		  case sta is
		  when st0=>if start='0' then
		            sta<=st1;
		            end if;
		  when st1=>if t_over='1' then
		            sta<=st2;
		            end if;
		  when st2=>if t_over='1' then
		            sta<=st3;
		            end if;
		  when others=>if t_over='1' then
		               sta<=st1;
		            	end if;
		  end case;
		  end if;
    end process;
	 state<="011" when(sta=st1) else
	        "101" when(sta=st2) else
			  "110" when(sta=st3) else
			  "111";
	 process(d_clk)
	 begin
	     if d_clk'event and d_clk='1' then
		  d_state<=state;
		  end if;
	 end process;
	 ct(2)<=not((not d_state(2)) and t_over);
	 ct(1)<=not((not d_state(1)) and t_over);
	 ct(0)<=not((not d_state(0)) and t_over) and start;
end light_state_arch;