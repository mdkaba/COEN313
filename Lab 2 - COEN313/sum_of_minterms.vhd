library IEEE;
use IEEE.std_logic_1164.all;
entity sum_of_minterms is
port( a,b,c           : in std_logic;
      output          : out std_logic);
end sum_of_minterms;

architecture mdk_arch of sum_of_minterms is

-- declare the components found in our entity

component m_not
port(A : in std_logic ; OUTPUT : out std_logic);
end component;

component m_and 
port(A,B,C : in std_logic ; OUTPUT : out std_logic);
end component;

component m_or 
port(A,B,C : in std_logic ; OUTPUT : out std_logic);
end component;

-- declare signals used to interconnect components

signal s1, s2, s3, s4, s5 : std_logic;


-- declare configuration specification

for U1, U2 : m_not use entity WORK.m_not(mdk_arch);
for U3, U4, U5: m_and use entity WORK.m_and(mdk_arch);
for U6 : m_or use entity WORK.m_or(mdk_arch);

begin

U1 : m_not port map(A => A, OUTPUT => s1 );
U2 : m_not port map(A => B, OUTPUT => s2 );
U3 : m_and port map(A => s1, B => s2, C => C, OUTPUT => s3);
U4 : m_and port map(A => s1, B => B, C => C, OUTPUT => s4);
U5 : m_and port map(A => A, B => B, C => C, OUTPUT => s5);
U6 : m_or port map(A => s3, B => s4, C => s5, OUTPUT => output);

end mdk_arch;
