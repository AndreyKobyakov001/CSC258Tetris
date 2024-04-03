square: 
#Universally the same; rotations don't impact it
    # tetromino heights
    li $s3, 2
    li $s4, 2
    li $s5, -1
    li $s6, -1
    #Rotations: none
    
    li $t1, 0xfaeb36
    addi $t0, $t0, 820
    #820 centres this; do not interfere. 
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1008
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    j draw_exit
    # j next
    
 line:
    #2 rotations.
    beq $s7, 0, line0
    beq $s7, 2, line0
    beq $s7, 1, line90
    beq $s7, 3, line90
    j draw_exit

 t_block:
    beq $s7, 0, t_block0
    beq $s7, 1, t_block90
    beq $s7, 2, t_block180
    beq $s7, 3, t_block270
    j draw_exit
     
 squiggle_1:
    beq $s7, 0, squiggle_10
    beq $s7, 2, squiggle_10
    beq $s7, 1, squiggle_190
    beq $s7, 3, squiggle_190
     # tetromino heights
    j draw_exit 
 squiggle_2:
    beq $s7, 0, squiggle_20
    beq $s7, 2, squiggle_20
    beq $s7, 1, squiggle_290
    beq $s7, 3, squiggle_290 
    j draw_exit 

 l_right:
    beq $s7, 0, l_right0
    beq $s7, 1, l_right90
    beq $s7, 2, l_right180
    beq $s7, 3, l_right270
    j draw_exit
    
 l_left:
    beq $s7, 0, l_left0
    beq $s7, 1, l_left90
    beq $s7, 2, l_left180
    beq $s7, 3, l_left270
    j draw_exit
     # tetromino heights


line0:
    # tetromino heights
    li $s3, 1
    li $s4, 1
    li $s5, 1
    li $s6, 1
    #Rotations: 1 -1 -1 -1
    # 1 1 1 1
    # 1 -1 -1 -1
    
    li $s3, 1 # tetromino is 1 square tall
    li $t1, 0x00ffff
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    jr $ra
    # j next
line90:
    # tetromino heights
    li $s3, 1
    li $s4, -1
    li $s5, -1
    li $s6, -1
    #Rotations: 1 -1 -1 -1
    # 1 1 1 1
    # 1 -1 -1 -1
    
    li $s3, 1 # tetromino is 1 square tall
    li $t1, 0x00ffff
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    jr $ra
    # j next
t_block0:
 # tetromino heights
    li $s3, 1
    li $s4, 2
    li $s5, 1
    li $s6, -1
    #Rotations
    # 3 2 -1 -1
    # 2 2 2 -1
    # 2 3 -1 -1
    
    li $s3, 2 # tetromino is 2 squares tall
    li $t1, 0x70369d
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1008
    li $t2, 4 
    jal draw_square
    jr $ra
    # j next
    
t_block90:
 # tetromino heights
    li $s3, 3
    li $s4, 2
    li $s5, -1
    li $s6, -1
    #Rotations
    # 3 2 -1 -1
    # 2 2 2 -1
    # 2 3 -1 -1
    
    li $s3, 2 # tetromino is 2 squares tall
    li $t1, 0x70369d
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1008
    li $t2, 4 
    jal draw_square
    jr $ra
    # j next
    
t_block180:
 # tetromino heights
    li $s3, 2
    li $s4, 2
    li $s5, 2
    li $s6, -1
    #Rotations
    # 3 2 -1 -1
    # 2 2 2 -1
    # 2 3 -1 -1
    
    li $s3, 2 # tetromino is 2 squares tall
    li $t1, 0x70369d
    addi $t0, $t0, 836
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1008
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    jr $ra
    # j next
    
t_block270:
 # tetromino heights
    li $s3, 2
    li $s4, 3
    li $s5, -1
    li $s6, -1
    #Rotations
    # 3 2 -1 -1
    # 2 2 2 -1
    # 2 3 -1 -1
    
    li $s3, 2 # tetromino is 2 squares tall
    li $t1, 0x70369d
    addi $t0, $t0, 836
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1008
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    jr $ra
    # j next
    

squiggle_10:
    li $s3, 2
    li $s4, 3
    li $s5, -1
    li $s6, -1
    #Rotations
    # 2 2 2 -1 
    # 2 3 -1 -1
    # 2 2 2 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0xe81416
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1008
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1008
    li $t2, 4 
    jal draw_square
    jr $ra
squiggle_190:
    li $s3, 2
    li $s4, 2
    li $s5, 1
    li $s6, -1
    #Rotations
    # 2 2 2 -1 
    # 2 3 -1 -1
    # 2 2 2 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0xe81416
    addi $t0, $t0, 836
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 976
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    jr $ra
    

 squiggle_20:
     # tetromino heights
    li $s3, 3
    li $s4, 2
    li $s5, -1
    li $s6, -1
    #Rotations
    # 2 2 2 -1 
    # 3 2 -1 -1
    # 2 2 2 -1
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0x79c314
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    jr $ra
    # j next

 squiggle_290:
     # tetromino heights
    li $s3, 1
    li $s4, 2
    li $s5, 2
    li $s6, -1
    #Rotations
    # 2 2 2 -1 
    # 3 2 -1 -1
    # 2 2 2 -1
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0x79c314
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    jr $ra
    # j next
 
l_right0:
     # tetromino heights
    li $s3, 1
    li $s4, 3
    li $s5, -1
    li $s6, -1
    #Rotations:
    # 2 2 2 -1 
    # 3 3 -1 -1
    # 2 1 1 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0x0339f8
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    j draw_exit 
l_right90:
     # tetromino heights
    li $s3, 2
    li $s4, 2
    li $s5, 2
    li $s6, -1
    #Rotations:
    # 2 2 2 -1 
    # 3 3 -1 -1
    # 2 1 1 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0x0339f8
    addi $t0, $t0, 848
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 976
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    j draw_exit
    # j next
l_right180:
     # tetromino heights
    li $s3, 3
    li $s4, 3
    li $s5, -1
    li $s6, -1
    #Rotations:
    # 2 2 2 -1 
    # 3 3 -1 -1
    # 2 1 1 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0x0339f8
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    j draw_exit
    # j next
l_right270:
     # tetromino heights
    li $s3, 2
    li $s4, 1
    li $s5, 1
    li $s6, -1
    #Rotations:
    # 2 2 2 -1 
    # 3 3 -1 -1
    # 2 1 1 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0x0339f8
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 976
    li $t2, 4 
    jal draw_square
    j draw_exit
    # j next
 l_left0:
    li $s3, 3
    li $s4, 1
    li $s5, -1
    li $s6, -1
    #Rotations
    # 1 1 2 -1
    # 3 3 -1 -1
    # 2 2 2 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0xffa500
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1008
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    j draw_exit
l_left90:
    li $s3, 1
    li $s4, 1
    li $s5, 2
    li $s6, -1
    #Rotations
    # 1 1 2 -1
    # 3 3 -1 -1
    # 2 2 2 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0xffa500
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    j draw_exit
l_left180:
    li $s3, 3
    li $s4, 3
    li $s5, -1
    li $s6, -1
    #Rotations
    # 1 1 2 -1
    # 3 3 -1 -1
    # 2 2 2 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0xffa500
    addi $t0, $t0, 836
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1008
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    j draw_exit
l_left270:
    li $s3, 2
    li $s4, 2
    li $s5, 2
    li $s6, -1
    #Rotations
    # 1 1 2 -1
    # 3 3 -1 -1
    # 2 2 2 -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0xffa500
    addi $t0, $t0, 820
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 1024
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    addi $t0, $t0, 16
    li $t2, 4 
    jal draw_square
    j draw_exit


draw_square:
    li $t2, 4  # Initialize $t2 to 4
    
    # Loop to fill square
    fill_loop:
        sw $t1, 0($t0) 
        sw $t1, 4($t0) 
        sw $t1, 8($t0) 
        sw $t1, 12($t0) 
        add $t0, $t0, 256   # Increment $t0 by 32
        addi $t2, $t2, -1   # Decrement loop counter
        bnez $t2, fill_loop # Branch back to loop if $t2 != 0

    add $t0, $t0, -1024   # Decrement $t0 by 256
    jr $ra
    
