@echo off
set xv_path=D:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 2a67a68aae8e44999ca43a6c1c262254 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot CPU_sim_behav xil_defaultlib.CPU_sim -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
