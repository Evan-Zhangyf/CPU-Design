library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BR is
Port (
    clk : in std_logic;
    MBR_to_BR : in std_logic_vector(15 downto 0);
    BR_to_ALU : out std_logic_vector(15 downto 0) := x"0000";
    control_signal : in std_logic_vector(27 downto 0)
    );
end BR;

architecture Behavioral of BR is

begin

    process(clk)
    begin
        if(rising_edge(clk)) then
            if (control_signal(6) = '1') then
                BR_to_ALU <= MBR_to_BR;
            end if;
        end if;
    end process;
    
end Behavioral;