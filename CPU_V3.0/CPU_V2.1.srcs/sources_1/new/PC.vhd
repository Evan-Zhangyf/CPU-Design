----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/04/11 21:06:03
-- Design Name: 
-- Module Name: PC - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
port(
CLK : in std_logic;
RESET : in std_logic;
control_signal : in std_logic_vector(27 downto 0);
MBR_to_PC : in std_logic_vector(7 downto 0);
PC_out : buffer std_logic_vector(7 downto 0) := "00000000"
);
end PC;

architecture Behavioral of PC is

begin

------------------------------------
process(CLK)
begin

if(CLK'event and CLK = '1') then
    if(control_signal(3) = '1') then
        PC_out <= MBR_to_PC;
    end if;
    
    if(control_signal(18) = '1') then
        PC_out <= PC_out + '1';
    end if;
    
    if(RESET = '1') then
        PC_out <= "00000000";
    end if;
    
end if;

end process;
------------------------------------

end Behavioral;
