library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity kr_fuzman_system1 is
  port
    ( clock : in std_logic;
      V_mux_sel,Z_mux_sel : in std_logic;
      V_load,V_load1,V_load2 : in std_logic;
      Z_load,Z_load1,Z_load2 : in std_logic;
      Ut      : in std_logic_vector(31 downto 0);
      Vref    : in std_logic_vector(31 downto 0);
      Vtminusone : in std_logic_vector(31 downto 0);
      Ztminusone : in std_logic_vector(31 downto 0);
      Vt      : out std_logic_vector(31 downto 0);
      Zt      : out std_logic_vector(31 downto 0)
      );
    end kr_fuzman_system1;
architecture struct of kr_fuzman_system1 is
  component mux21 is
  port ( I0, I1 : in std_logic_vector (31 downto 0);
         s : in std_logic;
         Y : out std_logic_vector (31 downto 0) );
       end component;
  component reg is
  port ( clock,reset,load : in std_logic;
         I : in std_logic_vector (31 downto 0);
         Y : out std_logic_vector (31 downto 0) );
       end component;
  component kr_fuzman_system is
  port
    ( clock   : in std_logic;
      Ut      : in std_logic_vector(31 downto 0);
      Vref    : in std_logic_vector(31 downto 0);
      Vtminusone : in std_logic_vector(31 downto 0);
      Ztminusone : in std_logic_vector(31 downto 0);
      Vt      : out std_logic_vector(31 downto 0);
      Zt      : out std_logic_vector(31 downto 0)
      );
    end component;
    signal Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8 : std_logic_vector(31 downto 0);
    signal R : std_logic := '0';
  begin
    M1 : mux21 port map (I0 => Vtminusone, I1 => Vt, s => V_mux_sel, Y => Z1);
    M2 : reg port map (clock => clock, reset => R, load => V_load, I => Z1, Y => Z2);
    M3 : mux21 port map (I0 => Ztminusone, I1 => Zt, s => Z_mux_sel, Y => Z5);
    M4 : reg port map (clock => clock, reset => R, load => Z_load, I => Z5, Y => Z6);
    M5 : kr_fuzman_system port map (clock => clock, Ut => Ut, Vref => Vref, Vtminusone => Z2, Ztminusone => Z6, Vt => Z3, Zt => Z7);
    M6 : reg port map (clock => clock, reset => R, load => V_load2, I => Z4, Y => Vt);
    M7 : reg port map (clock => clock, reset => R, load => Z_load2, I => Z8, Y => Zt);
    end struct;
