library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity kr_fuzman_Vtminus is
  port
    ( clock : in std_logic;
      Vtminusone : in std_logic_vector (31 downto 0);
      Vref : in std_logic_vector (31 downto 0);
      koft : in std_logic_vector (31 downto 0);
      Vtminus : out std_logic_vector (31 downto 0)
    );
  end kr_fuzman_Vtminus;
architecture struct of kr_fuzman_Vtminus is
  component kn_kalman_add IS
	 PORT
	  ( clock		: IN STD_LOGIC ;
		  dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	  );
	  end component;
	 component kn_kalman_mult IS
	 PORT
	  ( clock		: IN STD_LOGIC ;
		  dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	  );
	  end component;
	  component kn_kalman_sub IS
	 PORT
	  ( clock		: IN STD_LOGIC ;
		  dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	  );
	  end component;
    signal Z1,Z2 : std_logic_vector (31 downto 0);
  begin
  M1 : kn_kalman_sub port map (clock => clock, dataa => Vref, datab => Vtminusone, result => Z1);
  M2 : kn_kalman_mult port map (clock => clock, dataa => koft, datab => Z1, result => Z2);
  M3 : kn_kalman_add port map (clock => clock, dataa => Z2, datab => Vtminusone, result => Vtminus);
  end struct;