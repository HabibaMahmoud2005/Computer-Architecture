LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY reg_file_mem IS
  PORT (
    clk        : IN  STD_LOGIC;
    rst        : IN  STD_LOGIC;
    we         : IN  STD_LOGIC;
    read_addr1 : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    read_addr2 : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    write_addr : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    datain     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
    dataout1   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    dataout2   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END ENTITY reg_file_mem;

ARCHITECTURE sync_ram_a OF reg_file_mem IS

  TYPE ram_type IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL ram : ram_type := (OTHERS => (OTHERS => '0'));

BEGIN

  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      ram <= (OTHERS => (OTHERS => '0'));
    ELSIF rising_edge(clk) THEN
      IF we = '1' THEN
        ram(to_integer(unsigned(write_addr))) <= datain;
      END IF;
    END IF;
  END PROCESS;

  dataout1 <= ram(to_integer(unsigned(read_addr1)));
  dataout2 <= ram(to_integer(unsigned(read_addr2)));

END ARCHITECTURE sync_ram_a;

