onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+main_memory -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.main_memory xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {main_memory.udo}

run -all

endsim

quit -force
