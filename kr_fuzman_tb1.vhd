library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity kr_fuzman_tb1 is
end kr_fuzman_tb1;
architecture behav of kr_fuzman_tb1 is
  component kr_fuzman_system1 is
  port 
    ( clock : in std_logic;
      V_mux_sel,Z_mux_sel : in std_logic;
      V_load,V_load1 : in std_logic;
      Z_load,Z_load1 : in std_logic;
      Ut : in std_logic_vector(31 downto 0);
      Vref : in std_logic_vector(31 downto 0);
      Vtminusone : in std_logic_vector(31 downto 0);
      Ztminusone : in std_logic_vector(31 downto 0);
      Vt      : inout std_logic_vector(31 downto 0);
      Zt      : inout std_logic_vector(31 downto 0)
      );
    end component;
    signal clock,V_mux_sel,Z_mux_sel,V_load,V_load1,Z_load,Z_load1 : std_logic := '0';
    signal Ut,Vref,Vtminusone,Ztminusone : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    signal Vt,Zt : std_logic_vector(31 downto 0);
    constant clk_period : time := 100 ps;
    begin
      uut: kr_fuzman_system1 port map
                                 ( clock => clock,
                                   V_mux_sel => V_mux_sel,
                                   Z_mux_sel => Z_mux_sel,
                                   V_load => V_load,
                                   V_load1 => V_load1,
                                   Z_load => Z_load,
                                   Z_load1 => Z_load1,
                                   Ut => Ut,
                                   Vref => Vref,
                                   Vtminusone => Vtminusone,
                                   Ztminusone => Ztminusone,
                                   Vt => Vt,
                                   Zt => Zt);
        clk_process : process
        begin
          clock <= '0';
          wait for clk_period/2;
          clock <= '1';
          wait for clk_period/2;
         end process;
        stim_proc : process
        begin
          wait for 100 ps;
          V_mux_sel <= '0';
          Z_mux_sel <= '0';
          Ut <= "00111110110101110000101000111101";
          Vref <= "01000001101000000000000000000000";
          Vtminusone <= "01000001101010000000000000000000";
          Ztminusone <= "00111111011111010111000010100100";
          V_load <= '1';
          Z_load <= '1';
          wait for 3950 ps;
          V_load1 <= '1';
          wait for 100 ps;
          V_mux_sel <= '1';
          wait for 1150ps;
          Z_load1 <= '1';
          wait for 100 ps;
          Z_mux_sel <= '1';
          wait for 100 ps;
          Vref <= "01000001101001001100110011001101";
          Ut <= "01000001100011110111000010100100";
          Vtminusone <= Vt;
          Ztminusone <= Zt;
          wait for 5500 ps;
          Vref <= "01000001100110100010100011110110";
          Ut <= "01000000111111000100111010100101";
          wait;
        end process;
        end;
