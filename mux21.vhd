library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
entity mux21 is
  port ( I0, I1 : in std_logic_vector (31 downto 0);
         s : in std_logic;
         Y : out std_logic_vector (31 downto 0) );
       end mux21;
architecture behav of mux21 is
    begin
    process (s,I0,I1)
      begin
      if s = '0' then
        Y <= I0;
      elsif s = '1' then
        Y <= I1;
      end if;
    end process;
  end behav;

