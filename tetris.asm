################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Andrey Kobyakov, No.1009050660
# Student 2: Greatman Nkwachukwu Okonkwo, No. 1008817005
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       TODO
# - Unit height in pixels:      TODO
# - Display width in pixels:    TODO
# - Display height in pixels:   TODO
# - Base Address for Display:   0x10008000 ($gp)

#TODO:
#QOL
# 1. Refactor initialization code into individual blocks using jal and jr $ra for easier drawing 

#Functions
# 1. Add music (Korobeinki) (Hard)
# 2. Add score, based on +100, +200, +400, +800 for each line clear of 1, 2, 3, 4 rows (Hard)
# 3. Full set of 7 tetrominoes, as below (Hard)
# 3a. Tetrominoes in different colours (Easy)
# 4. Box showing next tetromino (Easy)
# 5. Gravity feature, with each second moving tetromino down by 1 row (Easy)
# 6. Gravity speed increase feature, increase speed by 1% per tetromino and 3% per clear (Easy)
# 7. Pause screen using P (Easy)
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
background_grid_copy:    .space  4096       # allocate space to copy over entire bitmap display
current_piece_x:    .word   6               # x coordinate for current piece
current_piece_y:    .word   1               # y coordinate for current piece\

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
	

    lw $t0, ADDR_DSPL
    li $t1, 0xe81416
    
    add $t0, $t0, 768
    sw $t1 0($t0)
    sw $t1 148($t0) 
    #144 pixels between them; 36 "blocks"
    #paint(t0), paint(144(t0))
    #t0 add 256; continue 64 times
    # Initialize the game
    
    li $t2, 61
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
    
    li $t1, 0x0339f8 
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
    add $t0, $t0, 1812
    li $t5, 7              # Set loop counter for outer_loop2
    outer_loop21:
    li $t4, 4           # Reset loop counter for outer loop
    li $t6, 1024        # Set increment value for $t0 between iterations
    
    outer_loop1:
        li $t2, 4        # Set loop counter to 5 for the inner loop
        
        new_loop1: 
            sw $t1, 0($t0) 
            sw $t1, 4($t0) 
            sw $t1, 8($t0) 
            sw $t1, 12($t0) 
            add $t0, $t0, 32   # Increment $t0 by 32
            addi $t2, $t2, -1  # Decrement loop counter
            bnez $t2, new_loop1 # Branch back to loop if $t2 != 0
        
        # Increment $t0 by 96 between sub-loops
        add $t0, $t0, 128
        
        # Decrement the outer loop counter
        addi $t4, $t4, -1
        bnez $t4, outer_loop1 # Branch back to outer loop if $t4 != 0
    
    # Augment $t0 by 1024 between iterations
    add $t0, $t0, $t6

    # Decrement the outer loop counter
    addi $t5, $t5, -1
    bnez $t5, outer_loop21 # Branch back to outer loop if $t5 != 0
    


main:
    lw $t0, ADDR_DSPL
    li $t1, 0x00ff00
    addi $t0, $t0, 788
    #Starting pixel of gameboard: 772
    #140 pixels wide
    #15104 pixels long
    #Start pixel of first row: 772
    #each block 16 pixels long
    #Start pixel of final row: 15108
    li $t2, 4
    # sw $t1 0($t0)
    
    jal draw_square
    

game_loop:
	# 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	# 3. Draw the screen
	# 4. Sleep

    #5. Go back to 1
    li 		$v0, 32
	li 		$a0, 1
	syscall

    lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
    lw $t8, 0($t0)                  # Load first word from keyboard
    beq $t8, 1, keyboard_input      # If first word 1, key is pressed
    b game_loop
    
keyboard_input:                     # A key is pressed
    lw $a0, 4($t0)                  # Load second word from keyboard
    beq $a0, 0x71, quit     # Check if the key q was pressed

    li $v0, 1                       # ask system to print $a0
    syscall

    b main
 
 draw_square:
    sw $t1, 0($t0) 
    sw $t1, 4($t0) 
    sw $t1, 8($t0) 
    sw $t1, 12($t0) 
    add $t0, $t0, 256   # Increment $t0 by 32
    addi $t2, $t2, -1  # Decrement loop counter
    bnez $t2, draw_square # Branch back to loop if $t2 != 0
    jr $ra 
    
quit:
    lw $t0, ADDR_DSPL
    li $t1, 0xe81418
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
    
	li $v0, 10                      # Quit gracefully
	syscall
