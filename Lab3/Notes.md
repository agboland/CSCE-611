# Opcodes for commands

## R-Type Instructions:

1. `add`: Opcode = 0110011 (funct7 = 0000000, funct3 = 000)
2. `sub`: Opcode = 0110011 (funct7 = 0100000, funct3 = 000)
3. `mul`: Opcode = 0110011 (funct7 = 0000001, funct3 = 000)
4. `mulh`: Opcode = 0110011 (funct7 = 0000001, funct3 = 001)
5. `mulhu`: Opcode = 0110011 (funct7 = 0000001, funct3 = 010)
6. `slt`: Opcode = 0110011 (funct7 = 0000000, funct3 = 010)
7. `sltu`: Opcode = 0110011 (funct7 = 0000000, funct3 = 011)
8. `and`: Opcode = 0110011 (funct7 = 0000000, funct3 = 111)
9. `or`: Opcode = 0110011 (funct7 = 0000000, funct3 = 110)
10. `xor`: Opcode = 0110011 (funct7 = 0000000, funct3 = 100)
11. `sll`: Opcode = 0110011 (funct7 = 0000000, funct3 = 001)
12. `srl`: Opcode = 0110011 (funct7 = 0000000, funct3 = 101)
13. `sra`: Opcode = 0110011 (funct7 = 0100000, funct3 = 101)
14. `cssrw`: Opcode = 1110011 (funct3 = 001, funct12 = 01000)

## I-Type Instructions: 

15. `addi`: Opcode = 0010011 (funct3 = 000)
16. `andi`: Opcode = 0010011 (funct3 = 111)
17. `ori`: Opcode = 0010011 (funct3 = 110)
18. `sori`: Opcode = 0010011 (funct3 = 110)

## Shift Instructions (S-Type): 

19. `slli`: Opcode = 0010011 (funct3 = 001)
20. `srai`: Opcode = 0010011 (funct3 = 101)
21. `srli`: Opcode = 0010011 (funct3 = 101)

## U-Type Instructions: 

22. `lui`: Opcode = 0110111
