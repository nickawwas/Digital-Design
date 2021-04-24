-- Nicholas Kawwas (40124338)
-- COEN 313 Lab UJ-X
-- Signed Magnitude Converter

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity converter_signals is
port(signed_mag: in std_logic_vector(3 downto 0);
     twos_comp: out std_logic_vector(3 downto 0)
);
end converter_signals;

architecture converter_signals_arch of converter_signals is
signal sign: std_logic;
signal mag: std_logic_vector(3 downto 0);
begin
        process(signed_mag, sign, mag)
        begin
        -- Sign 1 -> 2's Complement (Not, +1)
        if(signed_mag(3)='1') then
                sign <= signed_mag(3);
                mag <= (not signed_mag) + "0001";
                twos_comp <= sign & mag(2 downto 0);
        -- Sign 0 -> Original
        else
                twos_comp <= signed_mag;
        end if;
        end process;
end converter_signals_arch;
-- COEN 313 Lab UJ-X
