-- Nicholas Kawwas (40124338)
-- COEN 313 UJ-X Lab 4
-- Shift Register w/ Min-Max Logic 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity registers_min_max is
port (  din : in std_logic_vector(3 downto 0);
 	clk, res: in std_logic;
 	sel : in std_logic_vector(1 downto 0);
	max_out, min_out, reg_out : out std_logic_vector(3 downto 0)
     );
end registers_min_max ;


architecture registers_min_max_arch of registers_min_max is 
-- Constant Num of Registers for Expandable Code
constant NUM_REG : integer := 4;

-- Registers R0-3
type registers is array(0 to (NUM_REG - 1)) of std_logic_vector(3 downto 0);
signal reg : registers;

-- Max, Min, and Mux Values
signal maxR, minR, maxS, minS : std_logic_vector(3 downto 0);
begin
-- State Register (R0 - R3)
process(clk, res) 
begin 
	-- Asynchronous Reset to 1000
	if res = '1' then
		for i in 0 to (NUM_REG - 1) loop
			reg(i) <= "1000";
		end loop;
	--Store din into R0 and Old Contents of R(i-1) into Ri
	elsif (clk'event and clk = '1') then
		reg(0) <= din;
		for i in 1 to (NUM_REG - 1) loop
			reg(i) <= reg(i - 1);
		end loop;
	end if;
end process;

-- 4-1 Multiplexer (MUX)
with sel select	
	reg_out <= reg(0) when "11",
		   reg(1) when "10",
		   reg(2) when "01",
		   reg(3) when others;

-- Max/Min Combinational Logic
-- Determine Max and Min
process(reg)
variable min, max : std_logic_vector(3 downto 0);
begin
	min := "1111";
	max := "0000";
	for i in 0 to (NUM_REG - 1) loop
		-- Update Min Temp
		if(min > reg(i)) then
			min := reg(i);
		end if;
		-- Update Max Temp
		if(max < reg(i)) then
			max := reg(i);
		end if;
	end loop;

	-- Update Min and Max Signals
	maxS <= max;
	minS <= min;
end process;

-- Max Logic
process(clk, res)  
begin
        -- Asynchronous Reset to 0000
        if res = '1' then
        	maxR <= "0000";
        -- Compare Current Max with max, Update if New Larger Max
	elsif (clk'event and clk = '1') then
		if( maxS > maxR) then
			maxR <= maxS;
		end if;
        end if;
end process;

-- Min Logic
process(clk, res)  
begin
        -- Asynchronous Reset to 1111
        if res = '1' then
        	minR <= "1111";
	--Compare Current Min with min, Update if New Smaller Min
        elsif (clk'event and clk = '1') then
		if(minS < minR) then
			minR <= minS;
		end if;
	end if;
end process;

-- Output Logic
min_out <= minR;
max_out <= maxR;

end registers_min_max_arch;
