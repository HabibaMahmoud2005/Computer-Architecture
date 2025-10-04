library ieee;
use ieee.std_logic_1164.all;

ENTITY partB IS 
    GENERIC (
        N : integer := 16
    );
    PORT (
        A  : IN  std_logic_vector(N-1 downto 0);
        B  : IN  std_logic_vector(N-1 downto 0);
        S0 : IN  std_logic;
        S1 : IN  std_logic;
        F  : OUT std_logic_vector(N-1 downto 0)
    );
END partB;

ARCHITECTURE partBarch OF partB IS 
BEGIN
    F <= (A and B) WHEN (S1 = '0' AND S0 = '0') ELSE
         (A or  B) WHEN (S1 = '0' AND S0 = '1') ELSE
         (A xor B) WHEN (S1 = '1' AND S0 = '0') ELSE
         (not A);
END partBarch;

-- =====================================================
-- Entity: partB
-- Description: Implements the logical operations part of 
-- an N-bit ALU (AND, OR, XOR, NOT).
--
-- Generics:
--   N : Bit-width of operands (default = 16)
--
-- Inputs:
--   A, B : N-bit operands
--   S1, S0 : 2-bit select lines
-- Output:
--   F : N-bit result
--
-- Operation table:
--   S1 S0 | Operation
--   -----------------
--    0  0 | F = A AND B
--    0  1 | F = A OR  B
--    1  0 | F = A XOR B
--    1  1 | F = NOT A
-- =====================================================

