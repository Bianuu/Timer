library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity div_10hzin is
port ( 
clk : in std_logic;
selectie: out std_logic
);
end div_10hzin;

architecture arch_div_10hzin of div_10hzin is	
  
subtype int is integer range 0 to 10000000;
 
begin 

	process (clk)
	variable stare: std_logic := '0';
    variable clk_divizat : int;
	begin	
		if rising_edge(clk) then
			if clk_divizat = 10000000 then 
				stare := not stare;
				clk_divizat := 0;
			else
				clk_divizat := clk_divizat + 1;
			end if;
		end if;
		
	selectie <= stare;
	end process;
end arch_div_10hzin;