library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity NUM_2 is
	port (clk : in std_logic;
	reset : in std_logic;
	enable : in std_logic;
	mode : in std_logic;
	s_zero : out std_logic;
	tcu : out std_logic;
	tcd	: out std_logic;
	count_out: out std_logic_vector (3 downto 0));
end NUM_2;

architecture a_NUM_2 of NUM_2 is
signal temp : std_logic_vector (3 downto 0) := "0000";
begin			 
	
	s_zero <= not temp(0) and not temp(1) and not temp(2) and not temp(3);
	process(clk, reset)
	variable iesiri : std_logic_vector (3 downto 0) := "0000";
	variable p_tcu: std_logic := '0'; 
	variable p_tcd: std_logic := '0';
	begin
		if(reset = '1') then
			iesiri := "0000";
			p_tcd := '0';
			p_tcu := '0';
		elsif( RISING_EDGE (clk) ) then		
			p_tcu := '0';
			p_tcd := '0';
			if(enable = '1') then
				if(mode = '0') then
					if(iesiri = "0101") then
						iesiri := "0000";
						p_tcu := '1';
					else
						iesiri := iesiri + 1;
					end if;
				else
					if(iesiri = "0000") then
						iesiri := "0101";
						p_tcd := '1';
					else
						iesiri := iesiri - 1;
					end if;
				end if;
			end if;	
		end if;			
		temp <= iesiri;
		count_out <= iesiri;
		tcd <= p_tcd;
		tcu <= p_tcu;
	end process;
end a_NUM_2;