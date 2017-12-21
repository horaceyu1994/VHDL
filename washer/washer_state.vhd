library ieee;
use ieee.std_logic_1164.all;

entity washer_state is
    port(
	     clk:in std_logic;
	     reset:in std_logic;
		  start:in std_logic;
		  full:in std_logic;
		  p_over:in std_logic;
		  f_over:in std_logic;
		  t_over:in std_logic;
		  b_over:in std_logic;
		  state:buffer std_logic_vector(0 to 5);
		  ct:out std_logic_vector(0 to 3)
		  );
end washer_state;

architecture washer_state_arch of washer_state is
type statetype is(st0,st1,st2,st3,st4,st5);
signal sta:statetype;
begin
    process(clk,reset)
	 begin
	     if reset='0' then 
		  sta<=st0;
		  elsif clk'event and clk='1' then
		  case sta is
		  when st0=>if start='0' then 
		            sta<=st1;
						end if;
		  when st1=>if full='0' then 
		            sta<=st2;
						end if;
		  when st2=>if p_over='1' then 
		            sta<=st3;
						end if;
		  when st3=>if f_over='1' then 
		            sta<=st4;
			         end if;
		  when st4=>if t_over='1' then 
		            sta<=st5;
						end if;
		  when others=>if b_over='1' then 
		               sta<=st0;
					      end if;
		  end case;
		  end if;
	 end process;
	 state<="011111"when(sta=st0)else
	        "101111"when(sta=st1)else
			  "110111"when(sta=st2)else
			  "111011"when(sta=st3)else
			  "111101"when(sta=st4)else
			  "111110";
	 ct(0)<=not(not(state(2)) and p_over);
	 ct(1)<=not(not(state(3)) and f_over);
	 ct(2)<=not(not(state(4)) and t_over);
	 ct(3)<=not(not(state(5)) and b_over);
end washer_state_arch;