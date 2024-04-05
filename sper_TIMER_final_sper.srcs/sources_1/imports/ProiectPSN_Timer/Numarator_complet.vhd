library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity top_level_partial is
port( 
clk_placuta : in std_logic;
stare: in std_logic_vector (2 downto 0); 
S: in std_logic;	
M: in std_logic;	
--iesiri numaratoare
unit_sec: out std_logic_vector (3 downto 0);
zeci_sec: out std_logic_vector (3 downto 0);
unit_min: out std_logic_vector (3 downto 0);
zeci_min: out std_logic_vector (3 downto 0); 
led: out std_logic;
final_0000: out std_logic
);
end top_level_partial;

architecture arch_top_level_partial of top_level_partial is

component num_mod_10 is
port (
clk,rst,en : in std_logic;
modd : in std_logic;
tcountup : out std_logic;
tcountdown	: out std_logic;
stare_zero: out std_logic;
iesire_numarator: out std_logic_vector (3 downto 0)
);
end component;

component num_mod_6 is
port (
clk,rst,en : in std_logic;
modd : in std_logic;
tcountup : out std_logic;
tcountdown	: out std_logic;
stare_zero: out std_logic;
iesire_numarator: out std_logic_vector (3 downto 0)
);
end component;

component div_numarator_sec is
port ( 
clk : in std_logic;
reset: in std_logic;
rez_div: out std_logic
);
end component;

component MUX2_1 is 
port(
I1, I2: in std_logic ;
selectie: in std_logic ;
iesirea_selectata: out std_logic
);
end component;

component div_10hzin is
port (
clk : in std_logic;
selectie: out std_logic
);
end component;

signal clk_unit_sec,clk_zeci_sec,clk_unit_min,clk_zeci_min,mod_cresc_descresc,rst: std_logic;
signal en_clk_1min,en_clk_1sec: std_logic;
signal clk_selectii: std_logic;
signal clk_5: std_logic; -- semnal cu care vom rula impulsurile de clock ale num
signal unit_sec_outnum,zeci_sec_outnum,unit_min_outnum,zeci_min_outnum: std_logic_vector (3 downto 0);

--semnale de en pentru num  sec respectiv min
signal enable_sec,enable_min: std_logic := '1';
signal tcountdown_num1,tcountdown_num2,tcountdown_num3,tcountdown_num4: std_logic;
signal tcountup_num1,tcountup_num2,tcountup_num3,tcountup_num4: std_logic;
signal selclk_num1,selclk_num3: std_logic;

--semnale ce ne vor spune daca am ajuns la 00:00
signal zero_afis1,zero_afis2,zero_afis3,zero_afis4: std_logic;

begin

process(stare, M, S)   
	begin	
	case(stare) is
		when "011" => 
			selclk_num1 <= '0';
			selclk_num3 <= '0';
		when others => 	  
			selclk_num1 <= S;
			selclk_num3 <= M;  
		end case;
	end process;

enable_sec <= stare(1) or S; 
enable_min <= stare(1) or S or M;

--starea '000' reset la tot
rst <= not stare(2) and not stare(1) and not stare(0);
mod_cresc_descresc <= stare(1) and stare(0); 
--modul este dat de ultimi 2 biti ai variabilei de stare,'0' pentru count up '1' pentru count down

	div_unit_sec_primu_num: div_numarator_sec port map (clk_placuta, '0', clk_unit_sec);
	--genereaza clock-ul cu care vom increment (5/sec)
	div_increment_min_sec: div_10hzin port map (clk_placuta, clk_5); 
	
	tcounter_zecisec_urmclk: MUX2_1 port map ( tcountup_num1, tcountdown_num1, mod_cresc_descresc, clk_zeci_sec); 
	tcounter_unitmin_urmclk: MUX2_1 port map ( tcountup_num2, tcountdown_num2, mod_cresc_descresc, en_clk_1min);
	tcounter_zecimin_urmclk: MUX2_1 port map ( tcountup_num3, tcountdown_num3, mod_cresc_descresc, clk_zeci_min); 
	
	sel_clk_sec_mux1: MUX2_1 port map (clk_unit_sec, clk_5, selclk_num1, en_clk_1sec); --selectia pentru clock-ul secundelor 																						
	num1: num_mod_10 port map (clk_unit_sec, rst, enable_sec, mod_cresc_descresc, tcountup_num1, tcountdown_num1,zero_afis1, unit_sec_outnum);
	num2: num_mod_6 port map (clk_zeci_sec, rst, enable_sec, mod_cresc_descresc,tcountup_num2, tcountdown_num2,zero_afis2, zeci_sec_outnum);
	
	
	sel_clk_min_mux2: MUX2_1 port map (en_clk_1min, clk_5, selclk_num3, clk_unit_min);--selectia pentru clock-ul minutelor 																					 
	num3: num_mod_10 port map (clk_unit_min, rst, enable_min, mod_cresc_descresc, tcountup_num3, tcountdown_num3,zero_afis3, unit_min_outnum);
	num4: num_mod_10 port map (clk_zeci_min, rst, enable_min, mod_cresc_descresc, tcountup_num4, tcountdown_num4, zero_afis4, zeci_min_outnum);	
	
	--ledul trebuie sa se aprinda daca suntem in count down si am ajuns la 00:00
	led <= zero_afis1 and zero_afis2 and zero_afis3 and zero_afis4 and not stare(2) and stare(1) and stare(0);
	
	final_0000<= tcountdown_num1 and tcountdown_num2 and tcountdown_num3 and tcountdown_num4; 
	
	unit_sec <= unit_sec_outnum;
	zeci_sec <= zeci_sec_outnum;
	unit_min <= unit_min_outnum;
	zeci_min <= zeci_min_outnum;

	
end arch_top_level_partial;

