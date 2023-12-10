.global main

.text

main:
lui t2, 5
lui t3, 5

 add t1, t2, t3
 sub t1, t2, t3
 and t1, t2, t3
 or t1, t2, t3
 xor t1, t2, t3
 sll t1, t2, t3
 sra t1, t2, t3
 srl t1, t2, t3
 slt t1, t2, t3
 sltu t1, t2, t3
 mul t1, t2, t3
 mulh t1, t2, t3
 mulhu t1,t2, t3
 
 addi t1, x0, 3 

 #csrrw x0, 2, x19
