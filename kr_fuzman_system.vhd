library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity kr_fuzman_system is
  port
    ( clock   : in std_logic;
      Ut      : in std_logic_vector(31 downto 0);
      Vref    : in std_logic_vector(31 downto 0);
      Vtminusone : in std_logic_vector(31 downto 0);
      Ztminusone : in std_logic_vector(31 downto 0);
      Vt      : out std_logic_vector(31 downto 0);
      Zt      : out std_logic_vector(31 downto 0)
      );
    end kr_fuzman_system;
architecture struct of kr_fuzman_system is
  component kr_fuzman_Ztminus is
  port 
    ( clock : in std_logic;
      Ztminusone: in std_logic_vector (31 downto 0);
      Ztminus : out std_logic_vector (31 downto 0)
      );
    end component;
  component kr_fuzman_koft is
  port 
   ( clock : in std_logic;
     Ztminus : in std_logic_vector (31 downto 0);
     Ztcap : out std_logic_vector (31 downto 0);
     koft : out std_logic_vector (31 downto 0)
   );
  end component;
  component kr_fuzman_Vtminus is
  port
    ( clock : in std_logic;
      Vtminusone : in std_logic_vector (31 downto 0);
      Vref : in std_logic_vector (31 downto 0);
      koft : in std_logic_vector (31 downto 0);
      Vtminus : out std_logic_vector (31 downto 0)
    );
  end component;
  component kr_fuzman_Vt is
  port
     ( clock : in std_logic;
       Ut : in std_logic_vector(31 downto 0);
       Vtminus : in std_logic_vector(31 downto 0);
       Vt : out std_logic_vector(31 downto 0)
     );
   end component;
   component kr_fuzman_omegat is
  port 
    ( clock : in std_logic;
      koft : in std_logic_vector (31 downto 0);
      Ztcap : in std_logic_vector (31 downto 0);
      omegat : out std_logic_vector (31 downto 0)
    );
  end component;
  component kr_fuzman_Zt is
  port
    ( clock : in std_logic;
      koft : in std_logic_vector(31 downto 0);
      Ztminus : in std_logic_vector(31 downto 0);
      omegat : in std_logic_vector(31 downto 0);
      Zt : out std_logic_vector(31 downto 0)
    );
  end component;
  signal X1,X2,X3,X4,X5 : std_logic_vector(31 downto 0);
  begin
    M1 : kr_fuzman_Ztminus port map (clock => clock, Ztminusone => Ztminusone, Ztminus => X1);
    M2 : kr_fuzman_koft port map (clock => clock, Ztminus => X1, Ztcap => X2, koft => X3);
    M3 : kr_fuzman_Vtminus port map (clock => clock, Vtminusone => Vtminusone, Vref => Vref, koft => X3, Vtminus => X4);
    M4 : kr_fuzman_Vt port map ( clock => clock, Ut => Ut, Vtminus => X4, Vt => Vt);
    M5 : kr_fuzman_omegat port map (clock => clock, koft => X3, Ztcap => X2, omegat => X5);
    M6 : kr_fuzman_Zt port map (clock => clock, koft => X3, Ztminus => X1, omegat => X5, Zt => Zt);
    end struct;
