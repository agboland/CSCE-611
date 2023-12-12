#Project 1
#Collin Bollinger
#Andrew Boland

#Load integer into t0 and convert to (18, 14) format *(27, 5)
addi t0, x0, 100
slli t0, t0, 5

#Initialize guess and step and convert to (27, 5) format
addi s0, x0, 0
addi s1, x0, 256
slli s1, s1, 5

loop:
    #Load 0 into t1 and check if step is 0, finish and go to print if step is 0
    addi t1, x0, 0
    beq t1, s1 print
    
    #Square the guess
    mulh t1, s0, s0
    mul t2, s0, s0
    slli t1, t1, 27
    srli t2, t2, 5
    or t1, t1, t2
    
    #Check if guess squared is equal to desired value
    beq t1, t0, print
    
    #Check if guess should be increased or decreased by step
    bge t1, t0, else
        add s0, s0, s1
        jal exit
    else:
        sub s0, s0, s1
    exit:
    
    #Divide step by 2
    addi t2, x0, 2
    srli s1, s1, 1
    
    jal loop
    
print:    
    #Get the integer from console
    add a0, s0, x0
    
    li a7, 1
    ecall
    
