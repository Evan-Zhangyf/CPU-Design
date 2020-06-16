----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/04/11 21:37:28
-- Design Name: 
-- Module Name: MBR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MBR is
port(
CLK : in std_logic;
RESET : in std_logic;
control_signal : in std_logic_vector(27 downto 0);
MEMORY_to_MBR : in std_logic_vector(15 downto 0);
ACC_to_MBR : in std_logic_vector(15 downto 0);
PC_to_MBR : in std_logic_vector(7 downto 0);
MBR_out : out std_logic_vector(15 downto 0) := "0000000000000000"
);
end MBR;

architecture Behavioral of MBR is

begin

------------------------------------
process(CLK)
begin

if(CLK'event and CLK = '1') then
    if(control_signal(5) = '1') then
        MBR_out <= MEMORY_to_MBR;
    end if;
    
    if(control_signal(11) = '1') then
        MBR_out <= ACC_to_MBR;
    end if;

    if(control_signal(1) = '1') then
        MBR_out(7 downto 0) <= PC_to_MBR;
    end if;

    if(RESET = '1') then
        MBR_out <= "0000000000000000";
    end if;
    
end if;

end process;
------------------------------------

end Behavioral;
