LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_DFF IS
  PORT (
    d   : IN  STD_LOGIC;
    clk : IN  STD_LOGIC;\
    rst : IN  STD_LOGIC;
    q   : OUT STD_LOGIC
  );
END my_DFF;

ARCHITECTURE DFF_ARCH OF my_DFF IS
BEGIN
  PROCESS (clk, rst)
  BEGIN
    IF (rst = '1') THEN
      q <= '0';
    ELSIF RISING_EDGE(clk) THEN
      q <= d;
    END IF;
  END PROCESS;
END DFF_ARCH;

