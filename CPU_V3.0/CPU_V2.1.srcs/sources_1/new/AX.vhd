library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--寄存器ACC、DR、MR统称为AX
entity AX is
    Port ( 
    AX_to_LED : out std_logic_vector(47 downto 0) := x"000000000000";
    
    MBR_to_ACC : in std_logic_vector(15 downto 0);
    ACC_out : buffer std_logic_vector(15 downto 0) := x"0000";
    
    ALU_to_ACC : in std_logic_vector(15 downto 0);
    ALU_to_DR : in std_logic_vector(15 downto 0);
    ALU_to_MR : in std_logic_vector(15 downto 0);
    
    control_signal : in std_logic_vector(27 downto 0);
    clk : in std_logic
    );
end AX;

architecture Behavioral of AX is
    signal DR : std_logic_vector(15 downto 0) := x"0000";
    signal MR : std_logic_vector(15 downto 0) := x"0000";
    
begin

    process(clk)
    begin
        if(rising_edge(clk)) then
        
            --传输AX给LED
            AX_to_LED(15 downto 0) <= ACC_out;
            AX_to_LED(31 downto 16) <= DR;
            AX_to_LED(47 downto 32) <= MR;
            
            --AX的写入
            if (control_signal(10) = '1') then
                ACC_out <= MBR_to_ACC;
                --刷新显示
                AX_to_LED(15 downto 0) <= MBR_to_ACC;
            elsif (control_signal(9) = '1') then
                ACC_out <= ALU_to_ACC;
                DR <= ALU_to_DR;
                MR <= ALU_to_MR;
                --刷新显示
                AX_to_LED(15 downto 0) <= ALU_to_ACC;
                AX_to_LED(31 downto 16) <= ALU_to_DR;
                AX_to_LED(47 downto 32) <= ALU_to_MR;           
            end if;
        end if;
    end process;
    
end Behavioral;
