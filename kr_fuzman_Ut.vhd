library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity kr_fuzman_Ut is
  port (clock : in std_logic;
        Ut_enable : in std_logic;
        Ut : out std_logic_vector(31 downto 0)
        );
     end kr_fuzman_Ut;
architecture behav of kr_fuzman_Ut is
signal i : integer range 0 to 19:=0; -- change the range value
signal enable : std_logic:='0';
type lut is array ( 0 to 3**3 - 8) of std_logic_vector(31 downto 0);
constant my_lut : lut := (
0 => "00111110110101110000101000111101",
1 => "01000001100011110111000010100100",
2 => "01000000111111000100111010100101",
3 => "01000001000001110001000011001011",
4 => "11000000001000010100011110101110",
5 => "01000000101101010111000010100100",
6 => "01000001000101101110000101001000",
7 => "01000001011111000011110101110001",
8 => "01000001001101100101110000101001",
9 => "01000000100100100011110101110001",
10 => "01000000010001101101010000101100",
11 => "01000000111001110000011000100101",
12 => "01000000101101000111000100001101",
13 => "01000000111101110101111010011110",
14 => "01000000100110001011100100100100",
15 => "01000001011011101011001011111111",
16 => "01000000110101100111111111001100",
17 => "11000001111001100111000010100100",
18 => "11000001001100001010110000001000",
19 => "01000010000111111010111000010100"
);
begin
process (Ut_enable)
begin
if Ut_enable'event and Ut_enable = '1' then
enable <= '1';
end if;
end process;

process (clock)
begin
if rising_edge (clock) then
if (enable = '1') then
  if (i <= 19) then
Ut <= my_lut(i);
i <= i + 1;
end if;
end if;
end if;
end process;
end behav;
