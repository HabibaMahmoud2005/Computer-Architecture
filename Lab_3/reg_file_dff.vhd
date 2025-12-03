LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY reg_file_dff IS
  PORT (
    clk        : IN  STD_LOGIC;
    rst        : IN  STD_LOGIC;
    we         : IN  STD_LOGIC;
    read_addr1 : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    read_addr2 : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    write_addr : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    write_data : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
    read_data1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    read_data2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END reg_file_dff;

ARCHITECTURE reg_file_dff_arch OF reg_file_dff IS

  COMPONENT MY_NDFF
    GENERIC (N : INTEGER := 8);
    PORT (
      d   : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
      clk : IN  STD_LOGIC;
      rst : IN  STD_LOGIC;
      q   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
  END COMPONENT;

  TYPE reg_array IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL reg_out : reg_array := (OTHERS => (OTHERS => '0'));
  SIGNAL d_in    : reg_array;

BEGIN

  gen_regs : FOR i IN 0 TO 7 GENERATE
  BEGIN
    d_in(i) <= write_data 
            WHEN (we = '1' AND TO_INTEGER(UNSIGNED(write_addr)) = i)
            ELSE reg_out(i);

    reg_i : MY_NDFF
      GENERIC MAP (N => 8)
      PORT MAP (d_in(i),clk,rst,reg_out(i));
  END GENERATE;

  read_data1 <= reg_out(TO_INTEGER(UNSIGNED(read_addr1)));
  read_data2 <= reg_out(TO_INTEGER(UNSIGNED(read_addr2)));

END reg_file_dff_arch;

