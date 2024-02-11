library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity twos_complementer is
port (din: in std_logic_vector(7 downto 0);
clk: in std_logic;
reset: in std_logic;

done_out: out std_logic;
counter_out: out std_logic_vector (3 downto 0);
reg_out: out std_logic_vector (7 downto 0)
);
end twos_complementer;

architecture Circuit of twos_complementer is

--define the internal signals
signal ld_done:std_logic;
signal clr_done:std_logic;
signal done: std_logic;
signal clr:std_logic;
signal inc:std_logic;
signal d,shift,load:std_logic;

signal counter:std_logic_vector (3 downto 0);
signal shift_reg:std_logic_vector (7 downto 0);


--define the state type
type state_type is
(load_state,test_bit,first_one,still_zero,test_count0,test_count1,flip_0,flip_1,finish,next_bit);
signal state:state_type;

begin
--“Done Register”
process(clk)
begin

if(clk'event and clk='1') then
if clr_done='1' then done <='0';
end if;
if ld_done='1' then done <='1';
end if;
end if;
end process;

--“Counter Register”
process(clk)
begin
if(clk'event and clk='1') then
if clr='1' then counter<="0000";
end if;
if inc='1' then counter<=std_logic_vector(unsigned(counter)+1);
end if;
end if;
end process;

--“Shift Register”
process (clk)
begin
if (clk'event and clk='1') then
if load='1' then shift_reg<=din;
else
if shift='1' then shift_reg<=D&shift_reg(7 downto 1);
end if;
end if;
end if;
end process;

--Next state logic
process (reset, clk)

begin

if (reset='1') then state<=load_state;
else
if (clk'event and clk='1') then
case state is
when load_state=>
state<=test_bit;

when test_bit=>
if shift_reg(0)='1' then
state<=first_one;
else state<=still_zero;
end if;

when first_one=>
state<=test_count1;

when still_zero=>
state<=test_count0;

when test_count0=>
if counter="1000" then
state<=finish; --It is possible that the din is “00000000”
else state<=test_bit;
end if;

when test_count1=>
if counter="1000" then
state<=finish; --It is possible that the din is “10000000”
else state<=next_bit;
end if;

when next_bit=>
if counter="1000" then
state<=finish;
else
if shift_reg(0)='0' then
state<=flip_0;
else state <=flip_1;
end if;
end if;

when flip_0=>
if counter="1000" then
state<=finish;
else state<=next_bit;
end if;

when flip_1=>
if counter="1000" then
state<=finish;
else state<=next_bit;
end if;

when finish=>
state<=finish;

end case;

end if;
end if;

end process;

--Moore output logic
process(state)
begin
case state is
when load_state=>

d<='0';
shift<='0';
ld_done<='0';
clr_done<='1';
clr<='1';
inc<='0';
load<='1';

when test_bit=>

d<='0';
shift<='0';
ld_done<='0';
clr_done<='0';
clr<='0';
inc<='0';
load<='0';

when first_one=>

d<='1';
shift<='1';
ld_done<='0';
clr_done<='0';
clr<='0';
inc<='1';
load<='0';

when still_zero=>

d<='0';
shift<='1';
ld_done<='0';
clr_done<='0';
clr<='0';
inc<='1';
load<='0';

when test_count0=>

d<='0';
shift<='0';
ld_done<='0';
clr_done<='0';
clr<='0';
inc<='1';
load<='0';

when test_count1=>

d<='0';
shift<='0';
ld_done<='0';
clr_done<='0';
clr<='0';
inc<='0';
load<='0';

when next_bit=>

d<='0';
shift<='0';
ld_done<='0';
clr_done<='0';
clr<='0';
inc<='0';
load<='0';

when flip_0=>

d<='1';
shift<='1';
ld_done<='0';
clr_done<='0';
clr<='0';
inc<='1';
load<='0';

when flip_1=>

d<='0';
shift<='1';
ld_done<='0';
clr_done<='0';
clr<='0';
inc<='1';
load<='0';

when finish=>

d<='0';
shift<='0';
ld_done<='1';
clr_done<='1';
clr<='1';
inc<='0';
load<='0';

end case;
end process;

end Circuit;
