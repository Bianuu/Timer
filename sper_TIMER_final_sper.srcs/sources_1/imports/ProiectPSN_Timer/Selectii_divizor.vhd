library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity div_selaf is
port ( 
clk : in std_logic;
selectie: out std_logic
);
end div_selaf;
 
architecture arch_div_selaf of div_selaf is	  

subtype int is integer range 0 to 200000;

begin 

	process (clk)
	variable stare: std_logic := '0';
	--0.2MHz is 200000Hz
    variable clk_divizat : int;
	begin	
		if rising_edge(clk) then
			if clk_divizat = 200000 then 
				stare := not stare;
				clk_divizat := 0;
			else
				clk_divizat := clk_divizat + 1;
			end if;
		end if;
		
	selectie <= stare;
	end process;
end arch_div_selaf;