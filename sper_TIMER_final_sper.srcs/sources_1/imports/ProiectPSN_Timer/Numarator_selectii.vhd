library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity numarator_selectii is 
port (
clk_placuta: in std_logic;
selecti: out std_logic_vector (1 downto 0)
);
end numarator_selectii;

architecture arch_numarator_selectii of numarator_selectii is 

begin 

	process (clk_placuta)
	variable counter: std_logic_vector ( 1 downto 0) := "00";
	begin
	if rising_edge(clk_placuta) then 
		counter := counter+1;
	end if;
	selecti <= counter;
	end process;
end arch_numarator_selectii;
