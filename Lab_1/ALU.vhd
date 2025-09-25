library ieee;
use ieee.std_logic_1164.all;


ENTITY ALU IS
    PORT (
        A    : IN  std_logic_vector(15 downto 0);
        B    : IN  std_logic_vector(15 downto 0);
        S    : IN  std_logic_vector(3 downto 0);  -- S3 S2 S1 S0
        Cin  : IN  std_logic;
        F    : OUT std_logic_vector(15 downto 0);
        Cout : OUT std_logic
    );
END ALU;

ARCHITECTURE ALUarch OF ALU IS
    SIGNAL F_B, F_C, F_D : std_logic_vector (15 downto 0);
    SIGNAL Cout_C, Cout_D : std_logic;

    COMPONENT partB IS
        PORT (
            A  : IN  std_logic_vector(15 downto 0);
            B  : IN  std_logic_vector(15 downto 0);
            S0 : IN  std_logic;
            S1 : IN  std_logic;
            F  : OUT std_logic_vector(15 downto 0)
        );
    END COMPONENT;

    COMPONENT partC IS
        PORT (
            A    : IN  std_logic_vector(15 downto 0);
            Cin  : IN  std_logic;
            S0   : IN  std_logic;
            S1   : IN  std_logic;
            F    : OUT std_logic_vector(15 downto 0);
            Cout : OUT std_logic 
        );
    END COMPONENT;

    COMPONENT partD IS
        PORT (
            A    : IN  std_logic_vector(15 downto 0);
            Cin  : IN  std_logic;
            S0   : IN  std_logic;
            S1   : IN  std_logic;
            F    : OUT std_logic_vector(15 downto 0);
            Cout : OUT std_logic
        );
    END COMPONENT;

BEGIN
    u0: partB PORT MAP (A, B, S(0), S(1), F_B);
    u1: partC PORT MAP (A, Cin, S(0), S(1), F_C, Cout_C);
    u2: partD PORT MAP (A, Cin, S(0), S(1), F_D, Cout_D);

    F <= F_B WHEN (S(3) = '0' AND S(2) = '1') ELSE
         F_C WHEN (S(3) = '1' AND S(2) = '0') ELSE
         F_D WHEN (S(3) = '1' AND S(2) = '1') ELSE
         (others => '0');  -- Default case , Waiting for part A implementaion

    Cout <= Cout_C WHEN (S(3) = '1' AND S(2) = '0') ELSE
            Cout_D WHEN (S(3) = '1' AND S(2) = '1') ELSE
            '0';            -- Default case , Waiting for part A implementaion

END ALUarch;


-- =====================================================
-- Entity: ALU
-- Description: Top-level 16-bit ALU integrating partB,
-- partC, and partD using structural VHDL.
--
-- Inputs:
--   A, B  : 16-bit operands
--   S     : 4-bit select signal (S3 S2 S1 S0)
--           - S3 S2 choose which submodule (B, C, D)
--           - S1 S0 choose the operation inside that submodule
--   Cin   : Carry input (used in rotate with carry ops)
--
-- Outputs:
--   F     : 16-bit result of selected operation
--   Cout  : Carry/shifted-out bit (used in shift/rotate ops)
--
-- Operation Selection (S3 S2):
--   S3 S2 | Selected Module
--   ------------------------
--    0  1 | partB (logic ops: AND, OR, XOR, NOT)
--    1  0 | partC (right shifts/rotates)
--    1  1 | partD (left shifts/rotates)
--    0  0 | Default ? F=0000...0, Cout=0
-- =====================================================

