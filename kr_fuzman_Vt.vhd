library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity kr_fuzman_Vt is
  port
     ( clock : in std_logic;
       Ut : in std_logic_vector(31 downto 0);
       Vtminus : in std_logic_vector(31 downto 0);
       Vt : out std_logic_vector(31 downto 0)
     );
   end kr_fuzman_Vt;
architecture struct of kr_fuzman_Vt is
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
	  signal Z1 : std_logic_vector(31 downto 0);
	  signal M : std_logic_vector(31 downto 0) := "00111101010011001100110011001101";
	  begin
	    M1 : kn_kalman_mult port map (clock => clock, dataa => M, datab => Ut, result => Z1);
	    M2 : kn_kalman_add port map (clock => clock, dataa => Z1, datab => Vtminus, result => Vt);
	      end struct;
