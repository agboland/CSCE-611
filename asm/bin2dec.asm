
.global main

.text

main:


 # Get input from GPIO into s8
 csrrw s8, 0, x0 # 2 for HEX, 0 for SW
 
 
 
 
 ################ Perform binary to decimal conversion
 
 # Get Hex value 1 into s1
 addi t1, x0, 28 # Store shift amount
 sll t0, s8, t1 # Shift left 28 bits
 srl s1, t0, t1 # Shift right 28 bits
 
 # Get Hex value 2 into s2
 addi t1, x0, 24 # Store shift amount
 sll t0, s8, t1 # Shift left 24 bits
 addi t1, x0, 28 # Store shift amount
 srl s2, t0, t1 # Shift right 28 bits
 
 
 # Convert Hex value 1 s1 into decimal
 addi t0, x0, 1 # Multiply amount
 mul s1, s1, t0 # Lower multiply
 
 # Convert Hex value 1 s1 into decimal
 addi t0, x0, 16 # Multiply amount
 mul s2, s3, t0 # Lower multiply
 
 
 # Add Hex values together
 # or s0, s0, s1 # Add hex val one to the display
 add s0, s1, s2 # Add hex val 1 and 2
 
 
 
 # Output s0 to HEX displays
 csrrw x0, 2, s0
 
