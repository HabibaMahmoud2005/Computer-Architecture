library ieee;
use ieee.std_logic_1164.all;

ENTITY full_adder IS
    PORT (
        A    : IN  std_logic;
        B    : IN  std_logic;
        Cin  : IN  std_logic;
        Sum  : OUT std_logic;
        Cout : OUT std_logic
    );
END full_adder;

ARCHITECTURE full_adder_arch OF full_adder IS
BEGIN
    Sum  <= (A XOR B) XOR Cin;
    Cout <= (A AND B) OR ((A XOR B) AND Cin);
END full_adder_arch;

-- =====================================================
-- Entity: full_adder
-- Description: Implements a 1-bit full adder.
--
-- Inputs:
--   A    : First input bitlibrary ieee;library ieee;
--   B    : Second input bit
--   Cin  : Carry input
--
-- Outputs:
--   Sum  : Sum output (A XOR B XOR Cin)
--   Cout : Carry output (A·B + (A?B)·Cin)
--
-- Truth Table:
--   A  B  Cin | Sum Cout
--   ---------------------
--   0  0   0  |  0   0
--   0  0   1  |  1   0
--   0  1   0  |  1   0
--   0  1   1  |  0   1
--   1  0   0  |  1   0
--   1  0   1  |  0   1
--   1  1   0  |  0   1
--   1  1   1  |  1   1
-- =====================================================

