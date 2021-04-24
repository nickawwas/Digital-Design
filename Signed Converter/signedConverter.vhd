-- Nicholas Kawwas (40124338)
-- COEN 313 Lab UJ-X
-- Signed Magnitude Converter

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity converter is
port(signed_mag: in std_logic_vector(3 downto 0);
     twos_comp: out std_logic_vector(3 downto 0) 
);
end converter;

architecture converter_arch of converter is
signal sign: std_logic; 
signal mag: std_logic_vector(2 downto 0);
begin
	sign <= signed_mag(3);
	mag <= signed_mag(2 downto 0);

	process(sign, mag)
	variable not_mag, sig_mag: std_logic_vector(2 downto 0);
	begin
	
	-- Sign 1 -> 2's Complement (Not, +1)
	if(sign='1') then
		not_mag := not mag;
		sig_mag := not_mag + "001";
		--sig_mag <= std_logic_vector(unsigned(not_mag) + '1');
		twos_comp <= sign & sig_mag(2 downto 0);
	-- Sign 0 -> Original
	else
		twos_comp <= sign & mag;
	end if;
	end process;
end converter_arch;



