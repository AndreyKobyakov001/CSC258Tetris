################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Name, Student Number
# Student 2: Name, Student Number (if applicable)
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       TODO
# - Unit height in pixels:      TODO
# - Display width in pixels:    TODO
# - Display height in pixels:   TODO
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
	
main:
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
    li $t1, 0x79c314
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

    li $t1, 0x70369d 
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
    
    
    
    # j outer_loop

   
    # augment by 96 between them
    # add $t0, $t0, 96 
    
    # //second stage
    # add $t0, $t0, 624
    # li $t2, 4
    # new_loop2: 
    # sw $t1, 0($t0) 
    # sw $t1, 4($t0) 
    # sw $t1, 8($t0) 
    # sw $t1, 12($t0) 
    # # Increment $t0 by 256 to move to the next block
    # add $t0, $t0, 32
    # # Decrement loop counter
    # addi $t2, $t2, -1
    # bnez $t2, new_loop2      # Branch back to loop if $t2 != 0 

    
    #Checkerboard pattern - 4x4 black and grey
    #For each 4 pixels, 
    #Paint COLOUR
    #At 4 pixels, swap; continue 16 times
    #Swap grey and black, repeat; repeat whole process 16 times
    
    #For Pixel 0,
    #For each pixel + 128, paint grey
    
    #For pixel 0,
    #Loop 127 times to the last line
    #For each pixel until 128, paint grey


game_loop:
	# 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	# 3. Draw the screen
	# 4. Sleep

    #5. Go back to 1
    b game_loop
