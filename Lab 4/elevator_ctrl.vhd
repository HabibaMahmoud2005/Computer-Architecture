LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY elevator_ctrl IS PORT(
    clk: IN std_logic;
    rst: IN std_logic;
    Key: IN std_logic_vector(3 DOWNTO 0);
    push_button: IN std_logic;
    mv_up: OUT std_logic;
    mv_dn: OUT std_logic;
    door_open: OUT std_logic;
    current_floor: OUT std_logic_vector(3 DOWNTO 0);
    HEX0: OUT std_logic_vector(6 DOWNTO 0));
END elevator_ctrl;

ARCHITECTURE elevator OF elevator_ctrl IS

    TYPE elevator_state IS (idle, move_up, move_down, open_door);
    SIGNAL state_reg: elevator_state := idle;

    SIGNAL destination: std_logic_vector(9 DOWNTO 0) := (others => '0');
    SIGNAL current_floor_signal: std_logic_vector(3 DOWNTO 0) := (others => '0');
    SIGNAL direction: std_logic := '0';

    SIGNAL clk_counter: std_logic_vector(25 DOWNTO 0) := (others => '0');
    SIGNAL sec_en: std_logic := '0';
    CONSTANT clk_max: integer := 49999999;

    SIGNAL timer_counter: std_logic_vector(1 DOWNTO 0) := (others => '0');
    SIGNAL push_button_prev: std_logic := '1';

BEGIN

    PROCESS(clk, rst)
    BEGIN
        IF(rst = '0') THEN
            clk_counter <= (others => '0');
            sec_en <= '0';
        ELSIF(rising_edge(clk)) THEN
            sec_en <= '0';
            IF(unsigned(clk_counter) = to_unsigned(clk_max, 26)) THEN
                clk_counter <= (others => '0');
                sec_en <= '1';
            ELSE
                clk_counter <= std_logic_vector(unsigned(clk_counter) + 1)
            END IF;
        END IF;
    END PROCESS;

    PROCESS(clk, rst)
        VARIABLE current_floor_reg: std_logic_vector(3 DOWNTO 0) := (others => '0');
        VARIABLE has_request_above: std_logic;
        VARIABLE has_request_below: std_logic;
    BEGIN
        IF(rst = '0') THEN
            state_reg <= idle;
            mv_up <= '0';
            mv_dn <= '0';
            door_open <= '0';
            destination <= (others => '0');
            timer_counter <= (others => '0');
            push_button_prev <= '1';
            direction <= '0';

        ELSIF(rising_edge(clk)) THEN
            IF push_button = '0' AND push_button_prev = '1' AND unsigned(key) <= 9 THEN
                destination(to_integer(unsigned(key))) <= '1';
            END IF;
            push_button_prev <= push_button;

            IF(sec_en = '1') THEN
                mv_up <= '0';
                mv_dn <= '0';
                door_open <= '0';

                has_request_above := '0';
                has_request_below := '0';

                FOR i IN 0 TO 9 LOOP
                    IF i > to_integer(unsigned(current_floor_reg)) AND destination(i) = '1' THEN
                        has_request_above := '1';
                    END IF;
                    IF i < to_integer(unsigned(current_floor_reg)) AND destination(i) = '1' THEN
                        has_request_below := '1';
                    END IF;
                END LOOP;

                CASE state_reg IS
                    WHEN idle =>
                        timer_counter <= (others => '0');
                        
                        IF current_floor_reg /= "1001" AND has_request_above = '1' THEN
                            state_reg <= move_up;
                            mv_up <= '1';
                            direction <= '1';
                        ELSIF current_floor_reg /= "0000" AND has_request_below = '1' THEN
                            state_reg <= move_down;
                            mv_dn <= '1';
                            direction <= '0';
                        ELSIF destination(to_integer(unsigned(current_floor_reg))) = '1' THEN
                            state_reg <= open_door;
                        END IF;

                    WHEN move_up =>
                        mv_up <= '1';
                        direction <= '1';
                        
                        IF(timer_counter < "01") THEN
                            timer_counter <= std_logic_vector(unsigned(timer_counter) + 1);
                        ELSE
                            timer_counter <= (others => '0');
                            
                            IF (unsigned(current_floor_reg) < 9) THEN
                                current_floor_reg := std_logic_vector(unsigned(current_floor_reg) + 1);
                            END IF;
                            
                            IF (destination(to_integer(unsigned(current_floor_reg))) = '1') THEN
                                state_reg <= open_door;
				door_open <= '1';
				mv_up     <= '0';
                            END IF;
                        END IF;

                    WHEN move_down =>
                        direction <= '0';
                        mv_dn <= '1';
                        
                        IF(timer_counter < "01") THEN
                            timer_counter <= std_logic_vector(unsigned(timer_counter) + 1);
                        ELSE
                            timer_counter <= (others => '0');
                            
                            IF (unsigned(current_floor_reg) > 0) THEN
                                current_floor_reg := std_logic_vector(unsigned(current_floor_reg) - 1);
                            END IF;
                            
                            IF (destination(to_integer(unsigned(current_floor_reg))) = '1') THEN
                                state_reg <= open_door;
				door_open <= '1';
				mv_dn     <= '0';
                            END IF;
                        END IF;

                    WHEN open_door =>
                        door_open <= '1';
                        destination(to_integer(unsigned(current_floor_reg))) <= '0';
                        
                        IF(timer_counter < "01") THEN
                            timer_counter <= std_logic_vector(unsigned(timer_counter) + 1);
                        ELSE
                            timer_counter <= (others => '0');
                            door_open <= '0';
                            
                            IF (direction = '1') THEN
                                IF (current_floor_reg /= "1001" AND has_request_above = '1') THEN
                                    state_reg <= move_up;
                                    mv_up <= '1';
                                ELSIF (current_floor_reg /= "0000" AND has_request_below = '1') THEN
                                    state_reg <= move_down;
                                    mv_dn <= '1';
                                    direction <= '0';
                                ELSE
                                    state_reg <= idle;
                                END IF;
                            ELSE
                                IF (current_floor_reg /= "0000" AND has_request_below = '1') THEN
                                    state_reg <= move_down;
                                    mv_dn <= '1';
                                ELSIF (current_floor_reg /= "1001" AND has_request_above = '1') THEN
                                    state_reg <= move_up;
                                    mv_up <= '1';
                                    direction <= '1';
                                ELSE
                                    state_reg <= idle;
                                END IF;
                            END IF;
                        END IF;
                END CASE;
            END IF;
        END IF;
        current_floor_signal <= current_floor_reg;
    END PROCESS;

    current_floor <= current_floor_signal;

    u_ssd : ENTITY work.ssd PORT MAP (
        bin_in  => current_floor_signal,
        seg_out => HEX0);

END elevator;
