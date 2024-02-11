library IEEE;
use IEEE.std_logic_1164.all;
entity m_or is
port(A,B,C : in std_logic ; OUTPUT : out std_logic);
end m_or;

architecture mdk_arch of m_or is
begin
OUTPUT <= A or B or C;
end mdk_arch;
