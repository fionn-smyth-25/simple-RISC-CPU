file = open("test.txt", "r")

def to_bin(s):
    binary = bin(int(s))[2:]
    temp = str(binary)
    extension = 8 - len(temp)
    s_extended = (extension * "0") + temp
    return s_extended
    
opcode_map = {
    "ADD": "0000",
    "SUB": "0001",
    "AND": "0010",
    "OR":  "0011",
    "ADDI":"0100",
    "MOVI":"0101",
    "JMP": "0110"
}

reg_map = {
    "r1": "00",
    "r2": "01",
    "r3": "10",
    "r4": "11",
}

try:
    open("asm.txt", "x", encoding="utf-8")
except FileExistsError:
        print("asm.txt already exists, overwriting")
        open("asm.txt", "w", encoding="utf-8")
        
for line in file:
    instr = line.split()[0]
    reg = line.split()[1]
    dest = reg.split(",")[0]
    src = reg.split(",")[1]

    if instr in opcode_map:
        a = opcode_map[instr]
    
    if dest in reg_map:
        b = reg_map[dest]
        
    if src in reg_map:
        c = reg_map[src]
        d = "00000000"
    else:
        c = "00"  
        d = to_bin(src)
        
    with open("asm.txt", "a", encoding="utf-8") as f:
        f.write(a + b + c + d + "\n")
               
file.close()