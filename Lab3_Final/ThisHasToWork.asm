# Initialization
addi t0, x0, 0x3eb  # Initialize t0 to 256994
slli t0, t0, 8
addi t0, t0, 0xe2

# Initialize BCD storage in s0
add s0, x0, x0  # Initialize s0 to 0

csrrw t0, 0, x0  # Get the value from switches

# Load the fixed-point value of "0.1" with 32 fractional bits into t3
addi t3, x0, 0x0c
slli t3, t3, 8
addi t3, t3, 0xcc
slli t3, t3, 8
addi t3, t3, 0xcc
slli t3, t3, 8
addi t3, t3, 0xcd

#--------------------------------BCD digit 1
mulhu s2, t0, t3 
slli s2, s2, 1

mul s3, t0, t3
srli s3, s3, 31 # get the single MSB

add s2, s2, s3 #add either a 1 bi or 0 bit
addi t4, x0, 0xa
add t6, s2, x0 # store the value to update t0
mul s4, s2, t4 # Multiply by 10

sub s5, t0, s4 # get bcd digit
addi t0, t6, 0

or s6, x0, s5 # Store to bcd ouput


#--------------------------------BCD digit 2
mulhu s2, t0, t3 
slli s2, s2, 1

mul s3, t0, t3
srli s3, s3, 31 # get the single MSB

add s2, s2, s3 #add either a 1 bi or 0 bit
addi t4, x0, 0xa
add t6, s2, x0 # store the value to update t0
mul s4, s2, t4 # Multiply by 10

sub s5, t0, s4 # get bcd digit
addi t0, t6, 0

slli s5, s5, 4
or s6, s6, s5 # Store to bcd ouput

#--------------------------------BCD digit 3
mulhu s2, t0, t3 
slli s2, s2, 1

mul s3, t0, t3
srli s3, s3, 31 # get the single MSB

add s2, s2, s3 #add either a 1 bi or 0 bit
addi t4, x0, 0xa
add t6, s2, x0 # store the value to update t0
mul s4, s2, t4 # Multiply by 10

sub s5, t0, s4 # get bcd digit
addi t0, t6, 0

slli s5, s5, 8
or s6, s6, s5 # Store to bcd ouput

#--------------------------------BCD digit 4
mulhu s2, t0, t3 
slli s2, s2, 1

mul s3, t0, t3
srli s3, s3, 31 # get the single MSB

add s2, s2, s3 #add either a 1 bi or 0 bit
addi t4, x0, 0xa
add t6, s2, x0 # store the value to update t0
mul s4, s2, t4 # Multiply by 10

sub s5, t0, s4 # get bcd digit
addi t0, t6, 0

slli s5, s5, 12
or s6, s6, s5 # Store to bcd ouput

#--------------------------------BCD digit 5
mulhu s2, t0, t3 
slli s2, s2, 1

mul s3, t0, t3
srli s3, s3, 31 # get the single MSB

add s2, s2, s3 #add either a 1 bi or 0 bit
addi t4, x0, 0xa
add t6, s2, x0 # store the value to update t0
mul s4, s2, t4 # Multiply by 10

sub s5, t0, s4 # get bcd digit
addi t0, t6, 0

slli s5, s5, 16
or s6, s6, s5 # Store to bcd ouput


#--------------------------------BCD digit 6
mulhu s2, t0, t3 
slli s2, s2, 1

mul s3, t0, t3
srli s3, s3, 31 # get the single MSB

add s2, s2, s3 #add either a 1 bi or 0 bit
addi t4, x0, 0xa
add t6, s2, x0 # store the value to update t0
mul s4, s2, t4 # Multiply by 10

sub s5, t0, s4 # get bcd digit
addi t0, t6, 0

slli s5, s5, 20
or s6, s6, s5 # Store to bcd ouput

#--------------------------------BCD digit 7
mulhu s2, t0, t3 
slli s2, s2, 1

mul s3, t0, t3
srli s3, s3, 31 # get the single MSB

add s2, s2, s3 #add either a 1 bi or 0 bit
addi t4, x0, 0xa
add t6, s2, x0 # store the value to update t0
mul s4, s2, t4 # Multiply by 10

sub s5, t0, s4 # get bcd digit
addi t0, t6, 0

slli s5, s5, 24
or s6, s6, s5 # Store to bcd ouput

#--------------------------------BCD digit 8
mulhu s2, t0, t3 
slli s2, s2, 1

mul s3, t0, t3
srli s3, s3, 31 # get the single MSB

add s2, s2, s3 #add either a 1 bi or 0 bit
addi t4, x0, 0xa
add t6, s2, x0 # store the value to update t0
mul s4, s2, t4 # Multiply by 10

sub s5, t0, s4 # get bcd digit
addi t0, t6, 0

slli s5, s5, 28
or s6, s6, s5 # Store to bcd ouput


csrrw x0, 2, s6  # Display s6 the bcd result
