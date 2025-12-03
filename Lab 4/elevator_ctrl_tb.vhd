LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;

ENTITY elevator_ctrl_tb IS
END elevator_ctrl_tb;

ARCHITECTURE behavior OF elevator_ctrl_tb IS

    COMPONENT elevator_ctrl
        PORT(
            clk           : IN  std_logic;
            rst           : IN  std_logic;
            Key           : IN  std_logic_vector(3 DOWNTO 0);
            push_button   : IN  std_logic;
            mv_up         : OUT std_logic;
            mv_dn         : OUT std_logic;
            door_open     : OUT std_logic;
            current_floor : OUT std_logic_vector(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk_tb           : std_logic := '0';
    SIGNAL rst_tb           : std_logic := '1';
    SIGNAL Key_tb           : std_logic_vector(3 DOWNTO 0) := (others => '0');
    SIGNAL push_button_tb   : std_logic := '1';
    SIGNAL mv_up_tb         : std_logic;
    SIGNAL mv_dn_tb         : std_logic;
    SIGNAL door_open_tb     : std_logic;
    SIGNAL current_floor_tb : std_logic_vector(3 DOWNTO 0);

    CONSTANT clk_period        : time := 20 ns;
    CONSTANT ONE_SIM_SEC       : time := 100 ns;
    CONSTANT T_DELAY_PER_FLOOR : time := 2 * ONE_SIM_SEC;
    CONSTANT T_DOOR_CYCLE      : time := 2 * ONE_SIM_SEC;

BEGIN

    uut: elevator_ctrl
        PORT MAP (
            clk           => clk_tb,
            rst           => rst_tb,
            Key           => Key_tb,
            push_button   => push_button_tb,
            mv_up         => mv_up_tb,
            mv_dn         => mv_dn_tb,
            door_open     => door_open_tb,
            current_floor => current_floor_tb
        );

    clk_process : PROCESS
    BEGIN
        LOOP
            clk_tb <= '0';
            WAIT FOR clk_period/2;
            clk_tb <= '1';
            WAIT FOR clk_period/2;
        END LOOP;
    END PROCESS;

    stim_proc : PROCESS
        VARIABLE start_time : time;
    BEGIN

        rst_tb <= '1';
        WAIT FOR 5 * clk_period;
        rst_tb <= '0';
        WAIT FOR ONE_SIM_SEC;

        Key_tb <= std_logic_vector(to_unsigned(5, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;

        start_time := NOW;
        WHILE to_integer(unsigned(current_floor_tb)) /= 5 LOOP
            WAIT FOR clk_period;
            IF (NOW - start_time) > (6 * T_DELAY_PER_FLOOR + T_DOOR_CYCLE + 2 * ONE_SIM_SEC) THEN
                EXIT;
            END IF;
        END LOOP;

        Key_tb <= std_logic_vector(to_unsigned(2, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;

        start_time := NOW;
        WHILE to_integer(unsigned(current_floor_tb)) /= 2 LOOP
            WAIT FOR clk_period;
            IF (NOW - start_time) > (4 * T_DELAY_PER_FLOOR + T_DOOR_CYCLE + 2 * ONE_SIM_SEC) THEN
                EXIT;
            END IF;
        END LOOP;

        Key_tb <= std_logic_vector(to_unsigned(9, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;

        WAIT FOR clk_period;

        Key_tb <= std_logic_vector(to_unsigned(4, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;
        
        start_time := NOW;
        WHILE to_integer(unsigned(current_floor_tb)) /= 9 LOOP
            WAIT FOR clk_period;
            IF (NOW - start_time) > (8 * T_DELAY_PER_FLOOR + T_DOOR_CYCLE + 2 * ONE_SIM_SEC) THEN
                EXIT;
            END IF;
        END LOOP;
        
        start_time := NOW;
        WHILE to_integer(unsigned(current_floor_tb)) /= 4 LOOP
            WAIT FOR clk_period;
            IF (NOW - start_time) > (6 * T_DELAY_PER_FLOOR + T_DOOR_CYCLE + 2 * ONE_SIM_SEC) THEN
                EXIT;
            END IF;
        END LOOP;

        Key_tb <= std_logic_vector(to_unsigned(4, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;

        WAIT FOR T_DOOR_CYCLE + ONE_SIM_SEC;

        Key_tb <= std_logic_vector(to_unsigned(0, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;

        start_time := NOW;
        WHILE to_integer(unsigned(current_floor_tb)) /= 0 LOOP
            WAIT FOR clk_period;
            IF (NOW - start_time) > (5 * T_DELAY_PER_FLOOR + T_DOOR_CYCLE + 2 * ONE_SIM_SEC) THEN
                EXIT;
            END IF;
        END LOOP;

        Key_tb <= std_logic_vector(to_unsigned(9, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;

        start_time := NOW;
        WHILE to_integer(unsigned(current_floor_tb)) /= 9 LOOP
            WAIT FOR clk_period;
            IF (NOW - start_time) > (10 * T_DELAY_PER_FLOOR + T_DOOR_CYCLE + 2 * ONE_SIM_SEC) THEN
                EXIT;
            END IF;
        END LOOP;

        Key_tb <= std_logic_vector(to_unsigned(3, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;

        WAIT FOR clk_period;

        Key_tb <= std_logic_vector(to_unsigned(1, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;

        WAIT FOR clk_period;

        Key_tb <= std_logic_vector(to_unsigned(0, 4));
        push_button_tb <= '0';
        WAIT FOR 2 * clk_period;
        push_button_tb <= '1';
        WAIT FOR clk_period;
        
        start_time := NOW;
        WHILE to_integer(unsigned(current_floor_tb)) /= 0 LOOP
            WAIT FOR clk_period;
            IF (NOW - start_time) > (12 * T_DELAY_PER_FLOOR + 4 * T_DOOR_CYCLE + 2 * ONE_SIM_SEC) THEN
                EXIT;
            END IF;
        END LOOP;

        WAIT;
    END PROCESS;

END behavior;
