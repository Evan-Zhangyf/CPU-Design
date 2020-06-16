library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        ACC_to_ALU : in std_logic_vector(15 downto 0);
        ALU_to_ACC: out std_logic_vector(15 downto 0);
        
        ALU_to_DR: out std_logic_vector(15 downto 0) := x"0000";
        ALU_to_MR: out std_logic_vector(15 downto 0) := x"0000";
        
        BR_to_ALU : in std_logic_vector(15 downto 0);
        
        --    控制信号默认值为全部置0
        control_signal : in std_logic_vector(27 downto 0);
        
        --    值为1代表ACC的值大于等于0
        flag : out std_logic := '0';
        clk : in std_logic
     );
end ALU;

architecture Behavioral of ALU is
    
begin

    process(clk)
        --保存运算结果的缓存
        variable temp : std_logic_vector(31 downto 0) := x"00000000";
        --do_opt代表本轮进行的运算操作,包括乘、除、其他、无
        --为了完成除法所添加的临时变量
        variable quotient : integer;
        variable remainder : integer;
    begin
        if (rising_edge(clk)) then
            -----------运算操作-----------
            ----------------------------------------C7, C14为1
            if (control_signal(7) = '1' and control_signal(14) = '1') then
                if (control_signal(19) = '1') then  --加法
                    temp(15 downto 0) := ACC_to_ALU + BR_to_ALU;
                    case temp(15) is
                        when '0' => flag <= '1';
                        when others => flag <= '0';
                    end case;
                    
                elsif (control_signal(20) = '1') then  --减法
                    temp(15 downto 0) := ACC_to_ALU - BR_to_ALU;
                    case temp(15) is
                        when '0' => flag <= '1';
                        when others => flag <= '0';
                    end case;
                    
                elsif (control_signal(21) = '1') then  --乘法
                    temp := std_logic_vector(to_signed(to_integer(signed(ACC_to_ALU)) * to_integer(signed(BR_to_ALU)), 32));
                    ALU_to_ACC <= temp(15 downto 0);
                    ALU_to_MR <= temp(31 downto 16);
                    case temp(15) is
                        when '0' => flag <= '1';
                        when others => flag <= '0';
                    end case;
                    ALU_to_MR <= temp(31 downto 16);
                    
                elsif (control_signal(22) = '1') then  --除法
                    if (BR_to_ALU = x"0000") then   --如果分母为0，则令商为0，余数为被除数
                        temp(31 downto 16) := ACC_to_ALU;
                        temp(15 downto 0) := x"0000";
                    else   --分母不为0，正常运算
                        remainder := to_integer(signed(ACC_to_ALU)) mod to_integer(signed(BR_to_ALU));
                        quotient := (to_integer(signed(ACC_to_ALU)) - remainder) / to_integer(signed(BR_to_ALU));
                        temp(31 downto 16) := std_logic_vector(to_signed(remainder, 16));
                        temp(15 downto 0) := std_logic_vector(to_signed(quotient, 16));
                    end if;
                    case temp(15) is
                        when '0' => flag <= '1';
                        when others => flag <= '0';
                    end case;
                    ALU_to_DR <= temp(31 downto 16);
                    
                elsif (control_signal(23) = '1') then  --与
                    temp(15 downto 0) := ACC_to_ALU and BR_to_ALU;
                    case temp(15) is
                        when '0' => flag <= '1';
                        when others => flag <= '0';
                    end case;
                    
                elsif (control_signal(24) = '1') then  --或
                    temp(15 downto 0) := ACC_to_ALU or BR_to_ALU;
                    case temp(15) is
                        when '0' => flag <= '1';
                        when others => flag <= '0';
                    end case;
                end if;
            ------------------------------------C7为1
            elsif (control_signal(7) = '1') then
                if (control_signal(26) = '1') then  --逻辑右移
                    temp(14 downto 0) := ACC_to_ALU(15 downto 1);
                    temp(15) := '0';
                    case temp(15) is
                        when '0' => flag <= '1';
                        when others => flag <= '0';
                    end case;
                    
                elsif (control_signal(27) = '1') then  --逻辑左移
                    temp(15 downto 1) := ACC_to_ALU(14 downto 0);
                    temp(0) := '0';
                    case temp(15) is
                        when '0' => flag <= '1';
                        when others => flag <= '0';
                    end case;
                    
                elsif (control_signal(16) = '1') then  --算数右移
                        temp(14 downto 0) := ACC_to_ALU(15 downto 1);
                        temp(15) := ACC_to_ALU(15);
                        case temp(15) is
                            when '0' => flag <= '1';
                            when others => flag <= '0';
                        end case;
                end if;
                
                
            ------------------------------------C14为1
            elsif (control_signal(14) = '1' and control_signal(25) = '1') then
                temp(15 downto 0) := not BR_to_ALU;  --非
                case temp(15) is
                    when '0' => flag <= '1';
                    when others => flag <= '0';
                end case;
            end if;
            

-----------------------输出信号            
            ALU_to_ACC <= temp(15 downto 0);
            
        end if;
    end process;

end Behavioral;
