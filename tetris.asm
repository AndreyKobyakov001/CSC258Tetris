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

#TODO:
#QOL
# 1. Refactor initialization code into individual blocks using jal and jr $ra for easier drawing 

#Functions - 8 = 2x + y for x easy and y hard features. 
    #Currently at 1 hard, 1 easy; total 3 (full set of tetrominoes in 7 colours)
    #TODO: complete movemment, animation, collision/clearing row!
    #Collision: if for each 16th pixel, 9 times in a row, clear the row and have everything above drop, possibly recursively
    #Animation: use LA or LW to load values of the bitmap into the backup, and then keep moving the piece down until it collides and cannot move; save this as the new backup
    #Movement: as explained below, +/- 16, -1024 for D, S, A respectively. Each operates in accordance with animation skeleton above. 
# 1. Add music (Korobeinki) (Hard) - COMPLETELY UNKNOWN
# 2. Add score, based on +100, +200, +400, +800 for each line clear of 1, 2, 3, 4 rows (Hard) (count number of erasures in a variable and add  a score via beq.)
    #Actually implementing collisions would check for each row from the start if for each 1024 piexels, a full row of 128 (or whatever it was), or indeed every 16th, were neither black nor grey. Then clear to original
    #The gravity of having the pieces fall would be more annoying to implement, as it would require each colour box to be saved and dropped 1024 pixels down individually. 
    #Something like for each grey/black pixel (possibly taken from some prime backup of an empty playing field), look at the colour above and fill the current square thus, and then paint the one above
    #with the opposite null colour. This process would run only 9 times like this, given the playing field. 
# 4. Box showing next tetromino (Easy) (draw the next tetromino in a small box. this should be obvious, though would require some funnies be done with the random piece selector loop on the first move, as it would need 2 pieces)
# 5. Gravity feature, with each second moving tetromino down by 1 row (Easy) (for each second, automatically go down 1 with the typical animation method - go back to backup background, add 1024 to origin, repaint, save)
# 6. Gravity speed increase feature, increase speed by 1% per tetromino and 3% per clear (Easy) - each piece falls 1 row per gravity (variable); this is reduced by 1% with each piece (*=.99)
# 7. Pause screen using P (Easy) - basic feature that introduces a sleeping loop when P is pressed and waits to jump back to main when P is pressed again
# 8. Rotation through the use of W; set some constant factor by which every piece is painted and add  rotation value as necessary when repainting. 
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
background_grid_copy:    .space  16384       # allocate space to copy over entire bitmap display
current_piece_x:    .word   6               # x coordinate for current piece
current_piece_y:    .word   6               # y coordinate for current piece\

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
    li $t1, 0xff0000
    
    
    sw $t1 0($t0)
    sw $t1 16380($t0) 
    add $t0, $t0, 768
    #144 pixels between them; 36 "blocks"
    #paint(t0), paint(144(t0))
    #t0 add 256; continue 64 times
    # Initialize the game
    li $t1, 0xffffff
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

main:
    
    #Starting pixel of gameboard: 772
    #140 pixels wide
    #15104 pixels long
    #Start pixel of first row: 772
    #Centre pixel: 820
    #each block 16 pixels long
    #each row (newline) is 1024 pixels
    #Start pixel of final row: 15108
    #Final pixel: 16380 for 4096 total under a 64x64 display
    
random:
    la $t0, ADDR_DSPL
    la $a1, backup
    li $t1, 0
    jal copy_loop
    li $v0, 42
    li $a0, 0
    li $a1, 7
    syscall
    lw $t0, ADDR_DSPL
    # addi $t0, $t0, 16
    #for each s press, add 1024 to $t0
    #for each a/s press, -/+ 16 to $t0, respectively
    beq $a0, 1, square
    beq $a0, 2, line
    beq $a0, 3, t_block
    beq $a0, 4, squiggle_1
    beq $a0, 5, squiggle_2
    beq $a0, 6, l_right
    beq $a0, 7, l_left
    # jal render_loop
    

game_loop:
	# 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball) - go back to the random selector
	# 3. Draw the screen - based on previous value of $a0 as long as a collision doesn't happen
	# 4. Sleep
#Method for animation
# Save screen as it is as OLD
# (1) Spawn new piece at top, selected by random
# (2)Wait 1 TIME
# Redraw OLD
# Immediately render the piece but lower by 1024 pixels as written
# Check for collisions: if piece cannot go down further and the next row/+1024 is not black or grey, and borders +/- 16 are also thus, (move down, left, right checks), save board, go to random selector (1)
# Repeat: if the piece can continue moving, go back to (2) and keep moving down
# Using the 2 data bits of start_x and start_y to keep track of the current moving piece, and redrawing based on that instead of any register
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
    beq $a0, 0x64, down
    #keybindings: https://www.rapidtables.com/code/text/ascii-table.html
    #Important one:
    # W 77 (rotate)
    # A 61 (left shift 16)
    # S 73 (down shift 1024)
    # D 64 (right shift 16)
    # [SPACE] 20 (for drop)
    # P 70 (for pause)
    # H 68 (for hold)

    li $v0, 1                       # ask system to print $a0
    syscall

    b main
 
#UNDER CONSTRUCTION - SAVE LOOP
 
# la $t0, ADDR_DSPL
# la $a1, backup
# li $t1, 0
copy_loop:
    # Debugging feature.
    # lw $t5, ADDR_DSPL
    # addi $t5, $t5, 4
    # li $t6, 0x0000ff
    # sw $t6 0($t5)
    # lb $t1, ($s0)        # Load byte from current grid
    sb $t0, ($a1)        # Store byte to background grid copy
    # addi $s0, $s0, 1     # Increment current grid pointer
    addi $a1, $a1, 1     # Increment background grid copy pointer
    addi $t1, $t1, 1     # Increment loop counter
    bne $t1, 16384, copy_loop  # Repeat until entire grid is copied
    # lw $t5, ADDR_DSPL
    # addi $t5, $t5, 8
    # li $t6, 0x00ffff
    # sw $t6 0($t5)
    jr $ra
    
# lw $s0, 0x10008000
# li $t0, 0
# render_loop:
    # lw $t1, ($s0)        # Load byte from current grid
    # # Render pixel/block based on the value of $t1
    # # (This step depends on how you render each pixel/block)
    # addi $s0, $s0, 1     # Increment current grid pointer
    # addi $t0, $t0, 1     # Increment loop counter
    # bne $t0, 16384, render_loop  # Repeat until entire grid is rendered
    # jr $ra
 
 #UNDER CONSTRUCTION - SPEEDING FINES INCREASED
 
 square: 
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
    j game_loop
 line: 
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
    j game_loop
 t_block: 
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
    j game_loop
 squiggle_1: 
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
    j game_loop
 squiggle_2: 
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
    j game_loop
 l_right: 
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
    j game_loop
 l_left: 
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
    j game_loop
 
 draw_square:
    sw $t1, 0($t0) 
    sw $t1, 4($t0) 
    sw $t1, 8($t0) 
    sw $t1, 12($t0) 
    add $t0, $t0, 256   # Increment $t0 by 32
    addi $t2, $t2, -1  # Decrement loop counter
    bnez $t2, draw_square # Branch back to loop if $t2 != 0
    add $t0, $t0, -1024   # Increment $t0 by 32
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

#Vague idea
# push_to_stack:
    # addi $sp, $sp, #VALUE
    # sw #value, 0($sp)
    # #ANIMATE/movement
    # #lw $value, 0($sp)
    # addi $sp, $sp, -value
    
#Score Card
# jump here after every move is calculated
# input of the number of lines cleared calculated at calling function
# 4 7-segment display rectangles displaying from 0000 to 9999 (if the stack-held value exceeds 9999, end screen)
# draw the respective number for the score in the appropriate box using modulo operations (ABCD//1000 = A, print A and so on for all 4 vals)

down:
    #Load old background
    #Amend y start point to be 16 less
    #Draw the appropriate piece
    #Check for collisions
    #Save as backup background
    #Jump back
    
    #A similar process is to be repeated for the rest. 

quit:
    lw $t0, ADDR_DSPL
    li $t1, 0xe81418
    jal fill
    
	li $v0, 10                      # Quit gracefully
	syscall
