library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity registers_min_max is
port( din: in std_logic_vector(3 downto 0);
reset : in std_logic;
clk: in std_logic;
sel: in std_logic_vector(1 downto 0);
max_out : out std_logic_vector(3 downto 0);
min_out : out std_logic_vector(3 downto 0);
reg_out : out std_logic_vector(3 downto 0));
end registers_min_max ;

architecture lab4 of registers_min_max is

signal R0, R1, R2, R3: std_logic_vector(3 downto 0);
signal upr0, upr1, upr2, upr3: std_logic_vector(3 downto 0);
signal mintmp, maxtmp, MAX_REG, MIN_REG, maxup, minup: std_logic_vector(3 downto 0);

begin
process(clk, reset)
begin
if (reset='1')then
	R0<="1000";
	R1<="1000";
	R2<="1000";
	R3<="1000";

elsif(clk'event and clk='1') then
	R0<= upr0;
	R1<= upr1;
	R2<= upr2;
	R3<= upr3;
end if;
end process;

upr0 <= din;
upr1 <= R0;
upr2 <= R1;
upr3 <= R2;

reg_out<=R0 when sel="00" else
	 R1 when sel="01" else
	 R2 when sel="10" else
	 R3 ;

process (clk, reset)
begin
if (reset='1') then
	max_reg <= "0000";
	min_reg <= "1111";

elsif (clk'event and clk='1') then
	MAX_REG <= maxup;
	MIN_REG <= minup;

end if;
end process;

process (R0,R1,R2,R3)

begin
if ((R0<=R1) and (R0<=R2) and (R0<=R3)) then
mintmp<=R0;
elsif ((R1<=R0) and (R1<=R2) and (R1<=R3)) then
mintmp<=R1;
elsif ((R2<=R1) and (R2<=R0) and (R2<=R3)) then
mintmp<=R2;
else mintmp<=R3;
end if;

if ((R0>=R1) and (R0>=R2) and (R0>=R3)) then
maxtmp<=R0;
elsif ((R1>=R0) and (R1>=R2) and (R1>=R3)) then
maxtmp<=R1;
elsif ((R2>=R1) and (R2>=R0) and (R2>=R3)) then
maxtmp<=R2;
else maxtmp<=R3;
end if;
end process;

minup <= mintmp when (mintmp <= MIN_REG) else
MIN_REG;
maxup <= maxtmp when (maxtmp <= MAX_REG) else
MAX_REG;
max_out <= MAX_REG;
min_out <= MIN_REG;

end lab4;
