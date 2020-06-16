----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/04/23 19:55:24
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
port(
    CLK : in std_logic;
    RESET : in std_logic;
    anodes : BUFFER std_logic_vector(7 downto 0);-- 0 to light. anodes 7-0对应AN7-AN0
    led :OUT std_logic_vector(0 to 6);--led 0-6对应CA-CG
    btnc : in std_logic
);
end TOP;

architecture Behavioral of TOP is

component CPU
port(
    CLK : in std_logic;
    RESET : in std_logic;
    AX_to_LED : out std_logic_vector(47 downto 0)
);
end component;

component led_seg
  Port ( 
    anodes  :BUFFER    std_logic_vector(7 downto 0);-- 0 to light. anodes 7-0对应AN7-AN0
    led :OUT std_logic_vector(0 to 6);--led 0-6对应CA-CG
    AX_to_LED : in std_logic_vector(47 downto 0);
    btnc : in std_logic;
    clk     :IN   std_logic
  );
end component;

signal AX_to_LED : std_logic_vector(47 downto 0);

begin

u_CPU : CPU PORT MAP(
	CLK => CLK,
	RESET => RESET,
	AX_to_LED => AX_to_LED
	);

u_led : led_seg PORT MAP(
	clk => CLK,
	led => led,
	AX_to_LED => AX_to_LED,
	btnc => btnc,
	anodes => anodes
	);

end Behavioral;
