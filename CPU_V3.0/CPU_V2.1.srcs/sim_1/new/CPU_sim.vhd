----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/04/12 20:47:00
-- Design Name: 
-- Module Name: CPU_sim - Behavioral
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

entity CPU_sim is
--  Port ( );
end CPU_sim;

architecture Behavioral of CPU_sim is

component CPU
port(
    CLK : in std_logic;
    RESET : in std_logic;
    AX_to_LED : out std_logic_vector(47 downto 0)
);
end component;

signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal AX_to_LED : std_logic_vector(47 downto 0);
constant clk_period : time := 20 ns;

begin

u_CPU : CPU PORT MAP(
	CLK => clk,
	RESET => reset,
	AX_to_LED => AX_to_LED
	);

--    时钟信号的生成
clk_gen : process
    begin
        clk<='0';  
        wait for clk_period/2;  
        clk<='1';  
        wait for clk_period/2;  
    end process;
    
end Behavioral;
