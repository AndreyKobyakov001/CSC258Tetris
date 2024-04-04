################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Andrey Kobyakov, No.1009050660
# Student 2: Greatman Nkwachukwu Okonkwo, No. 1008817005
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       1
# - Unit height in pixels:      1
# - Display width in pixels:    64
# - Display height in pixels:   64
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

.data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################
backup:    .space  16384       # allocate space to copy over entire bitmap display
tetromino_dims: .align 4 .space  60       # allocate space to copy over entire bitmap display
x_pos: .word 0  # Initialize x position to 0
y_pos: .word 4  # Initialize y position to 4 (to leave some space from the top)
##############################################################################
# Code
##############################################################################
.text
	#Colours:
	# red: .word 0xe81416      #Squiggle1
	# org: .word 0xffa500      #LeftL
	# ylw: .word 0xfaeb36      #Square
	# grn: .word 0x79c314      #Squiggle2
	# cyn: .word 0x487de7      #Line
	# blu: .word 0x0339f8      #RightL
	# ppl: .word 0x70369d      #T 

#Add code to generate each tetromino as it spawns. 
	.globl main

	# Run the Tetris game. 

li $s0, 820 # x offset of current tetromino
li $s1, 0 # y offset of current tetromino
la $s2, tetromino_dims
li $s3, 0
li $s4, 1
li $s5, 2
li $s6, 3
li $s7, -1

draw_scene:
    #Initialization START
    lw $t0, ADDR_DSPL
    li $t1, 0xff0000
    sw $t1, 0($t0)
    sw $t1, 16380($t0) 
    add $t0, $t0, 768
    #144 pixels between them; 36 "blocks"
    #paint(t0), paint(144(t0))
    #t0 add 256; continue 64 times
    # Initialize the game
    li $t1, 0xffffff
    li $t2, 61
    li $t3, 0
    outer_wall_loop:
    # Paint pixels at $t0 and $t0 + 144
    sw $t1, 0($t0)      # Paint at $t0
    sw $t1, 148($t0)    # Paint at $t0 + 144
    
    # Increment $t0 by 256 to move to the next block
    addi $t0, $t0, 256
    # Decrement loop counter
    
    addi $t2, $t2, -1
    bnez $t2, outer_wall_loop      # Branch back to loop if $t2 != 0
    
    sub $t0, $t0, 108 
    li $t2, 37
    sw $t1, 0($t0)
    
    bottom_wall_loop: 
    sw $t1, 0($t0)    # Paint at $t0 + 144
    # Increment $t0 by 256 to move to the next block
    sub $t0, $t0, 4
    # Decrement loop counter
    addi $t2, $t2, -1
    bnez $t2, bottom_wall_loop      # Branch back to loop if $t2 != 0
    
    li $t1, 0x222222 
    lw $t0, ADDR_DSPL
    addi $t0, $t0, 772
    sw $t1, 0($t0)
    #repeat 16 times: 
    #paint offset, 0, 4, 8, 12 blue, then skip 16, and repeat. when equal to 144, skip 112, and paint again, 3 times like this. 
    
    li $t5, 8              # Set loop counter for outer_loop2
    outer_loop2:
    li $t4, 4           # Reset loop counter for outer loop
    li $t6, 1024        # Set increment value for $t0 between iterations
    
    outer_loop:
        li $t2, 5        # Set loop counter to 5 for the inner loop
        
        new_loop: 
            sw $t1, 0($t0) 
            sw $t1, 4($t0) 
            sw $t1, 8($t0) 
            sw $t1, 12($t0)
            beq $t2, 1, no_black1
            sw $t3, 16($t0) 
            sw $t3, 20($t0) 
            sw $t3, 24($t0) 
            sw $t3, 28($t0)
            no_black1:
            add $t0, $t0, 32   # Increment $t0 by 32
            addi $t2, $t2, -1  # Decrement loop counter
            bnez $t2, new_loop # Branch back to loop if $t2 != 0
        
        # Increment $t0 by 96 between sub-loops
        add $t0, $t0, 96
        
        # Decrement the outer loop counter
        addi $t4, $t4, -1
        bnez $t4, outer_loop # Branch back to outer loop if $t4 != 0
    
    # Augment $t0 by 1024 between iterations
    add $t0, $t0, $t6

    # Decrement the outer loop counter
    addi $t5, $t5, -1
    bnez $t5, outer_loop2 # Branch back to outer loop if $t5 != 0
 
    lw $t0, ADDR_DSPL 
    add $t0, $t0, 1796
    li $t5, 7              # Set loop counter for outer_loop2
    outer_loop21:
    li $t4, 4           # Reset loop counter for outer loop
    li $t6, 1024        # Set increment value for $t0 between iterations
    
    outer_loop1:
        li $t2, 5        # Set loop counter to 5 for the inner loop
        
        new_loop1:   
            sw $t3, 0($t0) 
            sw $t3, 4($t0) 
            sw $t3, 8($t0) 
            sw $t3, 12($t0)
            beq $t2, 1, no_grey
            sw $t1, 16($t0) 
            sw $t1, 20($t0) 
            sw $t1, 24($t0) 
            sw $t1, 28($t0) 
            no_grey:
            add $t0, $t0, 32   # Increment $t0 by 32
            addi $t2, $t2, -1  # Decrement loop counter
            bnez $t2, new_loop1 # Branch back to loop if $t2 != 0
        
        # Increment $t0 by 96 between sub-loops
        add $t0, $t0, 96
        
        # Decrement the outer loop counter
        addi $t4, $t4, -1
        bnez $t4, outer_loop1 # Branch back to outer loop if $t4 != 0
    
    # Augment $t0 by 1024 between iterations
    add $t0, $t0, $t6

    # Decrement the outer loop counter
    addi $t5, $t5, -1
    bnez $t5, outer_loop21 # Branch back to outer loop if $t5 != 0
    
score_board:
    #Initializes empty scoreboard aligned at pixels 1452, 1472, 1492, 1512 - 4*8 displays to be turned into 7-segment score indicators from 0000 to 9999
    li $t1, 0xffffff
    lw $t0, ADDR_DSPL
    addi $t0, $t0, 1452
    li $t4, 2
    new_loop3:        
        li $t3, 4        # Set loop counter to 5 for the inner loop
        new_loop2: 
            li $t2, 4 
            jal draw_square
            addi $t3, $t3, -1  # Decrement loop counter
            addi $t0, $t0, 20
            bnez $t3, new_loop2 # Branch back to loop if $t2 != 0
            addi $t4, $t4, -1  # Decrement loop counter
        addi $t0, $t0, 944
        bnez $t4, new_loop3 # Branch back to loop if $t2 != 0
        
    jal copy_display
    #INITIALIZATION END
    
draw_random_tetrominoe:
    #If the area where it would spawn, which is 820 pixels, is not grey, game over; no new pieces can spawn, as the spawning position is occupied.
    sw $s3, 56($s2)
    lw $t0, ADDR_DSPL
    li $v0, 42
    li $a0, 0
    li $a1, 7
    syscall
    #for each s press, add 1024 to $t0
    #for each a/s press, -/+ 16 to $t0, respectively
    draw_loop:       
        lw $t0, ADDR_DSPL
        add $t0, $t0, $s1
        add $t0, $t0, $s0
        
        beq $a0, 1, square
        beq $a0, 2, line
        beq $a0, 3, t_block
        beq $a0, 4, squiggle_1
        beq $a0, 5, squiggle_2
        beq $a0, 6, l_right
        beq $a0, 0, l_left
        draw_exit:
        jal bottom_wall_collision
        lw $t1, ADDR_KBRD               # $t0 = base address for keyboard
        lw $t8, 0($t1)                  # Load first word from keyboard
        beq $t8, 1, keyboard_input      # If first word 1, key is pressedww
        addi $t0, $t0, 0
        after_keyboard_input:
        addi $s1, $s1, 256     # y offset 256 * lines to drop down by
        sw $s3, 52($s2)
        j MusicLoop
        bottom_collision:
        jal is_game_over
        li $s0, 820
        li $s1, 0
        jal copy_display
        sw $s4, 52($s2)
        j MusicLoop
    
fill: 
    add $t0, $t0, 916
    sw $t1 0($t0)
    # sw $t1 148($t0) 
    
    li $t4, 61
    outer_end:
        li $t2, 38
        end_loop: 
        sw $t1, 0($t0)    # Paint at $t0 + 144
        # Increment $t0 by 256 to move to the next block
        sub $t0, $t0, 4
        # Decrement loop counter
        addi $t2, $t2, -1
        bnez $t2, end_loop      # Branch back to loop if $t2 != 0
    addi $t4, $t4, -1
    addi $t0, $t0 408
    bnez $t4, outer_end
    jr $ra
    
game_over:
    j game_over
    
is_game_over:
    lw $t8, ADDR_DSPL
    addi $t8, $t8, 772
    li $t2, 36        # Set loop counter to 5 for the inner loop
    li $t6, 0x222222
    li $t7, 0 

    game_over_loop: 
        lw $t9, 0($t8)
        bne $t9, $t6, gm_second_check
        beq $t9, $t6, gm_continue
        gm_second_check:
        bne $t9, $t7, game_over
        gm_continue:
        addi $t8, $t8, 4   # Increment $t0 by 32
        addi $t2, $t2, -1  # Decrement loop counter
        bnez $t2, game_over_loop # Branch back to loop if $t2 != 0
    
    jr $ra
    
keyboard_input:                     # A key is pressed
    addi $t2, $a0, 0
    lw $a0, 4($t1)                  # Load second word from keyboard
    beq $a0, 0x71, quit     # Check if the key q was pressed
    beq $a0, 0x64, right_shift
    beq $a0, 0x77, rotate
    beq $a0, 0x61, left_shift
    #beq $a0, 0x73, down_shift
    
    #keybindings: https://www.rapidtables.com/code/text/ascii-table.html
    #Important one:
    # W 77 (rotate)
    # A 61 (left shift 16)
    # S 73 (down shift 1024)
    # D 64 (right shift 16)
    # [SPACE] 20 (for drop)
    # P 70 (for pause)
    # H 68 (for hold)
    action_complete:
    addi $a0, $t2, 0
    j after_keyboard_input
    
quit:
    lw $t0, ADDR_DSPL
    li $t1, 0xe81418
    jal fill
    
	li $v0, 10                      # Quit gracefully
	syscall
	
rotate:
    lw $t9, 56($s2)
    addi $t9, $t9, 1
    sw $t9, 56($s2)
    j action_complete
	
left_shift:
    jal left_wall_collision
    addi $s0, $s0, -4 # x offset, -4 * lines to shift by
    left_collision:
    j action_complete
	
right_shift:
    jal right_wall_collision
    addi $s0, $s0, 4 # x offset, 4 * lines to shift by
    right_collision:
    j action_complete
    
bottom_wall_collision:
    li $t5, 4
    li $t6, 0x222222
    li $t7, 0   
    
    lw $t9, 0($s2)
    beqz $t9, square1
    
    lw $t3, ADDR_DSPL
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    
    li $t4, 1024
    mul $t4, $t4, $t9
    add $t3, $t3, $t4
    loop0:
        lw $t8, 0($t3)
        bne $t8, $t6, second_check0
        beq $t8, $t6, continue0
        second_check0:
        bne $t8, $t7, bottom_collision
        continue0:
        addi $t3, $t3 4
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop0
        
    square1:
    lw $t9, 4($s2)
    beqz $t9, square2
    
    lw $t3, ADDR_DSPL
    addi $t3, $t3, 16
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    
    li $t4, 1024
    mul $t4, $t4, $t9
    add $t3, $t3, $t4
    li $t5, 4
    loop1:
        lw $t8, 0($t3)
        #sw $t4, 0($t3)
        bne $t8, $t6, second_check1
        beq $t8, $t6, continue1
        second_check1:
        bne $t8, $t7, bottom_collision
        continue1:
        addi $t3, $t3 4
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop1
        
    square2:
    lw $t9, 8($s2)
    beqz $t9, square3
    
    lw $t3, ADDR_DSPL
    addi $t3, $t3, 32
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    
    li $t4, 1024
    mul $t4, $t4, $t9
    add $t3, $t3, $t4
    li $t5, 4
    loop2:
        lw $t8, 0($t3)
        #sw $t4, 0($t3)
        bne $t8, $t6, second_check2
        beq $t8, $t6, continue2
        second_check2:
        bne $t8, $t7, bottom_collision
        continue2:
        addi $t3, $t3 4
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop2
    
    square3:
    lw $t9, 12($s2)
    beqz $t9, end1
    
    lw $t3, ADDR_DSPL
    addi $t3, $t3, 48
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    
    li $t4, 1024
    mul $t4, $t4, $t9
    add $t3, $t3, $t4
    li $t5, 4
    loop3:
        lw $t8, 0($t3)
        #sw $t4, 0($t3)
        bne $t8, $t6, second_check3
        beq $t8, $t6, continue3
        second_check3:
        bne $t8, $t7, bottom_collision
        continue3:
        addi $t3, $t3 4
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop3
        
    end1:
    jr $ra

left_wall_collision:
    li $t5, 4
    li $t6, 0x222222
    li $t7, 0   
    
    lw $t9, 16($s2)
    addi $t9, $t9, 1
    beqz $t9, square4
    addi $t9, $t9, -1
    
    lw $t3, ADDR_DSPL
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    addi $t3, $t3, -4

    loop4:
        lw $t8, 0($t3)
        bne $t8, $t6, second_check4
        beq $t8, $t6, continue4
        second_check4:
        bne $t8, $t7, left_collision
        continue4:
        addi $t3, $t3 256
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop4
        
    square4:
    li $t5, 4
    lw $t9, 20($s2)
    addi $t9, $t9, 1
    beqz $t9, square5
    addi $t9, $t9, -1
    
    lw $t3, ADDR_DSPL
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    addi $t3, $t3, -4
    loop5:
        lw $t8, 0($t3)
        bne $t8, $t6, second_check5
        beq $t8, $t6, continue5
        second_check5:
        bne $t8, $t7, left_collision
        continue5:
        addi $t3, $t3 256
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop5
        
    square5:
    li $t5, 4
    lw $t9, 24($s2)
    addi $t9, $t9, 1
    beqz $t9, square6
    addi $t9, $t9, -1
    
    lw $t3, ADDR_DSPL
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    addi $t3, $t3, -4
    loop6:
        lw $t8, 0($t3)
        bne $t8, $t6, second_check6
        beq $t8, $t6, continue6
        second_check6:
        bne $t8, $t7, left_collision
        continue6:
        addi $t3, $t3 256
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop6
    
    square6:
    li $t5, 4
    lw $t9, 28($s2)
    addi $t9, $t9, 1
    beqz $t9, end2
    addi $t9, $t9, -1
    
    lw $t3, ADDR_DSPL
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    addi $t3, $t3, -4
    loop7:
        lw $t8, 0($t3)
        bne $t8, $t6, second_check7
        beq $t8, $t6, continue7
        second_check7:
        bne $t8, $t7, left_collision
        continue7:
        addi $t3, $t3 256
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop7
        
    end2:
    jr $ra
    
right_wall_collision:
    li $t5, 4
    li $t6, 0x222222
    li $t7, 0   

    lw $t9, 32($s2)
    addi $t9, $t9, 1
    beqz $t9, square7
    addi $t9, $t9, -1

    lw $t3, ADDR_DSPL
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    mult $t4, $t9, $t5
    mult $t4, $t4, $t5
    add $t3, $t3, $t4

    loop8:
        lw $t8, 0($t3)
        bne $t8, $t6, second_check8
        beq $t8, $t6, continue8
        second_check8:
        bne $t8, $t7, right_collision
        continue8:
        addi $t3, $t3 256
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop8

    square7:
    li $t5, 4
    lw $t9, 36($s2)
    addi $t9, $t9, 1
    beqz $t9, square8
    addi $t9, $t9, -1

    lw $t3, ADDR_DSPL
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    addi $t3, $t3, 1024
    mult $t4, $t9, $t5
    mult $t4, $t4, $t5
    add $t3, $t3, $t4
    loop9:
        lw $t8, 0($t3)
        bne $t8, $t6, second_check9
        beq $t8, $t6, continue9
        second_check9:
        bne $t8, $t7, right_collision
        continue9:
        addi $t3, $t3 256
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop9

    square8:
    li $t5, 4
    lw $t9, 40($s2)
    addi $t9, $t9, 1
    beqz $t9, square9
    addi $t9, $t9, -1

    lw $t3, ADDR_DSPL
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    addi $t3, $t3, 2048
    mult $t4, $t9, $t5
    mult $t4, $t4, $t5
    add $t3, $t3, $t4
    loop10:
        lw $t8, 0($t3)
        bne $t8, $t6, second_check10
        beq $t8, $t6, continue10
        second_check10:
        bne $t8, $t7, right_collision
        continue10:
        addi $t3, $t3 256
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop10

    square9:
    li $t5, 4
    lw $t9, 44($s2)
    addi $t9, $t9, 1
    beqz $t9, end3
    addi $t9, $t9, -1

    lw $t3, ADDR_DSPL
    add $t3, $t3, $s0
    add $t3, $t3, $s1
    addi $t3, $t3, 3072
    mult $t4, $t9, $t5
    mult $t4, $t4, $t5
    add $t3, $t3, $t4
    loop11:
        lw $t8, 0($t3)
        bne $t8, $t6, second_check11
        beq $t8, $t6, continue11
        second_check11:
        bne $t8, $t7, right_collision
        continue11:
        addi $t3, $t3 256
        addi $t5, $t5, -1   # Decrement loop counter
        bnez $t5, loop11

    end3:
    jr $ra

MusicLoop:
    # Play notes
    addi $t0, $a0, 0
    li $a0, 76
    li $a1, 100  # half second
    li $a3, 120
    li $v0, 33
    syscall                # Call service 33, playing music
    
    addi $a0, $t0, 0
    # End of music loop
    b render_display
    
copy_display:
    lw $t0, ADDR_DSPL
    addi $t1, $t0, 16384
    la $a1, backup
    
    copy_loop:
    lw $t3, 0($t0)
    sw $t3, 0($a1)        # Store byte to background grid copy
    addi $a1, $a1, 4     # Increment background grid copy pointer
    addi $t0, $t0, 4     # Increment loop counter
    
    bne $t0, $t1, copy_loop  # Repeat until entire grid is copied 
    # j quit
    jr $ra
    
render_display:
    lw $t0, ADDR_DSPL 
    addi $t1, $t0, 16384
    la $a1, backup
    
    render_loop:
    lw $t3, 0($a1)
    sw $t3, 0($t0)        # Store byte to background grid copy
    # addi $s0, $s0, 1     # Increment current grid pointer
    addi $a1, $a1, 4     # Increment background grid copy pointer
    addi $t0, $t0, 4     # Increment loop counter
    
    bne $t0, $t1, render_loop  # Repeat until entire grid is copied 
    # j quit
    lw $t9, 52($s2)
    beqz $t9, draw_loop
    j draw_random_tetrominoe
    
 square: 
    # tetromino heights
    sw $s5, 0($s2)
    sw $s5, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s3, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    sw $s5, 32($s2)
    sw $s5, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    
    li $t1, 0xfaeb36
    #addi $t0, $t0, 820
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
    addi $t9, $s6, 1
    lw $t8, 56($s2)
    div $t8, $t9
    mfhi $t8
    
    beq $t8, 0, line0
    beq $t8, 2, line0
    beq $t8, 1, line90
    beq $t8, 3, line90
    j draw_exit
    # j next
    
line0:
    # tetromino heights
    sw $s4, 0($s2)
    sw $s4, 4($s2)
    sw $s4, 8($s2)
    sw $s4, 12($s2)
    
    sw $s3, 16($s2)
    sw $s7, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    addi $t9, $s6, 1
    sw $t9, 32($s2)
    sw $s7, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    #Rotations: 1 -1 -1 -1
    # 1 1 1 1
    # 1 -1 -1 -1

    li $t1, 0x00ffff
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
    j draw_exit
    # j next

line90:
    # tetromino heights
    addi $t9, $s6, 1
    sw $t9, 0($s2)
    sw $s3, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s3, 20($s2)
    sw $s3, 24($s2)
    sw $s3, 28($s2)
    
    sw $s4, 32($s2)
    sw $s4, 36($s2)
    sw $s4, 40($s2)
    sw $s4, 44($s2)
    #Rotations: 1 -1 -1 -1
    # 1 1 1 1
    # 1 -1 -1 -1

    li $t1, 0x00ffff
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
    j draw_exit
    # j next
    
 t_block:
    addi $t9, $s6, 1
    lw $t8, 56($s2)
    div $t8, $t9
    mfhi $t8
    
    beq $t8, 0, t_block0
    beq $t8, 1, t_block90
    beq $t8, 2, t_block180
    beq $t8, 3, t_block270
    j draw_exit
    # j next
    
 t_block0:
 # tetromino heights
    sw $s4, 0($s2)
    sw $s5, 4($s2)
    sw $s4, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s4, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    sw $s6, 32($s2)
    sw $s5, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 3 2 -1 -1
    # 2 2 2 -1
    # 2 3 -1 -1

    li $t1, 0x70369d
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
    j draw_exit
    # j next
    
t_block90:
 # tetromino heights
    sw $s6, 0($s2)
    sw $s5, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s3, 20($s2)
    sw $s3, 24($s2)
    sw $s7, 28($s2)
    
    sw $s4, 32($s2)
    sw $s5, 36($s2)
    sw $s4, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 3 2 -1 -1
    # 2 2 2 -1
    # 2 3 -1 -1

    li $t1, 0x70369d
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
    j draw_exit
    # j next
    
t_block180:
 # tetromino heights
    sw $s5, 0($s2)
    sw $s5, 4($s2)
    sw $s5, 8($s2)
    sw $s3, 12($s2)
    
    sw $s4, 16($s2)
    sw $s3, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    sw $s5, 32($s2)
    sw $s6, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 3 2 -1 -1
    # 2 2 2 -1
    # 2 3 -1 -1

    li $t1, 0x70369d
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
    j draw_exit
    # j next
    
t_block270:
 # tetromino heights
    sw $s5, 0($s2)
    sw $s6, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s4, 16($s2)
    sw $s3, 20($s2)
    sw $s4, 24($s2)
    sw $s7, 28($s2)
    
    sw $s5, 32($s2)
    sw $s5, 36($s2)
    sw $s5, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 3 2 -1 -1
    # 2 2 2 -1
    # 2 3 -1 -1

    li $t1, 0x70369d
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
    j draw_exit
    # j next
    
 squiggle_1:
    addi $t9, $s6, 1
    lw $t8, 56($s2)
    div $t8, $t9
    mfhi $t8
    
    beq $t8, 0, squiggle_10
    beq $t8, 2, squiggle_10
    beq $t8, 1, squiggle_190
    beq $t8, 3, squiggle_190
    j draw_exit 
    
squiggle_10:
    sw $s6, 0($s2)
    sw $s5, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s4, 16($s2)
    sw $s3, 20($s2)
    sw $s3, 24($s2)
    sw $s7, 28($s2)
    
    sw $s5, 32($s2)
    sw $s5, 36($s2)
    sw $s4, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 2 2 2 -1 
    # 2 3 -1 -1
    # 2 2 2 -1

    li $t1, 0xe81416
    addi $t0, $t0, 16
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
    j draw_exit
squiggle_190:
    sw $s4, 0($s2)
    sw $s5, 4($s2)
    sw $s5, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s4, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    sw $s5, 32($s2)
    sw $s6, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 2 2 2 -1 
    # 2 3 -1 -1
    # 2 2 2 -1
    li $t1, 0xe81416
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
    j draw_exit
    
 squiggle_2:
    addi $t9, $s6, 1
    lw $t8, 56($s2)
    div $t8, $t9
    mfhi $t8
    
    beq $t8, 0, squiggle_20
    beq $t8, 2, squiggle_20
    beq $t8, 1, squiggle_290
    beq $t8, 3, squiggle_290 
    j draw_exit 
    
squiggle_20:
     # tetromino heights
    sw $s5, 0($s2)
    sw $s6, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s3, 20($s2)
    sw $s4, 24($s2)
    sw $s7, 28($s2)
    
    sw $s4, 32($s2)
    sw $s5, 36($s2)
    sw $s5, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 2 2 2 -1 
    # 3 2 -1 -1
    # 2 2 2 -1
    li $t1, 0x79c314
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
    j draw_exit
    # j next

 squiggle_290:
     # tetromino heights
    sw $s5, 0($s2)
    sw $s5, 4($s2)
    sw $s4, 8($s2)
    sw $s3, 12($s2)
    
    sw $s4, 16($s2)
    sw $s3, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    sw $s6, 32($s2)
    sw $s5, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 2 2 2 -1 
    # 3 2 -1 -1
    # 2 2 2 -1
    li $t1, 0x79c314
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
    j draw_exit
    # j next
    
 l_right:
    addi $t9, $s6, 1
    lw $t8, 56($s2)
    div $t8, $t9
    mfhi $t8
    
    beq $t8, 0, l_right0
    beq $t8, 1, l_right90
    beq $t8, 2, l_right180
    beq $t8, 3, l_right270
    j draw_exit
    
 l_right0:
    sw $s6, 0($s2)
    sw $s4, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s3, 20($s2)
    sw $s3, 24($s2)
    sw $s7, 28($s2)
    
    sw $s5, 32($s2)
    sw $s3, 36($s2)
    sw $s3, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 1 1 2 -1
    # 3 3 -1 -1
    # 2 2 2 -1

    li $t1, 0xffa500
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
l_right90:    
    sw $s4, 0($s2)
    sw $s4, 4($s2)
    sw $s5, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s5, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    sw $s6, 32($s2)
    sw $s6, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 1 1 2 -1
    # 3 3 -1 -1
    # 2 2 2 -1

    li $t1, 0xffa500
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
l_right180:
    sw $s6, 0($s2)
    sw $s6, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s4, 16($s2)
    sw $s4, 20($s2)
    sw $s3, 24($s2)
    sw $s7, 28($s2)
    
    sw $s5, 32($s2)
    sw $s5, 36($s2)
    sw $s5, 40($s2)
    sw $s3, 44($s2)
    #Rotations
    # 1 1 2 -1
    # 3 3 -1 -1
    # 2 2 2 -1

    li $t1, 0xffa500
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
l_right270:
    sw $s5, 0($s2)
    sw $s5, 4($s2)
    sw $s5, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s3, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    sw $s4, 32($s2)
    sw $s6, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    #Rotations
    # 1 1 2 -1
    # 3 3 -1 -1
    # 2 2 2 -1

    li $t1, 0xffa500
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
    
 l_left:
    addi $t9, $s6, 1
    lw $t8, 56($s2)
    div $t8, $t9
    mfhi $t8
      
    beq $t8, 0, l_left0
    beq $t8, 1, l_left90
    beq $t8, 2, l_left180
    beq $t8, 3, l_left270
    j draw_exit
    
 l_left0:
     # tetromino heights
    sw $s4, 0($s2)
    sw $s6, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s4, 20($s2)
    sw $s4, 24($s2)
    sw $s7, 28($s2)
    
    sw $s5, 32($s2)
    sw $s5, 36($s2)
    sw $s5, 40($s2)
    sw $s7, 44($s2)
    #Rotations:
    # 2 2 2 -1 
    # 3 3 -1 -1
    # 2 1 1 -1
    
    li $t1, 0x0339f8
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
l_left90:
     # tetromino heights
    sw $s5, 0($s2)
    sw $s5, 4($s2)
    sw $s5, 8($s2)
    sw $s3, 12($s2)
    
    sw $s5, 16($s2)
    sw $s3, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    sw $s6, 32($s2)
    sw $s6, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    #Rotations:
    # 2 2 2 -1 
    # 3 3 -1 -1
    # 2 1 1 -1

    li $t1, 0x0339f8
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
l_left180:
     # tetromino heights
    sw $s6, 0($s2)
    sw $s6, 4($s2)
    sw $s3, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s3, 20($s2)
    sw $s3, 24($s2)
    sw $s7, 28($s2)
    
    sw $s4, 32($s2)
    sw $s4, 36($s2)
    sw $s5, 40($s2)
    sw $s7, 44($s2)
    #Rotations:
    # 2 2 2 -1 
    # 3 3 -1 -1
    # 2 1 1 -1

    li $t1, 0x0339f8
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
l_left270:
     # tetromino heights
    sw $s5, 0($s2)
    sw $s4, 4($s2)
    sw $s4, 8($s2)
    sw $s3, 12($s2)
    
    sw $s3, 16($s2)
    sw $s3, 20($s2)
    sw $s7, 24($s2)
    sw $s7, 28($s2)
    
    sw $s6, 32($s2)
    sw $s4, 36($s2)
    sw $s7, 40($s2)
    sw $s7, 44($s2)
    #Rotations:
    # 2 2 2 -1 
    # 3 3 -1 -1
    # 2 1 1 -1

    li $t1, 0x0339f8
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
