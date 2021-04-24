-- Nicholas Kawwas (40124338)
-- COEN 313 Lab UJ-X
-- Basic And Entity and Architecture

entity and_ent is
port(a,b,c : in bit; 
     y: out bit
);
end and_ent;

architecture and_arch of and_ent is
begin
	y<= a and b and c;
end and_arch;

