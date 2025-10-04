library ieee;
use ieee.std_logic_1164.all;

ENTITY partD IS
    GENERIC (
        N : integer := 16
    );
    PORT (
        A    : IN  std_logic_vector(N-1 downto 0);
        Cin  : IN  std_logic;
        S0   : IN  std_logic;
        S1   : IN  std_logic;
        F    : OUT std_logic_vector(N-1 downto 0);
        Cout : OUT std_logic
    );
END partD;

ARCHITECTURE partDarch OF partD IS
BEGIN
    F <= (A(N-2 downto 0) & '0')   WHEN (S1 = '0' AND S0 = '0') ELSE
         (A(N-2 downto 0) & A(N-1)) WHEN (S1 = '0' AND S0 = '1') ELSE
         (A(N-2 downto 0) & Cin)   WHEN (S1 = '1' AND S0 = '0') ELSE
         (others => '0');

    Cout <= A(N-1) WHEN NOT (S1 = '1' AND S0 = '1') ELSE '0';
END partDarch;

-- =====================================================
-- Entity: partD
-- Description: Implements the left shift/rotate operations
-- of an N-bit ALU. Operations selected by (S1, S0).
--
-- Generics:
--   N : Bit-width of operand (default = 16)
--
-- Inputs:
--   A    : N-bit input operand
--   Cin  : Carry input (used in rotate with carry)
--   S1,S0: 2-bit control signals
--
-- Outputs:
--   F    : N-bit result
--   Cout : Bit shifted/rotated out (MSB)
--
-- Operation table:
--   S1 S0 | Operation
--   -------------------------------
--    0  0 | F = Logical Shift Left  (LSB filled with 0)
--    0  1 | F = Rotate Left         (MSB goes to LSB)
--    1  0 | F = Rotate Left w/Carry (Cin enters LSB)
--    1  1 | F = 0000...0000 (all zeros)
-- =====================================================

