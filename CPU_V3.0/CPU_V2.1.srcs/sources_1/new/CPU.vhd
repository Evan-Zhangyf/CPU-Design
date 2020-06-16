library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU is
port(
    CLK : in std_logic;
    RESET : in std_logic;
    AX_to_LED : out std_logic_vector(47 downto 0)
);
end CPU;

architecture Behavioral of CPU is
    component ALU
        Port (
        ACC_to_ALU : in std_logic_vector(15 downto 0);
        ALU_to_ACC: out std_logic_vector(15 downto 0);
        ALU_to_DR: out std_logic_vector(15 downto 0);
        ALU_to_MR: out std_logic_vector(15 downto 0);
        BR_to_ALU : in std_logic_vector(15 downto 0);
        control_signal : in std_logic_vector(27 downto 0) := (others => '0') ;
        flag : out std_logic;
        clk : in std_logic
         );
    end component;
    
    component AX
        Port ( 
        AX_to_LED : out std_logic_vector(47 downto 0);
        MBR_to_ACC : in std_logic_vector(15 downto 0);
        ACC_out : buffer std_logic_vector(15 downto 0);
        ALU_to_ACC : in std_logic_vector(15 downto 0);
        ALU_to_DR : in std_logic_vector(15 downto 0);
        ALU_to_MR : in std_logic_vector(15 downto 0);
        control_signal : in std_logic_vector(27 downto 0);
        clk : in std_logic
        );
    end component;
    
    component BR
        Port (
        clk : in std_logic;
        MBR_to_BR : in std_logic_vector(15 downto 0);
        BR_to_ALU : out std_logic_vector(15 downto 0);
        control_signal : in std_logic_vector(27 downto 0)
        );
    end component;
    
    component CU
        port(
            CLK : in std_logic;
            RESET : in std_logic;
            IR_to_CU : in std_logic_vector(7 downto 0);
            CAR : buffer std_logic_vector(7 downto 0) := "00000000";
            control_signal : in std_logic_vector(27 downto 0);
            FLAG : in std_logic
        );
    end component;
    
    component IR
        port(
        CLK : in std_logic;
        RESET : in std_logic;
        control_signal : in std_logic_vector(27 downto 0);
        MBR_to_IR : in std_logic_vector(7 downto 0);
        IR_out : out std_logic_vector(7 downto 0) := "00000000" --就是IR寄存器的存储值
        );
    end component;
    
    component MAR
        port(
        CLK : in std_logic;
        RESET : in std_logic;
        control_signal : in std_logic_vector(27 downto 0);
        MBR_to_MAR : in std_logic_vector(7 downto 0);
        PC_to_MAR : in std_logic_vector(7 downto 0);
        MAR_out : out std_logic_vector(7 downto 0) := "00000000"
        );
    end component;
    
    component MBR
        port(
        CLK : in std_logic;
        RESET : in std_logic;
        control_signal : in std_logic_vector(27 downto 0);
        MEMORY_to_MBR : in std_logic_vector(15 downto 0);
        ACC_to_MBR : in std_logic_vector(15 downto 0);
        PC_to_MBR : in std_logic_vector(7 downto 0);
        MBR_out : out std_logic_vector(15 downto 0) := "0000000000000000"
        );
    end component;
    
    component PC
        port(
        CLK : in std_logic;
        RESET : in std_logic;
        control_signal : in std_logic_vector(27 downto 0);
        MBR_to_PC : in std_logic_vector(7 downto 0);
        PC_out : buffer std_logic_vector(7 downto 0) := "00000000"
        );
    end component;
    
    COMPONENT control_memory
      PORT (
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        spo : OUT STD_LOGIC_VECTOR(27 DOWNTO 0)
      );
    END COMPONENT;
    
    COMPONENT main_memory
  PORT (
      clka : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
    END COMPONENT;
    
    ------------ALU部分------------
    signal ALU_to_ACC: std_logic_vector(15 downto 0);
    signal ALU_to_DR: std_logic_vector(15 downto 0);
    signal ALU_to_MR: std_logic_vector(15 downto 0);
    signal BR_to_ALU : std_logic_vector(15 downto 0);
    signal flag : std_logic;
    
    ------------AX部分------------
--    signal AX_to_LED : std_logic_vector(47 downto 0);
    signal ACC_out : std_logic_vector(15 downto 0);
    
    ------------CU部分------------
    signal CAR : std_logic_vector(7 downto 0) := "00000000";
    
    ------------IR部分------------
    signal IR_out : std_logic_vector(7 downto 0) := "00000000";
    
    ------------MAR部分------------
    signal MAR_out : std_logic_vector(7 downto 0) := "00000000";
    
    ------------MBR部分------------
    signal MEMORY_to_MBR : std_logic_vector(15 downto 0);
    signal MBR_out : std_logic_vector(15 downto 0) := "0000000000000000";
    
    ------------PC部分------------
    signal PC_out : std_logic_vector(7 downto 0) := "00000000";
    
    
    signal control_signal : std_logic_vector(27 downto 0) := (others => '0');

begin
    u_ALU : ALU port map (ACC_to_ALU=>ACC_out, ALU_to_ACC=>ALU_to_ACC,
    ALU_to_DR=>ALU_to_DR, ALU_to_MR=>ALU_to_MR, BR_to_ALU=>BR_to_ALU,
    control_signal=>control_signal, flag=>flag, clk=>clk);
    
    u_AX : AX port map (AX_to_LED=>AX_to_LED, MBR_to_ACC=>MBR_out, ACC_out=>ACC_out,
    ALU_to_ACC=>ALU_to_ACC, ALU_to_DR=>ALU_to_DR, ALU_to_MR=>ALU_to_MR,
    control_signal=>control_signal, clk=>clk);
    
    u_BR : BR port map(clk=>clk, MBR_to_BR=>MBR_out, BR_to_ALU=>BR_to_ALU,
    control_signal=>control_signal);
     
    u_CU : CU port map(CLK=>CLK, RESET=>RESET, IR_to_CU=>IR_out, CAR=>CAR,
    control_signal=>control_signal, FLAG=>FLAG);
    
    u_IR : IR port map(CLK=>CLK, RESET=>RESET, control_signal=>control_signal,
    MBR_to_IR=>MBR_out(15 downto 8), IR_out=>IR_out);
     
    u_MAR : MAR port map(CLK=>CLK, RESET=>RESET, control_signal=>control_signal,
    MBR_to_MAR=>MBR_out(7 downto 0), PC_to_MAR=>PC_out, MAR_out=>MAR_out);
    
    u_MBR : MBR port map(CLK=>CLK, RESET=>RESET, control_signal=>control_signal,
     MEMORY_to_MBR=>MEMORY_to_MBR, ACC_to_MBR=>ACC_out, PC_to_MBR=>PC_out(7 downto 0), MBR_out=>MBR_out);
    
    u_PC : PC port map(CLK=>CLK, RESET=>RESET, control_signal=>control_signal,
     MBR_to_PC=>MBR_out(7 downto 0), PC_out=>PC_out);
    
    u_control_memory : control_memory PORT MAP (
         a => CAR,
         spo => control_signal
       );
    
    u_main_memory : main_memory port map(addra => MAR_out,
           dina => MBR_out,
           clka => clk,
           wea(0) => control_signal(12),
           douta => MEMORY_to_MBR);
     
end Behavioral;