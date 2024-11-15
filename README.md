# Assignment 2: Classify
> This is my GitHub, which includes explaining the functionality of the essential operations and detailing how I addressed and overcame the challenges.

## Result
> After execute `bash ./test.sh all`
```
test_abs_minus_one (__main__.TestAbs.test_abs_minus_one) ... ok
test_abs_one (__main__.TestAbs.test_abs_one) ... ok
test_abs_zero (__main__.TestAbs.test_abs_zero) ... ok
test_argmax_invalid_n (__main__.TestArgmax.test_argmax_invalid_n) ... ok
test_argmax_length_1 (__main__.TestArgmax.test_argmax_length_1) ... ok
test_argmax_standard (__main__.TestArgmax.test_argmax_standard) ... ok
test_chain_1 (__main__.TestChain.test_chain_1) ... ok
test_classify_1_silent (__main__.TestClassify.test_classify_1_silent) ... ok
test_classify_2_print (__main__.TestClassify.test_classify_2_print) ... ok
test_classify_3_print (__main__.TestClassify.test_classify_3_print) ... ok
test_classify_fail_malloc (__main__.TestClassify.test_classify_fail_malloc) ... ok
test_classify_not_enough_args (__main__.TestClassify.test_classify_not_enough_args) ... ok
test_dot_length_1 (__main__.TestDot.test_dot_length_1) ... ok
test_dot_length_error (__main__.TestDot.test_dot_length_error) ... ok
test_dot_length_error2 (__main__.TestDot.test_dot_length_error2) ... ok
test_dot_standard (__main__.TestDot.test_dot_standard) ... ok
test_dot_stride (__main__.TestDot.test_dot_stride) ... ok
test_dot_stride_error1 (__main__.TestDot.test_dot_stride_error1) ... ok
test_dot_stride_error2 (__main__.TestDot.test_dot_stride_error2) ... ok
test_matmul_incorrect_check (__main__.TestMatmul.test_matmul_incorrect_check) ... ok
test_matmul_length_1 (__main__.TestMatmul.test_matmul_length_1) ... ok
test_matmul_negative_dim_m0_x (__main__.TestMatmul.test_matmul_negative_dim_m0_x) ... ok
test_matmul_negative_dim_m0_y (__main__.TestMatmul.test_matmul_negative_dim_m0_y) ... ok
test_matmul_negative_dim_m1_x (__main__.TestMatmul.test_matmul_negative_dim_m1_x) ... ok
test_matmul_negative_dim_m1_y (__main__.TestMatmul.test_matmul_negative_dim_m1_y) ... ok
test_matmul_nonsquare_1 (__main__.TestMatmul.test_matmul_nonsquare_1) ... ok
test_matmul_nonsquare_2 (__main__.TestMatmul.test_matmul_nonsquare_2) ... ok
test_matmul_nonsquare_outer_dims (__main__.TestMatmul.test_matmul_nonsquare_outer_dims) ... ok
test_matmul_square (__main__.TestMatmul.test_matmul_square) ... ok
test_matmul_unmatched_dims (__main__.TestMatmul.test_matmul_unmatched_dims) ... ok
test_matmul_zero_dim_m0 (__main__.TestMatmul.test_matmul_zero_dim_m0) ... ok
test_matmul_zero_dim_m1 (__main__.TestMatmul.test_matmul_zero_dim_m1) ... ok
test_read_1 (__main__.TestReadMatrix.test_read_1) ... ok
test_read_2 (__main__.TestReadMatrix.test_read_2) ... ok
test_read_3 (__main__.TestReadMatrix.test_read_3) ... ok
test_read_fail_fclose (__main__.TestReadMatrix.test_read_fail_fclose) ... ok
test_read_fail_fopen (__main__.TestReadMatrix.test_read_fail_fopen) ... ok
test_read_fail_fread (__main__.TestReadMatrix.test_read_fail_fread) ... ok
test_read_fail_malloc (__main__.TestReadMatrix.test_read_fail_malloc) ... ok
test_relu_invalid_n (__main__.TestRelu.test_relu_invalid_n) ... ok
test_relu_length_1 (__main__.TestRelu.test_relu_length_1) ... ok
test_relu_standard (__main__.TestRelu.test_relu_standard) ... ok
test_write_1 (__main__.TestWriteMatrix.test_write_1) ... ok
test_write_fail_fclose (__main__.TestWriteMatrix.test_write_fail_fclose) ... ok
test_write_fail_fopen (__main__.TestWriteMatrix.test_write_fail_fopen) ... ok
test_write_fail_fwrite (__main__.TestWriteMatrix.test_write_fail_fwrite) ... ok

----------------------------------------------------------------------
Ran 46 tests in 56.370s

OK
```
## Part A: Mathematical Functions
> My functions include dot product, matrix multiplication, element-wise ReLU, and argmax.

### Task 1: ReLU
> Traverse all the values in a one-dimensional array and check each value one by one to determine if it is less than zero. If a value is less than zero, replace it with zero. Once all the values have been checked, exit the function.

### Task 2: ArgMax
> First, `t0` is set to the first element of the one-dimensional array. `t6` is used to retrieve the next element. Check if `t0` is greater than or equal to `t6`. If `t0` is greater than or equal to `t6`, `t0` remains unchanged, and `t6` continues to retrieve the next element. When `t6` becomes greater than `t0`, the value of `t6` replaces `t0`, and `t1` is used to store the index of `t6` in the one-dimensional array. After `t6` has traversed all elements of the array, `a0` takes the value of `t1` (the index of the maximum value). Finally, the function exits.

### Task 3.1: Dot Product
> mul_func & dot
#### mul_func
```
# input a0, a1
# output a0
mul_func:
    # Prologue
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

    #initialize
    li s0, 0    # temp result
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
```
> Same as 'a0 = a0 * a1'. The algorithm is like 
```
a0 == 10111
a1 == 00011

        10111
    *   00011
    ---------
        10111
    +  101110
    ---------
    = 1000101
```
> The process is similar to decimal multiplication but works in binary.
Multiply the bits of `a1` by `a0`, starting from the least significant bit (rightmost bit) of `a1`.
For each bit in `a1`:
If the bit is `1`, write down `a0` shifted left by the position of the bit.
Sum up all the results of the shifted values.

#### dot
> First, I calculate the Skip address in the first array and the Skip address in the second array to determine the address of the next number in each iteration of the loop. In each loop, the value at the respective position is multiplied using my `mul_func` function, and the result is added to `t0` (the temporary result). When the counter (`t1`) equals the Number of elements to process, the value in `t0` is stored in `a0`, and the function exits.

### Task 3.2: Matrix Multiplication
```
inner_loop_end:
    # TODO: Add your own implementation
    addi s0, s0, 1
    slli t2, a2, 2
    add s3, s3, t2
    j outer_loop_start

outer_loop_end:
    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28

    jr ra
```
> Based on the existing code, I need to design the `inner_loop_end:` and `outer_loop_end:` labels.

It is also clear that after `inner_loop_end:`, the program should jump to outer_loop_start: to execute the next iteration of the loop. At this point, I need to increment the counter `s0` by `1` and calculate the addresses for the matrix elements `a21, a31, a41, ..., am1` (for a matrix `A(m*n)`) to prepare for the next iteration of the inner loop.

When entering `outer_loop_end:`, I need to restore all s registers to their original state and then exit the function.
