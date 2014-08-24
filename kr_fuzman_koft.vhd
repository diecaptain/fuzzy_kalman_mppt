library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity kr_fuzman_koft is
  port 
   ( clock : in std_logic;
     Ztminus : in std_logic_vector (31 downto 0);
     Ztcap : out std_logic_vector (31 downto 0);
     koft : out std_logic_vector (31 downto 0)
   );
 end kr_fuzman_koft;
 architecture struct of kr_fuzman_koft is
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
	  component kn_kalman_inv IS
	PORT
	( clock		: IN STD_LOGIC ;
		data		 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	signal Z1,Z2 : std_logic_vector(31 downto 0);
	signal I : std_logic_vector(31 downto 0) := "00111111100000000000000000000000"; 
	begin
	  M1 : kn_kalman_add port map (clock => clock, dataa => Ztminus, datab => I, result => Z1);
	  M2 : kn_kalman_inv port map (clock => clock, data => Z1, result => Z2);
	  M3 : kn_kalman_mult port map (clock => clock, dataa => Ztminus, datab => Z2, result => koft);
	    Ztcap <= Z1;
	  end struct;  
