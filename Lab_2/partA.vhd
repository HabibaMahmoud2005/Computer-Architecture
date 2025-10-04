library ieee;
use ieee.std_logic_1164.all;

ENTITY partA IS
    GENERIC (
        N : integer := 16
    );
    PORT (
        A    : IN  std_logic_vector(N-1 downto 0);
        B    : IN  std_logic_vector(N-1 downto 0);
        Cin  : IN  std_logic;
        Sel  : IN  std_logic_vector(1 downto 0);
        F    : OUT std_logic_vector(N-1 downto 0);
        Cout : OUT std_logic
    );
END partA;

ARCHITECTURE partAarch OF partA IS

    COMPONENT full_adder IS
        PORT (
            A    : IN  std_logic;
            B    : IN  std_logic;
            Cin  : IN  std_logic;
            Sum  : OUT std_logic;
            Cout : OUT std_logic
        );
    END COMPONENT;

    SIGNAL B_in  : std_logic_vector(N-1 downto 0);
    SIGNAL C     : std_logic_vector(N downto 0);
    SIGNAL F_int : std_logic_vector(N-1 downto 0);

BEGIN

    -- compute B_in
    B_in <= B                 WHEN Sel = "01" ELSE
            NOT B             WHEN Sel = "10" ELSE
            (others => '1')   WHEN (Sel = "11" AND Cin = '0') ELSE B;

    C(0) <= Cin;

    FA_LOOP : FOR i IN 0 TO N-1 GENERATE
        U_FA : full_adder
            PORT MAP (
                A    => A(i),
                B    => B_in(i),
                Cin  => C(i),
                Sum  => F_int(i),
                Cout => C(i+1)
            );
    END GENERATE;

    F <= A                            WHEN (Sel = "00" AND Cin = '0') ELSE
         F_int                        WHEN (Sel = "00" AND Cin = '1') ELSE
         F_int                        WHEN (Sel = "01") ELSE
         F_int                        WHEN (Sel = "10") ELSE
         F_int                        WHEN (Sel = "11" AND Cin = '0') ELSE
         (others => '0');

    Cout <= C(N);

END partAarch;

