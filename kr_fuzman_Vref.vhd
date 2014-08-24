library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity kr_fuzman_Vref is
  port (clock : in std_logic;
        Vref_enable : in std_logic;
        Vref : out std_logic_vector(31 downto 0)
        );
     end kr_fuzman_Vref;
architecture behav of kr_fuzman_Vref is
signal i : integer range 0 to 19:=0; -- change the range value
signal enable : std_logic:='0';
type lut is array ( 0 to 3**3 - 8) of std_logic_vector(31 downto 0);
constant my_lut : lut := (
0 => "01000001101000000000000000000000",
1 => "01000001101001001100110011001101",
2 => "01000001100110100010100011110110",
3 => "01000001101000001100110011001101",
4 => "01000001100111100110011001100110",
5 => "01000001100110101110000101001000",
6 => "01000001100110110101110000101001",
7 => "01000001100111001111010111000011",
8 => "01000001100110110000101000111101",
9 => "01000001101000110011001100110011",
10 => "01000001100110101000111101011100",
11 => "01000001100100001100110011001101",
12 => "01000001100111010001111010111000",
13 => "01000001100110100000000000000000",
14 => "01000001100110111000010100011111",
15 => "01000001100110011010111000010100",
16 => "01000001100111011000010100011111",
17 => "01000001100111010101110000101001",
18 => "01000001100111001111010111000011",
19 => "01000001100111001010001111010111"
);
begin
process (Vref_enable)
begin
if Vref_enable'event and Vref_enable = '1' then
enable <= '1';
end if;
end process;

process (clock)
begin
if rising_edge (clock) then
if (enable = '1') then
  if (i <= 19) then
Vref <= my_lut(i);
i <= i + 1;
end if;
end if;
end if;
end process;
end behav;