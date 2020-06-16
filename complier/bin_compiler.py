#盘古V2.0汇编语言编译器
#语句格式示例如下，INSTRUCTIONS后为代码区，DATA后为数据区，先输入数据地址，打一个空格，再输入数据的值
#所有的地址，数据均为16位。可以不写全，如0064可以直接写64
#此代码最终输出的coe是二进制的
'''
INSTRUCTIONS:
LOAD 8A
DATA:
8A 0064
'''



#初始化coe文件内存
memory = ["0000000000000000" for i in range(256)]
#当前写内存的地址
addr = 0
cur_pointer = 1
with open('code.txt', 'r') as f:
    temp = f.read()
    code = temp.split()
    #instruction
    while code[cur_pointer] != "DATA:":
        if code[cur_pointer] == "STORE":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00000001" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "LOAD":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00000010" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "ADD":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00000011" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "SUB":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00000100" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "JMPGEZ":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00000101" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "JMP":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00000110" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "HALT":
            memory[addr] = "00000111" + "00000000"
            addr = addr + 1
            cur_pointer = cur_pointer + 1
        elif code[cur_pointer] == "MPY":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00001000" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "DIV":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00001001" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "AND":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00001010" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "OR":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00001011" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "NOT":
            temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
            memory[addr] = "00001100" + "0"*(8 - len(temp)) + temp
            addr = addr + 1
            cur_pointer = cur_pointer + 2
        elif code[cur_pointer] == "SHIFTR":
            memory[addr] = "00001101" + "00000000"
            addr = addr + 1
            cur_pointer = cur_pointer + 1
        elif code[cur_pointer] == "SHIFTL":
            memory[addr] = "00001110" + "00000000"
            addr = addr + 1
            cur_pointer = cur_pointer + 1
    #data
    cur_pointer = cur_pointer + 1
    while cur_pointer <= len(code) - 1:
        temp = bin(eval("0x" + code[cur_pointer+1]))[2:]
        memory[eval("0x" + code[cur_pointer])] = "0"*(16 - len(temp)) + temp
        cur_pointer = cur_pointer + 2

#写coe文件
with open('main_memory.coe', 'w') as f:
    f.write("memory_initialization_radix=2;\n")
    f.write("memory_initialization_vector=\n")
    for i in range(len(memory)):
        if i != len(memory)-1:
            f.write(memory[i] + "," + "\n")
        else:
            f.write(memory[i] + ";" + "\n")
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        