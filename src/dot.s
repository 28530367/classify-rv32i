.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            
    li t1, 0

    slli a3, a3, 2
    slli a4, a4, 2

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation

    lw t2, 0(a0)
    lw t3, 0(a1)

    # t0 = sum(arr0[i * stride0] * arr1[i * stride1])
    # Prologue
    addi sp, sp, -12
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw ra, 8(sp)

    mv a0, t2
    mv a1, t3
    jal ra mul_func
    add t0, t0, a0

    # Epilogue
    lw a0, 0(sp)
    lw a1, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12

    add a0, a0, a3
    add a1, a1, a4

    addi t1, t1, 1
    j loop_start

loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit

# input a0, a1
# output a0
mul_func:
    # Prologue
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

    #initialize
    li s0, 0
mul_loop:
    andi s1, a1, 1
    beqz s1, skip_add

    add s0, s0, a0
skip_add:
    slli a0, a0, 1
    srli a1, a1, 1
    bnez a1, mul_loop

    mv a0, s0

    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8

    ret
    