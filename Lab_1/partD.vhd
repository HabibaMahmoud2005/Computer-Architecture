library ieee;
use ieee.std_logic_1164.all;

ENTITY partD IS
    PORT (
        A    : IN  std_logic_vector(15 downto 0);
        Cin  : IN  std_logic;
        S0   : IN  std_logic;
        S1   : IN  std_logic;
        F    : OUT std_logic_vector(15 downto 0);
        Cout : OUT std_logic
    );
END partD;


ARCHITECTURE partDarch OF partD IS
BEGIN
    F <= (A(14 downto 0) & '0')         WHEN (S1 = '0' AND S0 = '0') ELSE
         (A(14 downto 0) & A(15))       WHEN (S1 = '0' AND S0 = '1') ELSE
         (A(14 downto 0) & Cin)         WHEN (S1 = '1' AND S0 = '0') ELSE
         (others => '0');

    Cout <= A(15) WHEN NOT (S1='1' AND S0='1') ELSE '0';
END partDarch;


-- =====================================================
-- Entity: partD
-- Description: Implements the left shift/rotate operations
-- of a 16-bit ALU. Operations selected by (S1, S0).
--
-- Inputs:
--   A    : 16-bit input operand
--   Cin  : Carry input (used in rotate with carry)
--   S1,S0: 2-bit control signals
--
-- Outputs:
--   F    : 16-bit result
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
