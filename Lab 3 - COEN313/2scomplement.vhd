library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity converter is
port( sign_mag : in std_logic_vector(3 downto 0) ;
twos_comp : out std_logic_vector(3 downto 0) );
end;

architecture using_variable of converter is
signal twos_comp_int : std_logic_vector(3 downto 0);
begin

process(sign_mag)
variable magnitude : std_logic_vector(2 downto 0);

begin
if sign_mag(3) = '0' then
	twos_comp_int <= sign_mag;
else
	twos_comp_int <= sign_mag(3) & (not(sign_mag(2 downto 0)) + "001");
end if;
end process;

twos_comp <= twos_comp_int;

end using_variable;


