-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
-- Date        : Thu May 28 17:18:28 2020
-- Host        : DESKTOP-KO3VHIU running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {E:/COA experiments/exam
--               2/CPU_V2.1/CPU_V2.1.srcs/sources_1/ip/control_memory/control_memory_stub.vhdl}
-- Design      : control_memory
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_memory is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 7 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 27 downto 0 )
  );

end control_memory;

architecture stub of control_memory is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[7:0],spo[27:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_11,Vivado 2017.2";
begin
end;
