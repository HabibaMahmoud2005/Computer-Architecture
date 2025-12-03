library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ssd is
    Port (
        bin_in  : in  std_logic_vector(3 downto 0);
        seg_out : out std_logic_vector(6 downto 0)
    );
end ssd;

architecture Behavioral of ssd is
begin
    process(bin_in)
    begin
        case bin_in is
            when "0000" => seg_out <= "1000000"; -- 0
            when "0001" => seg_out <= "1111001"; -- 1
            when "0010" => seg_out <= "0100100"; -- 2
            when "0011" => seg_out <= "0110000"; -- 3
            when "0100" => seg_out <= "0011001"; -- 4
            when "0101" => seg_out <= "0010010"; -- 5
            when "0110" => seg_out <= "0000010"; -- 6
            when "0111" => seg_out <= "1111000"; -- 7
            when "1000" => seg_out <= "0000000"; -- 8
            when "1001" => seg_out <= "0010000"; -- 9
            when others => seg_out <= "1111111"; -- blank
        end case;
    end process;
end Behavioral;
