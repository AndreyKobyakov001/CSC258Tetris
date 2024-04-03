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

li $s0, 0 # x offset of current tetromino
li $s1, 0 # y offset of current tetromino
li $s2, 0
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
        
    bne $s2, 0, draw_loop
    #INITIALIZATION END
    
draw_random_tetrominoe:
    #If the area where it would spawn, which is 820 pixels, is not grey, game over; no new pieces can spawn, as the spawning position is occupied.
    add $s2, $s2, 1
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
        lw $t1, ADDR_KBRD               # $t0 = base address for keyboard
        lw $t8, 0($t1)                  # Load first word from keyboard
        beq $t8, 1, keyboard_input      # If first word 1, key is pressed
        addi $t0, $t0, 0
        after_keyboard_input:
        addi $s1, $s1, 256     # y offset 256 * lines to drop down by
        bne $t0, 0x10008fff, MusicLoop
        
game_loop:
    j game_loop
 
 square: 
    # tetromino heights
    li $s3, 2
    li $s4, 2
    li $s5, -1
    li $s6, -1
    
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
    # tetromino heights
    li $s3, 1
    li $s4, 1
    li $s5, 1
    li $s6, 1
    
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
    j draw_exit
    # j next
 t_block:
     # tetromino heights
    li $s3, 1
    li $s4, 2
    li $s5, 1
    li $s6, -1
    
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
    j draw_exit
    # j next
 squiggle_1:
     # tetromino heights
    li $s3, 2
    li $s4, 3
    li $s5, -1
    li $s6, -1
    
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
    j draw_exit
    # j next
 squiggle_2:
     # tetromino heights
    li $s3, 3
    li $s4, 2
    li $s5, -1
    li $s6, -1
    
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
    j draw_exit
    # j next
 l_right:
     # tetromino heights
    li $s3, 1
    li $s4, 3
    li $s5, -1
    li $s6, -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0x0339f8
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
    # j next
 l_left:
     # tetromino heights
    li $s3, 3
    li $s4, 1
    li $s5, -1
    li $s6, -1
    
    li $s3, 3 # tetromino is 3 squares tall
    li $t1, 0xffa500
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
    
keyboard_input:                     # A key is pressed
    addi $t2, $a0, 0
    lw $a0, 4($t1)                  # Load second word from keyboard
    beq $a0, 0x71, quit     # Check if the key q was pressed
    beq $a0, 0x64, right_shift
    #beq $a0, 0x77, rotate
    beq $a0, 0x61, left_shift
    #beq $a0, 0x73, down_shift
    # beq $a0, 0x20, down
    
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

left_wall_collision:
    lw $t0, ADDR_DSPL
    li $t3, 0x222222
    li $t4, 0
    li $t5, 60
    add $t0, $t0, 768
    loop1:
    lw $t1, 4($t0)      # Paint at $t0

    bne $t1, $t3, second_check1
    beq $t1, $t3, continue1
    second_check1:
    bne $t1, $t4, left_collision
    continue1:
    # Increment $t0 by 256 to move to the next block
    addi $t0, $t0, 256
    # Decrement loop counter
    addi $t5, $t5, -1
    bnez $t5, loop1
    
    jr $ra

right_wall_collision:
    lw $t0, ADDR_DSPL
    li $t3, 0x222222
    li $t4, 0
    li $t5, 60
    add $t0, $t0, 768
    loop2:
    lw $t1, 144($t0)      # Paint at $t0

    bne $t1, $t3, second_check2
    beq $t1, $t3, continue2
    second_check2:
    bne $t1, $t4, left_collision
    continue2:
    # Increment $t0 by 256 to move to the next block
    addi $t0, $t0, 256
    # Decrement loop counter
    addi $t5, $t5, -1
    bnez $t5, loop2
    
    jr $ra

MusicLoop:
    # Play notes
    addi $t0, $a0, 0
    li $a0, 76
    li $a1, 100  # half second
    li $a3, 120
    li $v0, 33
    syscall                # Call service 33, playing music
    li $a0, 74
    li $a1, 200  # half second
    syscall                # Call service 33, playing music
    li $a0, 71
    li $a1, 100  # half second
    syscall                # Call service 33, playing music
    li $a0, 72
    li $a1, 100  # half second
    syscall                # Call service 33, playing music
    li $a0, 74
    li $a1, 200  # half second
    syscall                # Call service 33, playing music
    li $a0, 71
    li $a1, 100  # half second
    syscall                # Call service 33, playing music
    li $a0, 72
    li $a1, 100  # half second
    syscall                # Call service 33, playing music
    li $a0, 74
    li $a1, 200  # half second
    syscall                # Call service 33, playing music
    li $a0, 72
    li $a1, 100  # half second
    syscall                # Call service 33, playing music
    li $a0, 71
    li $a1, 100  # half second
    syscall                # Call service 33, playing music
    li $a0, 69
    syscall                # Call service 33, playing music
    addi $a0, $t0, 0
    # End of music loop
    b draw_scene

    # End of function
    jr $ra
