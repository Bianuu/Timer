library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity num_mod_10 is
port (
clk ,rst,en : in std_logic;
modd : in std_logic;
tcountup : out std_logic;
tcountdown	: out std_logic;
stare_zero: out std_logic;
iesire_numarator: out std_logic_vector (3 downto 0)
);
end num_mod_10;

architecture arch_num_mod_10 of num_mod_10 is		
					
begin			
							
	process(clk, rst, en, modd)
	variable aux_iesire_numarator : std_logic_vector (3 downto 0) := "0000";	  
	begin	  
	    stare_zero<='0';
		tcountdown <= '0';
		tcountup <= '0';  
		if rst = '0' then
			if clk='1' and clk'event then 
				if en = '1' then
					if modd = '1' then 
						if aux_iesire_numarator = "0000" then
							aux_iesire_numarator := "1001";
							tcountdown <= '1';
						else
							aux_iesire_numarator := aux_iesire_numarator - 1;
						end if;
					else
						if aux_iesire_numarator = "1001" then
							aux_iesire_numarator := "0000";
							tcountup <= '1';
						else
							aux_iesire_numarator := aux_iesire_numarator + 1;
						end if;
					end if;
				end if;	 
			end if;
		else
			aux_iesire_numarator := "0000"; 
		end if;	
		
		if aux_iesire_numarator="0000" then stare_zero<='1';
		end if;	
		iesire_numarator <= aux_iesire_numarator;
	end process;
end arch_num_mod_10;