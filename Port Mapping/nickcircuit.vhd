-- Nicholas Kawwas (40124338)
-- COEN 313 Lab UJ-X
-- Build Circuit using Components and Port Mapping

entity nickcircuit is
port(a, b, c: in bit;
      y : out bit);
end nickcircuit;

architecture nick_arch of nickcircuit is
-- Declare And and Or Components
component and3
port(a, b, c: in bit; y: out bit);
end component;

component or3
port(a, b, c : in bit; y: out bit);
end component;

component not1
port(a: in bit; y: out bit);
end component; 

-- Declare Signals to Interconnect Components (Wires)
signal ap, bp : bit;
signal s1, s2, s3 : bit;

-- Declare Configuration to Specific Entity
for U00, U01 : not1 use entity WORK.not_ent(not_arch);
for U10, U11, U12 : and3 use entity WORK.and_ent(and_arch);
for U20 : or3 use entity WORK.or_ent(or_arch);

begin
-- Map Ports to Values
U00 : not1 port map(a, ap);
U01 : not1 port map(b, bp);

U10 : and3 port map(ap, bp, c, s1);
U11 : and3 port map(ap, b, c, s2); 
U12 : and3 port map(a, b, c, s3); 
U20 : or3 port map(s1, s2, s3, y);

end nick_arch;

