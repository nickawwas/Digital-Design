-- Nicholas Kawwas (40124338)
-- COEN 313 Lab UJ-X
-- Basic Or Entity and Architecture

entity or_ent is
port(a,b,c : in bit;
     y: out bit
);
end or_ent;

architecture or_arch of or_ent is
begin
        y <= a or b or c;
end or_arch;
