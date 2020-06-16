library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity CU is
--  Port ( );
port(
CLK : in std_logic;
RESET : in std_logic;
IR_to_CU : in std_logic_vector(7 downto 0);
CAR : buffer std_logic_vector(7 downto 0) := "00000000";
control_signal : in std_logic_vector(27 downto 0);
FLAG : in std_logic
);
end CU;

architecture Behavioral of CU is

begin

----------------------------
process(CLK)
begin
if(CLK'event and CLK = '1') then

    --CAR自增1
    if(control_signal(15) = '1') then
        CAR <= CAR + '1';
    end if;
    
    --CAR清零，开始取指令部分
    if(control_signal(17) = '1') then
            CAR <= "00000000";
    end if;
    
    --CAR跳转，对OPCODE进行译码
    if(control_signal(13) = '1') then
            case IR_to_CU is 
                when "00000001" => CAR <= "00000101";--STORE X
                when "00000010" => CAR <= "00001000";--LOAD X
                when "00000011" => CAR <= "00001100";--ADD X
                when "00000100" => CAR <= "00010010";--SUB X
                when "00000101" => --JMPGEZ X
                    if(FLAG = '1') then --ACC >= 0
                        CAR <= "00011000";
                    else
                        CAR <= "00011001";
                    end if;
                when "00000110" => CAR <= "00011010";--JMP X
                when "00000111" => CAR <= "00011011";--HALT
                when "00001000" => CAR <= "00011100";--MPY X
                when "00001001" => CAR <= "00100010";--DIV X
                when "00001010" => CAR <= "00101000";--AND X
                when "00001011" => CAR <= "00101110";--OR X
                when "00001100" => CAR <= "00110100";--NOT X
                when "00001101" => CAR <= "00111010";--SHIFTR逻辑
                when "00001110" => CAR <= "00111100";--SHIFTL逻辑
                when "00001111" => CAR <= "00111110";--SHIFTR算数
                when "00010000" => CAR <= "00111100";--SHIFTL算数
                when "00000000" => null;--程序结束END
                when others => null;
            end case;
    end if;
    
    --reset
    if(RESET='1') then
        CAR <= "00000000";
    end if;
    
end if;
end process;
----------------------------

end Behavioral;
