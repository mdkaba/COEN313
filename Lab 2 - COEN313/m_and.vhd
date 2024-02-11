library IEEE;
use IEEE.std_logic_1164.all;
entity m_and is
port(A,B,C : in std_logic ; OUTPUT : out std_logic);
end m_and;

architecture mdk_arch of m_and is
begin
OUTPUT <= A and B and C;
end mdk_arch;

