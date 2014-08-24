library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity kr_fuzman_tb is
end kr_fuzman_tb;
architecture behav of kr_fuzman_tb is
  component kr_fuzman_system2 is
  port 
    ( clock : in std_logic;
      V_mux_sel,Z_mux_sel : in std_logic;
      V_load,V_load1,V_load2 : in std_logic;
      Z_load,Z_load1,Z_load2 : in std_logic;
      Vref_enable,Vref_load : in std_logic;
      Ut_enable,Ut_load : in std_logic;
      Vtminusone : in std_logic_vector(31 downto 0);
      Ztminusone : in std_logic_vector(31 downto 0);
      Vt      : out std_logic_vector(31 downto 0);
      Zt      : out std_logic_vector(31 downto 0)
      );
    end component;
    signal clock,V_mux_sel,Z_mux_sel,V_load,V_load1,V_load2,Z_load,Z_load1,Z_load2,Vref_enable,Vref_load,Ut_enable,Ut_load : std_logic := '0';
    signal Vtminusone,Ztminusone : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    signal Vt,Zt : std_logic_vector(31 downto 0);
    constant clk_period : time := 100 ps;
    begin
      uut: kr_fuzman_system2 port map
                                 ( clock => clock,
                                   V_mux_sel => V_mux_sel,
                                   Z_mux_sel => Z_mux_sel,
                                   V_load => V_load,
                                   V_load1 => V_load1,
                                   V_load2 => V_load2,
                                   Z_load => Z_load,
                                   Z_load1 => Z_load1,
                                   Z_load2 => Z_load2,
                                   Vref_enable => Vref_enable,
                                   Vref_load => Vref_load,
                                   Ut_enable => Ut_enable,
                                   Ut_load => Ut_load,
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
          Vtminusone <= "01000001101010000000000000000000";
          Ztminusone <= "00111111011111010111000010100100";
          Vref_enable <= '1';
          Ut_enable <= '1';
          wait for 100 ps;
          V_load <= '1';
          Z_load <= '1';
          Vref_load <= '1';
          Ut_load <= '1';
          wait for 100 ps;
          V_load1 <= '1';
          Z_load1 <= '1';
          V_load2 <= '1';
          Z_load2 <= '1';
          -- Vtminusone <= Vt;
          -- Ztminusone <= Zt;
          wait for 100 ps;
          V_mux_sel <= '1';
          Z_mux_sel <='1';
          wait;
        end process;
      end;
          
