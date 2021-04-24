-- Nicholas Kawwas (40124338)
-- COEN 313 Lab UJ-X
-- Basic Not Entity and Architecture

entity not_ent is
port(a : in bit; 
     y: out bit
);
end not_ent;

architecture not_arch of not_ent is
begin
	y <= not a;
end not_arch;

