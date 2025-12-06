library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity machine_tb is
end entity machine_tb;

architecture behavior of machine_tb is
  -- Component declaration for the coffee machine controller
  component machine is
    port (
      clk   : in std_logic;
      reset : in std_logic;
      en    : in std_logic;
      grind : out std_logic;
      brew  : out std_logic;
      pour  : out std_logic;
      clean : out std_logic
    );
  end component;

  -- Signals for the testbench
  signal clk      : std_logic := '0';
  signal reset    : std_logic := '0';
  signal en       : std_logic := '0';
  signal grind    : std_logic;
  signal brew     : std_logic;
  signal pour     : std_logic;
  signal clean    : std_logic;
  constant PERIOD : time := 20 ns;
begin
  clk <= not clk after PERIOD/2;
  -- Instantiate the machine controller
  uut : machine
  port map
  (
    clk   => clk,
    reset => reset,
    en    => en,
    grind => grind,
    brew  => brew,
    pour  => pour,
    clean => clean
  );

  -- Test process
  test_process : process
  begin
    -- Apply reset
    reset <= '1';
    wait for 2 * PERIOD;
    assert (grind = '1' and brew = '0' and pour = '0' and clean = '0')
    report "Test failed: Reset" severity error;
    -- Reset disabled
    reset <= '0';
    wait for 2 * period;
    assert (grind = '1' and brew = '0' and pour = '0' and clean = '0')
    report "Test failed: disable reset" severity error;
    -- enable enabled
    en <= '1';
    wait for 100 * period; -- in grind state (in time moment => 2000 ns)
    assert (grind = '1' and brew = '0' and pour = '0' and clean = '0')
    report "Test failed: grind" severity error;
    wait for 200 * PERIOD; -- in brew state  (in time moment => 6000 ns)
    assert (grind = '0' and brew = '1' and pour = '0' and clean = '0')
    report "Test failed: brew" severity error;
    wait for 150 * PERIOD; -- in brew state  (in time moment => 9000 ns)
    assert (grind = '0' and brew = '0' and pour = '1' and clean = '0')
    report "Test failed: pour" severity error;
    wait for 100 * PERIOD; -- in brew state  (in time moment => 11000 ns)
    assert (grind = '0' and brew = '0' and pour = '0' and clean = '1')
    report "Test failed: clean" severity error;
    wait for 160 * PERIOD; -- in grind state again (in time moment => 14200 ns)
    assert (grind = '1' and brew = '0' and pour = '0' and clean = '0')
    report "Test failed: grind" severity error;
    wait for 10 * PERIOD;
    reset <= '1';
    wait for 2 * PERIOD;
    assert (grind = '1' and brew = '0' and pour = '0' and clean = '0')
    report "Test failed: Reset" severity error;
    wait;
  end process test_process;
end architecture behavior;
