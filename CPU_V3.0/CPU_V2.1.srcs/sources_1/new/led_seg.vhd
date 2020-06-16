library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity led_seg is
  Port ( 
    anodes  :BUFFER    std_logic_vector(7 downto 0);-- 0 to light. anodes 7-0对应AN7-AN0
    led :OUT std_logic_vector(0 to 6);--led 0-6对应CA-CG
    AX_to_LED : in std_logic_vector(47 downto 0);
    btnc : in std_logic;
    clk     :IN   std_logic
  );
end led_seg;

architecture Behavioral of led_seg is
    signal light: string(8 downto 1):="xxxHELLO"; --数码管要显示的字符
    signal light_num: integer range 0 to 7:=0; --用于显示数码管函数，显示第几个数
    signal count_light: integer range 0 to 16001 :=0; --用于显示数码管函数计数
    signal count_btnc : integer range 0 to 2000001 :=0;
    signal release_btnc : STD_LOGIC:='1'; --1 stands for release
    signal read_MR : std_logic := '1'; --为1读取MR，为0读取DR
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            anodes<="11111111";
            anodes(light_num)<='0';
            --可扩展
            case light(light_num+1) is
                when '0'   => led<="0000001";
                when '1'   => led<="1001111";
                when '2'   => led<="0010010";
                when '3'   => led<="0000110";
                when '4'   => led<="1001100";
                when '5'   => led<="0100100";
                when '6'   => led<="0100000";
                when '7'   => led<="0001111";
                when '8'   => led<="0000000";
                when '9'   => led<="0000100";
                when 'h'   => led<="1101000";
                when 'H'   => led<="1001000";
                when 'e'   => led<="0010000";
                when 'E'   => led<="0110000";
                when 'L'   => led<="1110001";
                when 'O'   => led<="0000001";
                when 'A'   => led<="0001000";
                when 'a'   => led<="0000010";
                when 'b'   => led<="1100000";
                when 'c'   => led<="1110010";
                when 'C'   => led<="0110001";
                when 'd'   => led<="1000010";
                when 'U'   => led<="1000001";
                when 'u'   => led<="1100011";
                when 'G'   => led<="0100001";
                when 'N'   => led<="0001001";
                when 'n'   => led<="1101010";
                when 'F'   => led<="0111000";
                when 'y'   => led<="1000100";
                when 't'   => led<="1110000";
                when '?'   => led<="0011010";
                when others=> led<="1111111";
            end case;
            count_light<=count_light+1;
            if (count_light=16000) then
                count_light<=0;
                if (light_num = 7) then
                    light_num <= 0;
                else
                    light_num<=light_num+1;
                end if;
            end if;
        end if;
    end process;
    
    -----------------将寄存器的值转换为LED显示信号----------------
    process(clk)
    begin
        case AX_to_LED(3 downto 0) is  --确认light(1)
            when x"0" => light(1) <= '0';
            when x"1" => light(1) <= '1';
            when x"2" => light(1) <= '2';
            when x"3" => light(1) <= '3';
            when x"4" => light(1) <= '4';
            when x"5" => light(1) <= '5';
            when x"6" => light(1) <= '6';
            when x"7" => light(1) <= '7';
            when x"8" => light(1) <= '8';
            when x"9" => light(1) <= '9';
            when x"A" => light(1) <= 'A';
            when x"B" => light(1) <= 'b';
            when x"C" => light(1) <= 'C';
            when x"D" => light(1) <= 'd';
            when x"E" => light(1) <= 'E';
            when x"F" => light(1) <= 'F';
            when others => null;
        end case;
        
        case AX_to_LED(7 downto 4) is  --确认light(2)
            when x"0" => light(2) <= '0';
            when x"1" => light(2) <= '1';
            when x"2" => light(2) <= '2';
            when x"3" => light(2) <= '3';
            when x"4" => light(2) <= '4';
            when x"5" => light(2) <= '5';
            when x"6" => light(2) <= '6';
            when x"7" => light(2) <= '7';
            when x"8" => light(2) <= '8';
            when x"9" => light(2) <= '9';
            when x"A" => light(2) <= 'A';
            when x"B" => light(2) <= 'b';
            when x"C" => light(2) <= 'C';
            when x"D" => light(2) <= 'd';
            when x"E" => light(2) <= 'E';
            when x"F" => light(2) <= 'F';
            when others => null;
        end case;
        
        case AX_to_LED(11 downto 8) is  --确认light(3)
            when x"0" => light(3) <= '0';
            when x"1" => light(3) <= '1';
            when x"2" => light(3) <= '2';
            when x"3" => light(3) <= '3';
            when x"4" => light(3) <= '4';
            when x"5" => light(3) <= '5';
            when x"6" => light(3) <= '6';
            when x"7" => light(3) <= '7';
            when x"8" => light(3) <= '8';
            when x"9" => light(3) <= '9';
            when x"A" => light(3) <= 'A';
            when x"B" => light(3) <= 'b';
            when x"C" => light(3) <= 'C';
            when x"D" => light(3) <= 'd';
            when x"E" => light(3) <= 'E';
            when x"F" => light(3) <= 'F';
            when others => null;
        end case;

        
        case AX_to_LED(15 downto 12) is  --确认light(4)
            when x"0" => light(4) <= '0';
            when x"1" => light(4) <= '1';
            when x"2" => light(4) <= '2';
            when x"3" => light(4) <= '3';
            when x"4" => light(4) <= '4';
            when x"5" => light(4) <= '5';
            when x"6" => light(4) <= '6';
            when x"7" => light(4) <= '7';
            when x"8" => light(4) <= '8';
            when x"9" => light(4) <= '9';
            when x"A" => light(4) <= 'A';
            when x"B" => light(4) <= 'b';
            when x"C" => light(4) <= 'C';
            when x"D" => light(4) <= 'd';
            when x"E" => light(4) <= 'E';
            when x"F" => light(4) <= 'F';
            when others => null;
        end case;

        
        if (read_MR = '0') then
            case AX_to_LED(19 downto 16) is  --确认light(5)
            when x"0" => light(5) <= '0';
            when x"1" => light(5) <= '1';
            when x"2" => light(5) <= '2';
            when x"3" => light(5) <= '3';
            when x"4" => light(5) <= '4';
            when x"5" => light(5) <= '5';
            when x"6" => light(5) <= '6';
            when x"7" => light(5) <= '7';
            when x"8" => light(5) <= '8';
            when x"9" => light(5) <= '9';
            when x"A" => light(5) <= 'A';
            when x"B" => light(5) <= 'b';
            when x"C" => light(5) <= 'C';
            when x"D" => light(5) <= 'd';
            when x"E" => light(5) <= 'E';
            when x"F" => light(5) <= 'F';
            when others => null;
        end case;
        
        case AX_to_LED(23 downto 20) is  --确认light(6)
            when x"0" => light(6) <= '0';
            when x"1" => light(6) <= '1';
            when x"2" => light(6) <= '2';
            when x"3" => light(6) <= '3';
            when x"4" => light(6) <= '4';
            when x"5" => light(6) <= '5';
            when x"6" => light(6) <= '6';
            when x"7" => light(6) <= '7';
            when x"8" => light(6) <= '8';
            when x"9" => light(6) <= '9';
            when x"A" => light(6) <= 'A';
            when x"B" => light(6) <= 'b';
            when x"C" => light(6) <= 'C';
            when x"D" => light(6) <= 'd';
            when x"E" => light(6) <= 'E';
            when x"F" => light(6) <= 'F';
            when others => null;
        end case;
        
        case AX_to_LED(27 downto 24) is  --确认light(7)
            when x"0" => light(7) <= '0';
            when x"1" => light(7) <= '1';
            when x"2" => light(7) <= '2';
            when x"3" => light(7) <= '3';
            when x"4" => light(7) <= '4';
            when x"5" => light(7) <= '5';
            when x"6" => light(7) <= '6';
            when x"7" => light(7) <= '7';
            when x"8" => light(7) <= '8';
            when x"9" => light(7) <= '9';
            when x"A" => light(7) <= 'A';
            when x"B" => light(7) <= 'b';
            when x"C" => light(7) <= 'C';
            when x"D" => light(7) <= 'd';
            when x"E" => light(7) <= 'E';
            when x"F" => light(7) <= 'F';
            when others => null;
        end case;
        
        case AX_to_LED(31 downto 28) is  --确认light(8)
            when x"0" => light(8) <= '0';
            when x"1" => light(8) <= '1';
            when x"2" => light(8) <= '2';
            when x"3" => light(8) <= '3';
            when x"4" => light(8) <= '4';
            when x"5" => light(8) <= '5';
            when x"6" => light(8) <= '6';
            when x"7" => light(8) <= '7';
            when x"8" => light(8) <= '8';
            when x"9" => light(8) <= '9';
            when x"A" => light(8) <= 'A';
            when x"B" => light(8) <= 'b';
            when x"C" => light(8) <= 'C';
            when x"D" => light(8) <= 'd';
            when x"E" => light(8) <= 'E';
            when x"F" => light(8) <= 'F';
            when others => null;
        end case;
            
        else
            
            case AX_to_LED(35 downto 32) is  --确认light(5)
                when x"0" => light(5) <= '0';
                when x"1" => light(5) <= '1';
                when x"2" => light(5) <= '2';
                when x"3" => light(5) <= '3';
                when x"4" => light(5) <= '4';
                when x"5" => light(5) <= '5';
                when x"6" => light(5) <= '6';
                when x"7" => light(5) <= '7';
                when x"8" => light(5) <= '8';
                when x"9" => light(5) <= '9';
                when x"A" => light(5) <= 'A';
                when x"B" => light(5) <= 'b';
                when x"C" => light(5) <= 'C';
                when x"D" => light(5) <= 'd';
                when x"E" => light(5) <= 'E';
                when x"F" => light(5) <= 'F';
                when others => null;
            end case;
            
            case AX_to_LED(39 downto 36) is  --确认light(6)
                when x"0" => light(6) <= '0';
                when x"1" => light(6) <= '1';
                when x"2" => light(6) <= '2';
                when x"3" => light(6) <= '3';
                when x"4" => light(6) <= '4';
                when x"5" => light(6) <= '5';
                when x"6" => light(6) <= '6';
                when x"7" => light(6) <= '7';
                when x"8" => light(6) <= '8';
                when x"9" => light(6) <= '9';
                when x"A" => light(6) <= 'A';
                when x"B" => light(6) <= 'b';
                when x"C" => light(6) <= 'C';
                when x"D" => light(6) <= 'd';
                when x"E" => light(6) <= 'E';
                when x"F" => light(6) <= 'F';
                when others => null;
            end case;
            
            case AX_to_LED(43 downto 40) is  --确认light(7)
                when x"0" => light(7) <= '0';
                when x"1" => light(7) <= '1';
                when x"2" => light(7) <= '2';
                when x"3" => light(7) <= '3';
                when x"4" => light(7) <= '4';
                when x"5" => light(7) <= '5';
                when x"6" => light(7) <= '6';
                when x"7" => light(7) <= '7';
                when x"8" => light(7) <= '8';
                when x"9" => light(7) <= '9';
                when x"A" => light(7) <= 'A';
                when x"B" => light(7) <= 'b';
                when x"C" => light(7) <= 'C';
                when x"D" => light(7) <= 'd';
                when x"E" => light(7) <= 'E';
                when x"F" => light(7) <= 'F';
                when others => null;
            end case;
            
            case AX_to_LED(47 downto 44) is  --确认light(8)
                when x"0" => light(8) <= '0';
                when x"1" => light(8) <= '1';
                when x"2" => light(8) <= '2';
                when x"3" => light(8) <= '3';
                when x"4" => light(8) <= '4';
                when x"5" => light(8) <= '5';
                when x"6" => light(8) <= '6';
                when x"7" => light(8) <= '7';
                when x"8" => light(8) <= '8';
                when x"9" => light(8) <= '9';
                when x"A" => light(8) <= 'A';
                when x"B" => light(8) <= 'b';
                when x"C" => light(8) <= 'C';
                when x"D" => light(8) <= 'd';
                when x"E" => light(8) <= 'E';
                when x"F" => light(8) <= 'F';
                when others => null;
            end case;

        end if;
        
    end process;
    
    process(clk)
    begin
        if (btnc='1') then --按下btnc
            count_btnc<=count_btnc+1;
        else
            count_btnc<=0;
            release_btnc<='1';
        end if;
        
        if (count_btnc=2000000 and release_btnc='1') then --按下bntc后操作
            case read_MR is
                when '1' => read_MR <= '0';
                when others => read_MR <= '1';
            end case;
            release_btnc<='0';
            count_btnc<=0;
        end if;
    end process;
    
    
end Behavioral;