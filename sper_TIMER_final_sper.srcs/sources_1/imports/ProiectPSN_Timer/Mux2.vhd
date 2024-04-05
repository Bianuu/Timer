library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX2_1 is 
port( 
I1, I2: in std_logic ;
selectie: in std_logic ;
iesirea_selectata: out std_logic);
end MUX2_1;

architecture arch_MUX2_1 of MUX2_1 is

begin 

iesirea_selectata <= (I1 and not selectie) or (I2 and selectie);
end arch_MUX2_1;

			