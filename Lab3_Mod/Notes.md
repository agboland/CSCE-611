
Ignore this:



# Set up registers
li t0, 0       # t0 will store the BCD result
li t1, 10      # t1 will be used for multiplication by 10
li t2, 0x3333  # t2 holds a mask to isolate lower nibble
li t3, 0x5555  # t3 holds a mask to isolate upper nibble

# Binary to BCD conversion (unrolled loop)
mv t4, s8      # Copy input value to t4

# Iteration 1
mul t5, t4, t1   # Multiply by 10
and t5, t5, t2   # Extract lower nibble
and t5, t5, t3   # Adjust for BCD
add t0, t0, t5   # Add the extracted nibble to the result
slli t0, t0, 4   # Shift the BCD result to the left

# Iteration 2
mul t5, t4, t1   # Multiply by 10
and t5, t5, t2   # Extract lower nibble
and t5, t5, t3   # Adjust for BCD
add t0, t0, t5   # Add the extracted nibble to the result
slli t0, t0, 4   # Shift the BCD result to the left

# Iteration 3
mul t5, t4, t1   # Multiply by 10
and t5, t5, t2   # Extract lower nibble
and t5, t5, t3   # Adjust for BCD
add t0, t0, t5   # Add the extracted nibble to the result
slli t0, t0, 4   # Shift the BCD result to the left

# Iteration 4
mul t5, t4, t1   # Multiply by 10
and t5, t5, t2   # Extract lower nibble
and t5, t5, t3   # Adjust for BCD
add t0, t0, t5   # Add the extracted nibble to the result
slli t0, t0, 4   # Shift the BCD result to the left

# At this point, the BCD value should be in t0
