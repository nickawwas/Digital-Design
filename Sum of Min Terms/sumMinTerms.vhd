-- Nicholas Kawwas (40124338)
-- COEN 313 Lab UJ-X
-- Sum of Min Terms Circuit Using CSA Only

entity somt_ent is
port(a,b,c : in bit; 
     y: out bit
);
end somt_ent;

architecture somt_arch of somt_ent is
signal ap, bp : bit;
begin
	ap <= not a;
	bp <= not b;
	y <= (ap and bp and c) or (ap and b and c) or (a and b and c);
end somt_arch;