library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity kr_fuzman_Ztminus is
  port 
    ( clock : in std_logic;
      Ztminusone: in std_logic_vector (31 downto 0);
      Ztminus : out std_logic_vector (31 downto 0)
      );
    end kr_fuzman_Ztminus;
architecture struct of kr_fuzman_Ztminus is
 component kn_kalman_add is
	 PORT
	  ( clock		: IN STD_LOGIC ;
		  dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	  );
	  end component;
	  signal Q : std_logic_vector(31 downto 0) := "00111100001000111101011100001010";
	  begin
	  M1 : kn_kalman_add port map ( clock => clock, dataa => Ztminusone, datab => Q, result => Ztminus);
	  end struct;
	  
	
