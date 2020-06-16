----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/04/11 21:32:03
-- Design Name: 
-- Module Name: MAR - Behavioral
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

entity MAR is
port(
CLK : in std_logic;
RESET : in std_logic;
control_signal : in std_logic_vector(27 downto 0);
MBR_to_MAR : in std_logic_vector(7 downto 0);
PC_to_MAR : in std_logic_vector(7 downto 0);
MAR_out : out std_logic_vector(7 downto 0) := "00000000"
);
end MAR;

architecture Behavioral of MAR is

begin

------------------------------------
process(CLK)
begin

if(CLK'event and CLK = '1') then
    if(control_signal(8) = '1') then
        MAR_out <= MBR_to_MAR;
    end if;
    
    if(control_signal(2) = '1') then
        MAR_out <= PC_to_MAR;
    end if;
    
    if(RESET = '1') then
        MAR_out <= "00000000";
    end if;
    
end if;

end process;
------------------------------------

end Behavioral;
