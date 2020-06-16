----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/04/11 20:47:10
-- Design Name: 
-- Module Name: IR - Behavioral
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

entity IR is
--  Port ( );
port(
CLK : in std_logic;
RESET : in std_logic;
control_signal : in std_logic_vector(27 downto 0);
MBR_to_IR : in std_logic_vector(7 downto 0);
IR_out : out std_logic_vector(7 downto 0) := "00000000" --就是IR寄存器的存储值
);
end IR;

architecture Behavioral of IR is
begin

------------------------------------
process(CLK)
begin

if(CLK'event and CLK = '1') then
    if(control_signal(4) = '1') then
        IR_out <= MBR_to_IR;
    end if;
    
    if(RESET = '1') then
        IR_out <= "00000000";
    end if;

end if;

end process;
------------------------------------


end Behavioral;
