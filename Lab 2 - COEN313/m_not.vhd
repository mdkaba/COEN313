library IEEE;
use IEEE.std_logic_1164.all;

entity m_not is
port(A : in std_logic ; OUTPUT : out std_logic);
end m_not;

architecture mdk_arch of m_not is
begin
OUTPUT <= (not A);
end mdk_arch;
