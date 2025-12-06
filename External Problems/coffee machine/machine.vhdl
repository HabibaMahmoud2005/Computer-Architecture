library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity machine is
  port (
    clk   : in std_logic;
    reset : in std_logic;
    en    : in std_logic;
    grind : out std_logic;
    brew  : out std_logic;
    pour  : out std_logic;
    clean : out std_logic
  );
end machine;

architecture machine_a of machine is
  --  signal grind_cycles : integer := 150;
  --  signal brew_cycles  : integer := 250;
  --  signal pour_cycles  : integer := 100;
  --  signal clean_cycles : integer := 200;
  signal timer : integer := 0;
  type state_type is (grind_state, brew_state, pour_state, clean_state);
  signal current_state : state_type := grind_state;
begin
  process (reset, clk)
  begin
    -- default values
    current_state <= grind_state;
    timer         <= 0;
    if (reset = '1') then
      current_state <= grind_state;
      timer         <= 0;
    elsif (rising_edge(clk)) then
      if en = '1' then
        case current_state is
          when grind_state =>
            if (timer = 149) then
              current_state <= brew_state;
              timer         <= 0;
            elsif (timer < 149) then
              timer         <= timer + 1;
              current_state <= grind_state;
            end if;
          when brew_state =>
            if (timer = 249) then
              current_state <= pour_state;
              timer         <= 0;
            elsif (timer < 249) then
              timer         <= timer + 1;
              current_state <= brew_state;
            end if;
          when pour_state =>
            if (timer = 99) then
              current_state <= clean_state;
              timer         <= 0;
            elsif (timer < 99) then
              timer         <= timer + 1;
              current_state <= pour_state;
            end if;
          when clean_state =>
            if (timer = 199) then
              current_state <= grind_state;
              timer         <= 0;
            elsif (timer < 199) then
              timer         <= timer + 1;
              current_state <= clean_state;
            end if;
        end case;
      end if;
    end if;
  end process;
  grind <= '1' when current_state = grind_state else
    '0';
  brew <= '1' when current_state = brew_state else
    '0';
  pour <= '1' when current_state = pour_state else
    '0';
  clean <= '1' when current_state = clean_state else
    '0';

end machine_a;
