library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity top_TIMER is 
	port( 
	clk_placuta : in std_logic;
	S: in std_logic;
	M: in std_logic;
	START: in std_logic;
	an1, an2, an3, an4: out std_logic;
	led: out std_logic;
	seg_a,seg_b, seg_c, seg_d, seg_e, seg_f, seg_g: out std_logic
	);
end top_TIMER;

architecture arch_top_TIMER of top_TIMER is

component Debouncer is 
	port( 
	clk: in std_logic;
	semnal_buton: in std_logic;
	rez_debouncer: out std_logic
	);
end component;

component UC is
	port ( 
	clk_placuta: in std_logic;
	S: in std_logic;
	M: in std_logic;
	START: in std_logic;
	final_0000: in std_logic;
	stare : inout std_logic_vector (2 downto 0)
	);
end component;

component top_level_partial is 
	port(
	 clk_placuta : in std_logic;
	stare: in std_logic_vector (2 downto 0);
	S: in std_logic;
	M: in std_logic;
	unit_sec: out std_logic_vector (3 downto 0);
	zeci_sec: out std_logic_vector (3 downto 0);
	unit_min: out std_logic_vector (3 downto 0);
	zeci_min: out std_logic_vector (3 downto 0);
	led: out std_logic;
	final_0000: out std_logic
	);
end component;

component display is
	port ( 
	clk_placuta : in std_logic;
	num1,num2,num3,num4 : in std_logic_vector (3 downto 0);
    an1, an2, an3, an4: out std_logic;
	seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g: out std_logic
	);
end component;


signal unit_sec,zeci_sec,unit_min,zeci_min: std_logic_vector (3 downto 0);
signal S_debouncer,START_debouncer,M_debouncer: std_logic;
signal stare: std_logic_vector (2 downto 0);
signal stare_aux: std_logic;

begin

	debS: Debouncer port map (clk_placuta, S, S_debouncer);
	debP: Debouncer port map (clk_placuta, START, START_debouncer);
	debM: Debouncer port map (clk_placuta, M, M_debouncer);
	UnitControl: UC port map (clk_placuta, S_debouncer, M_debouncer, START_debouncer, stare_aux, stare);
	num_top_level_unire: top_level_partial port map (clk_placuta, stare, S_debouncer, M_debouncer, unit_sec, zeci_sec, unit_min, zeci_min, led, stare_aux);
	afisor: display port map (clk_placuta, unit_sec, zeci_sec, unit_min, zeci_min, an1, an2, an3, an4, seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g);
	
end arch_top_TIMER;