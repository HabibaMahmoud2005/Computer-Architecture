library ieee;
use ieee.std_logic_1164.all;

ENTITY ALU IS
    GENERIC (
        N : integer := 16
    );
    PORT (
        A    : IN  std_logic_vector(N-1 downto 0);
        B    : IN  std_logic_vector(N-1 downto 0);
        S    : IN  std_logic_vector(3 downto 0);  -- S3 S2 S1 S0
        Cin  : IN  std_logic;
        F    : OUT std_logic_vector(N-1 downto 0);
        Cout : OUT std_logic
    );
END ALU;

ARCHITECTURE ALUarch OF ALU IS
    SIGNAL F_A, F_B, F_C, F_D : std_logic_vector(N-1 downto 0);
    SIGNAL Cout_A, Cout_C, Cout_D : std_logic;

    COMPONENT partA IS
        GENERIC (N : integer := 16);
        PORT (
            A    : IN  std_logic_vector(N-1 downto 0);
            B    : IN  std_logic_vector(N-1 downto 0);
            Cin  : IN  std_logic;
            Sel  : IN  std_logic_vector(1 downto 0);
            F    : OUT std_logic_vector(N-1 downto 0);
            Cout : OUT std_logic
        );
    END COMPONENT;

    COMPONENT partB IS
        GENERIC (N : integer := 16);
        PORT (
            A  : IN  std_logic_vector(N-1 downto 0);
            B  : IN  std_logic_vector(N-1 downto 0);
            S0 : IN  std_logic;
            S1 : IN  std_logic;
            F  : OUT std_logic_vector(N-1 downto 0)
        );
    END COMPONENT;

    COMPONENT partC IS
        GENERIC (N : integer := 16);
        PORT (
            A    : IN  std_logic_vector(N-1 downto 0);
            Cin  : IN  std_logic;
            S0   : IN  std_logic;
            S1   : IN  std_logic;
            F    : OUT std_logic_vector(N-1 downto 0);
            Cout : OUT std_logic 
        );
    END COMPONENT;

    COMPONENT partD IS
        GENERIC (N : integer := 16);
        PORT (
            A    : IN  std_logic_vector(N-1 downto 0);
            Cin  : IN  std_logic;
            S0   : IN  std_logic;
            S1   : IN  std_logic;
            F    : OUT std_logic_vector(N-1 downto 0);
            Cout : OUT std_logic
        );
    END COMPONENT;

BEGIN
    u0 : partA GENERIC MAP (N => N) PORT MAP (A, B, Cin, S(1 downto 0), F_A, Cout_A);
    u1 : partB GENERIC MAP (N => N) PORT MAP (A, B, S(0), S(1), F_B);
    u2 : partC GENERIC MAP (N => N) PORT MAP (A, Cin, S(0), S(1), F_C, Cout_C);
    u3 : partD GENERIC MAP (N => N) PORT MAP (A, Cin, S(0), S(1), F_D, Cout_D);

  -- OUTPUT
    F <= F_A WHEN (S(3) = '0' AND S(2) = '0') ELSE  -- Arithmetic
         F_B WHEN (S(3) = '0' AND S(2) = '1') ELSE  -- Logic
         F_C WHEN (S(3) = '1' AND S(2) = '0') ELSE  -- Right shifts/rotates
         F_D WHEN (S(3) = '1' AND S(2) = '1') ELSE
         (others => '0');

    Cout <= Cout_A WHEN (S(3) = '0' AND S(2) = '0') ELSE
            '0'     WHEN (S(3) = '0' AND S(2) = '1') ELSE
            Cout_C  WHEN (S(3) = '1' AND S(2) = '0') ELSE
            Cout_D  WHEN (S(3) = '1' AND S(2) = '1') ELSE
            '0';

END ALUarch;

--------------------------------------------------------------------
-- Entity: ALU
-- Description:
--   Top-level N-bit Arithmetic Logic Unit integrating:
--     ? partA ? Arithmetic operations (add/sub, ±1, etc.)
--     ? partB ? Logic operations (AND, OR, XOR, NOT)
--     ? partC ? Right shifts/rotates
--     ? partD ? Left shifts/rotates
--
-- Generics:
--   N     : Bit-width of all inputs and outputs (default = 16)
--
-- Inputs:
--   A, B  : N-bit operands
--   S     : 4-bit select (S3 S2 S1 S0)
--           S3 S2 ? selects the module:
--              00 ? partA (arithmetic)
--              01 ? partB (logic)
--              10 ? partC (right shifts/rotates)
--              11 ? partD (left shifts/rotates)
--           S1 S0 ? operation within that module
--   Cin   : Carry input
--
-- Outputs:
--   F     : N-bit result of selected operation
--   Cout  : Carry or shifted-out bit
--------------------------------------------------------------------

