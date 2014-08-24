library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity reg is
  port ( clock,reset,load : in std_logic;
         I : in std_logic_vector (31 downto 0);
         Y : out std_logic_vector (31 downto 0) );
       end reg;
architecture behav of reg is
  begin
    process ( clock, reset, load, I)
      begin
        if (reset = '1') then
          Y <= "00000000000000000000000000000000";
        elsif (clock'event and clock = '1') then
          if (load = '1') then
            Y <= I;
          end if;
        end if;
      end process;
    end behav;


