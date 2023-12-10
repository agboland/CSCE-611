
Ignore this:



lui t0, 0x19        # Load 10 into t0 (upper immediate for 10)
    addi t0, t0, -10    # Complete loading 10 into t0 (lower immediate)
    li t1, 0            # Initialize t1 to store the BCD result

    # Iteration 1
    slli t1, t1, 4      # Shift BCD result left by 4 bits

    mul t2, s8, t0      # Multiply s8 by 10
    srai t2, t2, 31     # t2 = (s8 * 10) >> 31

    add t1, t1, t2      # Add (s8 * 10) >> 31 to BCD result

    # Iteration 2
    slli t1, t1, 4

    mul t2, s8, t0
    srai t2, t2, 31

    add t1, t1, t2

    # Iteration 3 (repeat the same steps for remaining iterations)
    slli t1, t1, 4

    mul t2, s8, t0
    srai t2, t2, 31

    add t1, t1, t2

    slli t1, t1, 4

    mul t2, s8, t0
    srai t2, t2, 31

    add t1, t1, t2

    slli t1, t1, 4

    mul t2, s8, t0
    srai t2, t2, 31

    add t1, t1, t2

    slli t1, t1, 4

    mul t2, s8, t0
    srai t2, t2, 31

    add t1, t1, t2

    slli t1, t1, 4

    mul t2, s8, t0
    srai t2, t2, 31

    add t1, t1, t2

    slli t1, t1, 4

    mul t2, s8, t0
    srai t2, t2, 31

    add t1, t1, t2
