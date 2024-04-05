library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity display is
port (
clk_placuta : in std_logic;
num1,num2,num3,num4 : in std_logic_vector (3 downto 0);
an1, an2, an3, an4: out std_logic;
seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g: out std_logic
);
end display;

architecture arch_display of display is	  

component decodaf is 
port(
cifra: in std_logic_vector (3 downto 0);
selectie: in std_logic_vector (1 downto 0 );
an1, an2, an3, an4: out std_logic;
seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g: out std_logic
);
end component;

component div_selaf is
port ( 
clk : in std_logic;
selectie: out std_logic
);
end component;

component numarator_selectii is 
port ( 
clk_placuta: in std_logic;
selecti: out std_logic_vector (1 downto 0)
);
end component;

component MUX_afis is 
port( 
I1, I2, I3, I4: in std_logic_vector (3 downto 0);
selecti: in std_logic_vector (1 downto 0);
numarator_selectat: out std_logic_vector( 3 downto 0)
);
end component;


signal selectii: std_logic_vector (1 downto 0);
signal numar_selectat: std_logic_vector (3 downto 0);
signal clk_selectat: std_logic;

begin 
	
	divse: div_selaf port map (clk_placuta, clk_selectat);
	num_sel: numarator_selectii port map (clk_selectat, selectii); 
	muxA: MUX_afis port map (num1, num2, num3, num4, selectii, numar_selectat);
	decod: decodaf port map (numar_selectat, selectii, an1, an2, an3, an4, seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g);
	
end arch_display;