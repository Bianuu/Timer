library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX_afis is 
port( 
I1, I2, I3, I4: in std_logic_vector (3 downto 0);
selecti: in std_logic_vector (1 downto 0);
numarator_selectat: out std_logic_vector( 3 downto 0)
);
end MUX_afis;

architecture arch_MUX_afis of MUX_afis is

begin 

	process(selecti,I1, I2, I3, I4)
	begin
	case selecti is
		    when "00" => numarator_selectat <= I1;
			when "01" => numarator_selectat <= I2;
			when "10" => numarator_selectat <= I3;
		when others => numarator_selectat <= I4;
		end case;
	end process;
end arch_MUX_afis;

			