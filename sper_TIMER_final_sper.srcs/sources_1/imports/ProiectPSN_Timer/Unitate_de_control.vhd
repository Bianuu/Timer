library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity UC is	
port (
clk_placuta: in std_logic;	
S: in std_logic;	
M: in std_logic;	
START: in std_logic;	
final_0000: in std_logic;	
stare : inout std_logic_vector (2 downto 0)
);
end UC;

architecture arch_UC of UC is 
component div_10hzin is
port (
 clk : in std_logic;
selectie: out std_logic
);
end component;

signal clk_aux,increm_y_n,reset: std_logic;
signal stare_urm: std_logic_vector (2 downto 0); 

begin	
    --schimban clock din '0' in '1' din 0.2 sec in 0.2 sec
clk_num_increment: div_10hzin port map (clk_placuta, clk_aux);
		
-- verif daca trebuie sa face incrementare sau nu
increm_y_n <= S or M; 
reset <= S and M;  
	
process (clk_aux,reset)
	variable stare_aux: std_logic_vector(2 downto 0);
	
	begin
	
	--reset este asincron
		if( reset = '1') then
			stare_aux := "000";	
		elsif(rising_edge(clk_aux)) then
				stare_aux := stare_urm;	
		end if;
		
		stare <= stare_aux;
end process;

process(stare, final_0000, increm_y_n, START)
	variable stare_aux_urm: std_logic_vector(2 downto 0);
	
	begin 
	
	case(stare) is 
	--daca ne aflam in reset neconditionat trecem in inactiv
		when "000" => stare_aux_urm := "001";
		when "001" => 
		--daca apasam M sau S facem mod de incrementare
				if(increm_y_n = '1') then  
					stare_aux_urm := "100";	
		--daca apasam butonul "START(care la randu' lui e si STOP) e cronometru
				elsif (START = '1') then 
					stare_aux_urm := "010";			
				else
					stare_aux_urm := "001";
				end if;			
		when "010" => 
		--daca e cronometru si daca apasam M sau S facem mod de incrementare
							 if(increm_y_n = '1') then 
								stare_aux_urm := "100";	

				--daca apasam butonul "START(care la randu' lui e si STOP) trecem in inactiv
							elsif (START = '1') then 
								stare_aux_urm := "001";
							else
								stare_aux_urm := "010";
							end if;		
		when "011" =>   
			--daca ajungem la 00:00,resetam
				if( final_0000 = '1') then 
					stare_aux_urm := "000";		
				--daca il oprim din numarare
				elsif( START = '1' ) then 
					stare_aux_urm := "001";
				else 
					stare_aux_urm := "011";
				end if;	
				
		when "100" => 			
                        if( START = '1') then
					stare_aux_urm := "011";
				else 
					stare_aux_urm := "100";
				end if;
		when others=> 	
				---stare necunoscuta => reset
					stare_aux_urm := "000"; 	
			end case;
		
		stare_urm <= stare_aux_urm;
end process;

end arch_UC;