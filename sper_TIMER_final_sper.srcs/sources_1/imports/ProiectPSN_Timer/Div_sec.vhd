library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity div_numarator_sec is
port ( 
clk : in std_logic;
reset: in std_logic;
rez_div: out std_logic);
end div_numarator_sec;

architecture arch_div_numarator_sece of div_numarator_sec is	  

subtype int is integer range 0 to 50000000;

begin 

	process (clk, reset)
	 variable clk_divizat : int;
	variable stare: std_logic := '0';
	begin	
		if reset = '1' then 
		  clk_divizat := 0;
		else
			if rising_edge(clk) then
				if clk_divizat = 50000000 then 
					stare := not stare;
					clk_divizat := 0;
				else
					clk_divizat := clk_divizat + 1;
				end if;
			end if;
		end if;
		rez_div <= stare;
	end process;
end arch_div_numarator_sece;