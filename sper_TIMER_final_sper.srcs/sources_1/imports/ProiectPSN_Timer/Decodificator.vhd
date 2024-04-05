library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity decodaf is 
port(
cifra: in std_logic_vector (3 downto 0); --in binar
selectie: in std_logic_vector (1 downto 0 );
an1, an2, an3, an4: out std_logic;
seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g: out std_logic
);
end decodaf;

architecture arch_decodaf of decodaf is

begin
	
	process (selectie)
	variable selector: std_logic_vector (3 downto 0);
	begin		
		case selectie is
			when "00" => selector := "1110"; 
			when "01" => selector := "1101";
			when "10" => selector := "1011";
			when "11" => selector := "0111";
			when others => selector := "1111";			
		end case; 
		an1	<= selector(0);
		an2	<= selector(1);
		an3	<= selector(2); 
		an4	<= selector(3);

	end process;
	
	process(cifra) 
	variable afis_cifra: std_logic_vector (6 downto 0);
	begin 
		case cifra is
		when "0000" => afis_cifra := "1111110"; --0
		when "0001" => afis_cifra := "0110000"; --1
		when "0010" => afis_cifra := "1101101"; --2
		when "0011" => afis_cifra := "1111001"; --3
		when "0100" => afis_cifra := "0110011"; --4
		when "0101" => afis_cifra := "1011011"; --5
		when "0110" => afis_cifra := "1011111"; --6
		when "0111" => afis_cifra := "1110000"; --7
		when "1000" => afis_cifra := "1111111"; --8
		when "1001" => afis_cifra := "1111011"; --9
		when others => afis_cifra := "0110111"; -- eroare  
		end case;		 
		
		seg_a <= not afis_cifra(6);
		seg_b <= not afis_cifra(5);
		seg_c <= not afis_cifra(4);
		seg_d <= not afis_cifra(3);
		seg_e <= not afis_cifra(2);
		seg_f <= not afis_cifra(1);
		seg_g <= not afis_cifra(0);
		
	end process;
end arch_decodaf;	