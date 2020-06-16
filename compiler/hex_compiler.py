#盘古V2.0汇编语言编译器
#语句格式示例如下，INSTRUCTIONS后为代码区，DATA后为数据区，先输入数据地址，打一个空格，再输入数据的值
#所有的地址，数据均为16位。可以不写全，如0064可以直接写64
#此代码最终输出的coe是十六进制的
'''
INSTRUCTIONS:
LOAD 8A
DATA:
8A 0064
'''



#初始化coe文件内存
memory = ["0000" for i in range(256)]
#当前写内存的地址
addr = 0
cur_pointer = 1
with open('code.txt', 'r') as f:
    temp = f.read()
    code = temp.split()
    #instruction
    while code[cur_pointer] != "DATA:":
        if code[cur_pointer] == "STORE":
            memory[addr] = "01" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "LOAD":
            memory[addr] = "02" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "ADD":
            memory[addr] = "03" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "SUB":
            memory[addr] = "04" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "JMPGEZ":
            memory[addr] = "05" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "JMP":
            memory[addr] = "06" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "HALT":
            memory[addr] = "07" + "00"
            addr = addr + 1
            cur_pointer = cur_pointer + 1
        elif code[cur_pointer] == "MPY":
            memory[addr] = "08" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "DIV":
            memory[addr] = "09" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "AND":
            memory[addr] = "0A" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "OR":
            memory[addr] = "0B" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "NOT":
            memory[addr] = "0C" + "0"*(2 - len(code[cur_pointer+1])) + code[cur_pointer+1]
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "SHIFTR":
            memory[addr] = "0D" + "00"
            addr = addr + 1
            cur_pointer = cur_pointer + 1
        elif code[cur_pointer] == "SHIFTL":
            memory[addr] = "0E" + "00"
            addr = addr + 1
            cur_pointer = cur_pointer + 1
        elif code[cur_pointer] == "ASHIFTR":
            memory[addr] = "0F" + "00"
            addr = addr + 1
            cur_pointer = cur_pointer + 1
        elif code[cur_pointer] == "ASHIFTL":
            memory[addr] = "10" + "00"
            addr = addr + 1
            cur_pointer = cur_pointer + 1
    #data
    cur_pointer = cur_pointer + 1
    while cur_pointer <= len(code) - 1:
        memory[eval("0x" + code[cur_pointer])] = "0"*(4 - len(code[cur_pointer+1])) + code[cur_pointer+1]
        cur_pointer = cur_pointer + 2

#写coe文件
with open('main_memory.coe', 'w') as f:
    f.write("memory_initialization_radix=16;\n")
    f.write("memory_initialization_vector=\n")
    for i in range(len(memory)):
        if i != len(memory)-1:
            f.write(memory[i] + ",")
        else:
            f.write(memory[i] + ";")