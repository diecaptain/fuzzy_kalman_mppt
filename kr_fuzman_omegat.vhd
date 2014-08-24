library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity kr_fuzman_omegat is
  port 
    ( clock : in std_logic;
      koft : in std_logic_vector (31 downto 0);
      Ztcap : in std_logic_vector (31 downto 0);
      omegat : out std_logic_vector (31 downto 0)
    );
  end kr_fuzman_omegat;
architecture struct of kr_fuzman_omegat is
  component kn_kalman_mult IS
	 PORT
	  ( clock		: IN STD_LOGIC ;
		  dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	  );
	  end component;
	  signal Z1 : std_logic_vector(31 downto 0);
	  begin
	    M1 : kn_kalman_mult port map (clock => clock, dataa => koft, datab => koft, result => Z1);
	    M2 : kn_kalman_mult port map (clock => clock, dataa => Z1, datab => Ztcap, result => omegat);
	      end struct;
