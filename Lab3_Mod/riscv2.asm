	#Register usage:
	#t0: BCD Result
	#t1: Temp for mul and shift
	#t2: Fixed point rep of .1
	#t3-t6 & s1: Temps for whole and frac parts
	#a0: Input val (18-bit bin)


csrrw t0,0x00,x0

#ITERATION 1 ###############################################
	# Initialize t2 w/ fixed-point rep of .1
lui t2,0x19999
addi t2,t2,0x999
	
	#Mul by fixed-point .1
mul t1,a0,t2
srl t3,t1,32	#extract the whole part of the result

	#Mul whole part by 10 and sub from original to get frac part
lui t6,0		#load upper 20bits of 10
addi t6,t6,10		#add lower 12 bits of 10
mul t4,t3,t6		#whole part * 10
sub t5,a0,t4		#original 

	#Scale frac part by 10 to get the digit
mul s1,t5,t6

	#Shift left bcd result and add the new digit
sll t0,t0, 4
or t0,t0,s1

	#Prep next input val
add a0,t3,zero


#ITERATION 2 ###############################################
	#Mul by fixed-point .1
mul t1,a0,t2
srl t3,t1,32	#extract the whole part of the result

	#Mul whole part by 10 and sub from original to get frac part
lui t6,0		#load upper 20bits of 10
addi t6,t6,10		#add lower 12 bits of 10
mul t4,t3,t6		#whole part * 10
sub t5,a0,t4		#original 

	#Scale frac part by 10 to get the digit
mul s1,t5,t6

	#Shift left bcd result and add the new digit
sll t0,t0, 4
or t0,t0,s1

	#Prep next input val
add a0,t3,zero

#ITERATION 3 ###############################################
	#Mul by fixed-point .1
mul t1,a0,t2
srl t3,t1,32	#extract the whole part of the result

	#Mul whole part by 10 and sub from original to get frac part
lui t6,0		#load upper 20bits of 10
addi t6,t6,10		#add lower 12 bits of 10
mul t4,t3,t6		#whole part * 10
sub t5,a0,t4		#original 

	#Scale frac part by 10 to get the digit
mul s1,t5,t6

	#Shift left bcd result and add the new digit
sll t0,t0, 4
or t0,t0,s1

	#Prep next input val
add a0,t3,zero


#ITERATION 4 ###############################################
	#Mul by fixed-point .1
mul t1,a0,t2
srl t3,t1,32	#extract the whole part of the result

	#Mul whole part by 10 and sub from original to get frac part
lui t6,0		#load upper 20bits of 10
addi t6,t6,10		#add lower 12 bits of 10
mul t4,t3,t6		#whole part * 10
sub t5,a0,t4		#original 

	#Scale frac part by 10 to get the digit
mul s1,t5,t6

	#Shift left bcd result and add the new digit
sll t0,t0, 4
or t0,t0,s1

	#Prep next input val
add a0,t3,zero


#ITERATION 5 ###############################################
	#Mul by fixed-point .1
mul t1,a0,t2
srl t3,t1,32	#extract the whole part of the result

	#Mul whole part by 10 and sub from original to get frac part
lui t6,0		#load upper 20bits of 10
addi t6,t6,10		#add lower 12 bits of 10
mul t4,t3,t6		#whole part * 10
sub t5,a0,t4		#original 

	#Scale frac part by 10 to get the digit
mul s1,t5,t6

	#Shift left bcd result and add the new digit
sll t0,t0, 4
or t0,t0,s1

	#Prep next input val
add a0,t3,zero


#ITERATION 6 ###############################################
	#Mul by fixed-point .1
mul t1,a0,t2
srl t3,t1,32	#extract the whole part of the result

	#Mul whole part by 10 and sub from original to get frac part
lui t6,0		#load upper 20bits of 10
addi t6,t6,10		#add lower 12 bits of 10
mul t4,t3,t6		#whole part * 10
sub t5,a0,t4		#original 

	#Scale frac part by 10 to get the digit
mul s1,t5,t6

	#Shift left bcd result and add the new digit
sll t0,t0, 4
or t0,t0,s1

	#Prep next input val
add a0,t3,zero


csrrw x0,0x02, t0





