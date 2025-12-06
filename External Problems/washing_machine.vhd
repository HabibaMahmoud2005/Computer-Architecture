library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ENTITY
entity washing_machine_controller is
  port (
    clk        : in std_logic;
    rst        : in std_logic;
    clk_enable : in std_logic;
    fill       : out std_logic;
    wash       : out std_logic;
    rinse      : out std_logic;
    spin       : out std_logic
  );
end washing_machine_controller;

-- ARCHITECTURE
architecture rtl of washing_machine_controller is
  type washing_machine_state is (fill_state, wash_state, rinse_state, spin_state);
  signal current_state : washing_machine_state        := fill_state;
  signal clk_counter   : std_logic_vector(4 downto 0) := (others => '0');
  signal sec_en        : std_logic                    := '0';
  constant clk_max     : integer                      := 19;

  signal timer_counter : integer := 0;
begin
  process (clk, rst)
  begin
    if (rst = '0') then
      clk_counter <= (others => '0');
      sec_en      <= '0';
    elsif (rising_edge(clk)) then
      sec_en <= '0';
      if (unsigned(clk_counter) = to_unsigned(clk_max, 5)) then
        clk_counter <= (others => '0');
        sec_en      <= '1';
      else
        clk_counter <= std_logic_vector(unsigned(clk_counter) + 1);
      end if;
    end if;
  end process;
  process (clk, rst)
  begin
    if rst = '0' then
      timer_counter <= 0;
      current_state <= fill_state;
    elsif rising_edge(clk) then

      if (sec_en = '1' and clk_enable = '1') then
        case current_state is
          when fill_state =>
            if timer_counter = 2 then
              current_state <= wash_state;
              timer_counter <= 0;
            else
              if (timer_counter < 2) then
                timer_counter <= timer_counter + 1;
              end if;
            end if;
          when wash_state =>
            if timer_counter = 4 then
              current_state <= rinse_state;
              timer_counter <= 0;
            else
              if (timer_counter < 4) then
                timer_counter <= timer_counter + 1;
              end if;
            end if;
          when rinse_state =>
            if timer_counter = 1 then
              current_state <= spin_state;
              timer_counter <= 0;
            else
              if (timer_counter < 1) then
                timer_counter <= timer_counter + 1;
              end if;
            end if;
          when spin_state =>
            if timer_counter = 3 then
              current_state <= fill_state;
              timer_counter <= 0;
            else
              if (timer_counter < 3) then
                timer_counter <= timer_counter + 1;
              end if;
            end if;
        end case;
      end if;

    end if;
  end process;
  fill <= '1' when current_state = fill_state else
    '0';
  wash <= '1' when current_state = wash_state else
    '0';
  rinse <= '1' when current_state = rinse_state else
    '0';
  spin <= '1' when current_state = spin_state else
    '0';

end rtl;
