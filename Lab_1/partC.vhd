library ieee;
use ieee.std_logic_1164.all;

ENTITY partC IS
    PORT (
        A    : IN  std_logic_vector(15 downto 0);
        Cin  : IN  std_logic;
        S0   : IN  std_logic;
        S1   : IN  std_logic;
        F    : OUT std_logic_vector(15 downto 0);
        Cout : OUT std_logic 
	);
END partC;


ARCHITECTURE partCarch OF partC IS
BEGIN
    F <= ('0'  & A(15 downto 1)) WHEN (S1 = '0' AND S0 = '0') ELSE
         (A(0) & A(15 downto 1)) WHEN (S1 = '0' AND S0 = '1') ELSE
         (Cin  & A(15 downto 1)) WHEN (S1 = '1' AND S0 = '0') ELSE
         (A(15) & A(15 downto 1));

    Cout <= A(0);
END partCarch;


-- =====================================================
-- Entity: partC
-- Description: Implements the right shift/rotate operations
-- of a 16-bit ALU. Operations selected by (S1, S0).
--
-- Inputs:
--   A    : 16-bit input operand
--   Cin  : Carry input (used in rotate with carry)
--   S1,S0: 2-bit control signals to select operation
--
-- Outputs:
--   F    : 16-bit result
--   Cout : Bit shifted/rotated out (LSB)
--
-- Operation table:
--   S1 S0 | Operation
--   -----------------------------
--    0  0 | F = Logical Shift Right (MSB filled with 0)
--    0  1 | F = Rotate Right (LSB goes to MSB)
--    1  0 | F = Rotate Right with Carry (Cin enters MSB)
--    1  1 | F = Arithmetic Shift Right (MSB preserved)
-- ======================================================
