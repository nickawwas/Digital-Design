-- VHDL Basics Overview
-- + Sample Problems 

-- Import Library
library ieee;
use ieee.std_logic_1164.all;

-- Sample Entity 
entity entName is
    port(
        inP : in std_logic_vector(3 downto 0);
        outP : out std_logic
    );
end entName;

-- Sample Architecture
architecture archName of entName is
    signal sig : std_logic;
    begin
    --code here
end archName;

-- Conditional Statement
y <= a - b when a > b else
    a - c when a > c else
    a + 1;

-- Select Statement
with tmp select 
    y <= a - b when "11" | "10",
        a - c when "01",
        a + 1 when others;

-- If Statement
if ctrl = '1' then
    y <= c;
elsif a > b then
    y <= a - b;
else
    y <= others => '0';
end if;

-- Case Statement
case tmp is 
    when "11" | "10" is 
        y <= a - b;
    when "01" is
        y <= a - c;
    when others
        y <= a + 1;
end case;

-- Process Block
process(s)
    begin   
    -- code here
end process;

-- For Loop
for i in 7 downto 0 Loop
    y(i) <= a(i) or b(i);
end loop;

-- ALU Implementation Using Select Statement
entity alu_enty is
    port ( 
        a, b: in std_logic_vector(7 downto 0);
        cin: in std_logic;
        opcode: in std_logic_vector(3 downto 0);
        y: out std_logic_vector(7 downto 0)
    );
end alu_enty;

architecture alu of alu_enty is 
    signal outlogic, outarith : std_logic_vector(7 downto 0);
begin
    -- Logical Unit
    with opcode select
        outlogic <= not a when "0000" else
                    not b when "0001" else
                    a AND b when "0010" else
                    a OR b when "0011" else
                    a NAND b when "0100" else
                    a NOR b when "0110" else
                    a XNOR b when others;

    --Arithmetic Unit
    with opcode select
        outarith <= a when "1000" else
                    b when "1001" else
                    std_logic_vector(signed(a) + 1) when "1010" else
                    std_logic_vector(signed(b) + 1) when "1011" else
                    std_logic_vector(signed(a) - 1) when "1100" else
                    std_logic_vector(signed(b) - 1) NAND b when "1101" else
                    std_logic_vector(signed(a) + signed(b)) when "1110" else
                    std_logic_vector(signed(a) + signed(b) + signed(cin)) when others;

    --Mux
    with opcode(3) select
        y <= outarith when "1" else
             outlogic when others;
end alu;

-- Unsigned Greater Implemenation - Comparing A with B
entity ugt_enty is
port( 
    a,b: in std_logic_vector(7 downto 0);
    agtb: out std_logic
);
end ugt_enty;

architecture ugt of ugt_enty is
begin
    -- Compare Bit by Bit Values Until Not Equal
    agtb <= a(7) when (a(7) /= b(7)) else
            a(6) when (a(6) /= b(6)) else
            a(5) when (a(5) /= b(5)) else
            a(4) when (a(4) /= b(4)) else
            a(3) when (a(3) /= b(3)) else
            a(2) when (a(2) /= b(2)) else
            a(1) when (a(1) /= b(1)) else
            a(0) when (a(0) /= b(0)) else
            '0';
end ugt;

-- Signed Greater Implemenation - Comparing A with B
entity sgt_enty is
    port( 
        a,b: in std_logic_vector(7 downto 0);
        agtb: out std_logic
    );
    end sgt_enty;
    
architecture sgt of sgt_enty is
    signal sgt_mag, sgt_sign: std_logic;
begin
    -- Compare Signed Bit
    sgt_sign <= '1' when a(7)='0' and b(7)='1' else '0';
    
    -- Compare Bit by Bit Values Until Not Equal
    sgt_mag <= a(7) when (a(7) /= b(7)) else
                a(6) when (a(6) /= b(6)) else
                a(5) when (a(5) /= b(5)) else
                a(4) when (a(4) /= b(4)) else
                a(3) when (a(3) /= b(3)) else
                a(2) when (a(2) /= b(2)) else
                a(1) when (a(1) /= b(1)) else
                a(0) when (a(0) /= b(0)) else
                '0';

    -- Output Magnitude If Signed Bits Are Equal Else Signed Comparison Bit
    agtb <= sgt_mag when (a(7) = b(7)) else sgt_sign;
end sgt;

-- D Latch
process(c, d)
begin 
    if(c='1') then
        q <= d;
    end if;
end process;

-- Synchronous D FF
process(clk)
begin 
    if(clk'event and clk='1') then
        q <= d;
    end if;
end process;

-- Asynchronous D FF
process(clk, res)
begin 
    if(res = '1') then
        q <= '0';
    elsif(clk'event and clk='1') then
        q <= d;
    end if;
end process;

-- SR Latch
process(s, r)
begin 
    if(s='0' and r='1') then
        c <= '1'; 
        d <= '0';
    elsif(s='1' and r='0') then    
        c <= '1'; 
        d <= '1';
    else  
        c <= '0'; 
        d <= '1';
    end if;
end process;


-- Tristate Gate
-- Remember: Cannot Use/Manipulate 'Z' As Input, Cannot be Synthesized
-- Remember: Cannot Use '-' Since Inferred As Grounded, Output Will be 0, Cannot be Synthesized
entity tristate_enty is
    port(
        a: in std_logic_vector(3 downto 0);
        en: in std_logic;
        y: out std_logic_vector(3 downto 0)
    );
end tristate_enty;

architecture tristate of tristate_enty is
begin
    y <= a when en='1' else "ZZZZ";
end tristate; 

-- Johnson Counter
entity johnson_enty is
port(clk, res: in std_logic;
    q: out std_logic_vector(3 downto 0)
);
end johnson_enty;

architecture johnson of johnson_enty is
    signal r_reg, r_next: std_logic_vector(3 downto 0);
begin
    -- Async Register
    process (clk, res) 
    begin
        if (res='1') then
            r_reg <= (others => '0');
        elsif (clk'event and clk='1') then 
            r_reg <= r_next;
        end if; 
    end process;

    -- Next State Logic
    -- Force "1000" to Self Correct
    r_next <= "1000" when r_reg(3)='0' and r_reg(0)='0' else 
            not r_reg(0) & r_reg(3 downto 1);
   
    -- Output Logic
    q <= r_reg ;
end johnson;

-- Calculator Solution
entity calc_16_bit is 
port(
    op0, op1: in std_logic_vector(15 downto 0);
    mode: in std_logic_vector(3 downto 0);
    res: out std_logic_vector(15 downto 0)
);
end calc_16_bit;

architecture calc_arch of calc_16_bit is 
begin
    if mode = "1111" then
        res <= op0 + 1;
    elsif mode = "1110" then
        res <= op1 + 1;
    elsif mode = "1101" then
        res <= op0 NOR op1;
    elsif mode = "1100" then
        res <= op0 XOR op1;
    elsif mode = "1011" then
        res <= op0 sll to_integer(unsigned(op1(15 downto 12)));
    elsif mode = "1010" then
        res <= op0 srl to_integer(unsigned(op1(15 downto 12)));
    elsif mode = "1001" then
        res <= op0 - op1;
    elsif mode = "1000" then
       res <= op0 + op1;
    else
        res <= others => '0';
    end if;
end calc_arch;

-- Full Adder Implementation
entity fullAdderEnty is
    port(
        a, b: in std_logic_vector(15 downto 0);
        sum : out std_logic_vector(15 downto 0)
    );
end fullAdderEnty;

architecture fullAdder of fullAdderEnty is
    -- Carry and Half Adder Signals
    signal c, ha : std_logic;
begin
    for i in (15 downto 0) loop
        ha <= a(i) xor b(i);
        sum(i) <= ha xor c;
        c <= a(i) and b(i) or ha and c;
    end loop;
end fullAdder;

-- Precise Laser Using Moore State Machine
library ieee;
use ieee.std_logic_1164.all;

entity laser_enty is
    port(
        b: in std_logic
        x : out std_logic
    );
end laser_enty;

architecture precise_laser of laser_enty is
    type states is (OFF, ON1, ON2, ON3, ON4, ON5, ON6);
    signal r_reg, r_next : states;
begin
    -- D FF
    process(clk) 
    begin
        if clk'event and clk = '1' then
            r_reg <= r_next;
        end if;
    end process;

    -- Moore - Next State Logic
    process(r_reg)
    begin
        -- Default State
        r_next <= OFF;
        
        case r_reg is 
            when OFF is
                if b = '1' then
                    r_next <= ON1;
                end if;
            when ON1 is
                r_next <= ON2;
            when ON2 is 
                r_next <= ON2;
            when ON3 is 
                r_next <= ON4;
            when ON4 is
                r_next <= ON5;
            when ON5 is
                r_next <= ON6;            
            when ON6 is
                r_next <= OFF;
        end case;
    end process;

    -- Output Logic
    x <= '0' when r_reg = OFF else '1';
end precise_laser;
