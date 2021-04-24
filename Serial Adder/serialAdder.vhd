-- Nicholas Kawwas
-- COEN 313 Project
-- Synchronous Serial Adder from Behavioral Description

library ieee;
use ieee.std_logic_1164.all;

entity serial_adder_ent is 
	port(sin, clk, res, shift: in std_logic;
		cout: out std_logic;
		sum: out std_logic_vector(3 downto 0));
end serial_adder_ent;

architecture serial_adder_arch of serial_adder_ent is
-- Registers A, B
signal regA, regB : std_logic_vector(3 downto 0);
-- Shift Clock, Sum Bit for Register A, Carry Bit from Full Adder, Carry In for DFF
signal shiftClk, sumBit, carryBit, cin: std_logic;
-- Shift Out Ports (Containg LSBs of regA and regB)
signal soutA, soutB : std_logic;
begin
	--Shift Clock
	shiftClk <= clk and shift;

	-- Shift Register (regA, regB)
	process(shiftClk, res) 
	begin 
		-- Asynchronous Reset to 0000
		-- Reset Enabled - Clears All Registers
		if res = '1' then
			regA <= (others => '0');
                	regB <= (others => '0');
		-- Shift Enabled - Shifts Right All Bits of Registers, 1 Bit at a Time
		-- Stores sum into regA MSB and sin into regB MSB
		elsif (shiftClk'event and shiftClk = '1') then
			-- Stores Data A and Data B After 8 Clock Cycles
			for i in 0 to 2 loop
				regA(i) <= regA(i + 1);
				regB(i) <= regB(i + 1);
			end loop;
		
			-- Stores 4 Sum Bits in Register A After 12 Clock Cycles
			regA(3) <= sumBit;
			regB(3) <= sin;
		end if;
	end process;

	-- Shift Out Port A and B Contains LSB from Registers A and B
	process(regA, regB)
	begin
		soutA <= regA(0);
		soutB <= regB(0);
	end process;

	-- 1 Bit Full Adder Logic - Sum Bit and Carry Out Bit
        process(soutA, soutB, cin)
	variable notA, notB, notC : std_logic;
	begin
		notA := not soutA;
		notB := not soutB;
		notC := not cin;
	
		sumBit <= (notA and notB and cin) or (notA and soutB and notC) or (soutA and notB and notC) or (soutA and soutB and cin);
        	carryBit <= (soutA and soutB) or (soutA and cin) or (soutB and cin);
	end process;

        -- D Flip Flop (DFF)
	process(shiftClk, res)
	begin
		-- Asynchronous Reset to 0
        	if(res = '1') then
                	cin <= '0';
		-- Update Carry Output with Most Recent Carry
        	elsif(shiftClk'event and shiftClk = '1') then
                	cin <= carryBit;
        	end if;
	end process;

	-- Output Logic
	sum <= regA;
	cout <= cin;
end serial_adder_arch;
