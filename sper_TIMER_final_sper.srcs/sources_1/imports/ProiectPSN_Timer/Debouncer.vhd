library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Debouncer is 
	port( 
	clk: in std_logic;
	semnal_buton: in std_logic;
	rez_debouncer: out std_logic
	);
end Debouncer;

architecture arch_Debouncer of Debouncer is 

constant debouncer_limit: integer := 250000;
signal counter: integer range 0 to debouncer_limit :=0; 
signal aux_rez_debouncer: std_logic := '0';  --filtrare semnal buton

begin			 
	process(clk)
	begin	
		if (clk = '1' and clk'EVENT) then
			if (counter < debouncer_limit) and (semnal_buton /= aux_rez_debouncer) then
				counter <= counter + 1;
			elsif (counter = debouncer_limit) then
				aux_rez_debouncer <= semnal_buton;	
				counter <= 0;
			else
				counter <= 0;
			end if;
		end if;
	end process;
	rez_debouncer <= aux_rez_debouncer;
end arch_Debouncer;