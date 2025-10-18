LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MY_NDFF IS
  PORT (
    d   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
    clk : IN  STD_LOGIC;
    rst : IN  STD_LOGIC;
    q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END MY_NDFF;

ARCHITECTURE MY_NDFF_ARCH OF MY_NDFF IS
  COMPONENT my_DFF
    PORT (
      d   : IN  STD_LOGIC;
      clk : IN  STD_LOGIC;
      rst : IN  STD_LOGIC;
      q   : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  bit0 : my_DFF PORT MAP (d(0), clk, rst, q(0));
  bit1 : my_DFF PORT MAP (d(1), clk, rst, q(1));
  bit2 : my_DFF PORT MAP (d(2), clk, rst, q(2));
  bit3 : my_DFF PORT MAP (d(3), clk, rst, q(3));
  bit4 : my_DFF PORT MAP (d(4), clk, rst, q(4));
  bit5 : my_DFF PORT MAP (d(5), clk, rst, q(5));
  bit6 : my_DFF PORT MAP (d(6), clk, rst, q(6));
  bit7 : my_DFF PORT MAP (d(7), clk, rst, q(7));
END MY_NDFF_ARCH;
