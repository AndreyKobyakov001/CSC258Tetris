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

#Colours:
#Red for Squiggle1
#Orange for LeftL
#Yellow for Square
#Green for Squiggle2
#Cyan for Line
#Blue for RightL
#Purple for T

#Code to generate each tetromino as it spawns. 

##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Tetris game. 
	
main:
    # Initialize the game
    
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
