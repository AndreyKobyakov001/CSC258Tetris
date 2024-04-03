#DRAWING FUNCTIONS - TODO: remove $t0 addr_dspl initialization and replace where the score is updated in game_loop to appropriately change values. Offset of 0, 20, 40, 60 for each digit of 4-digit score. 
.data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
SCORE: .word 5234
    
.text

score_selector:
    lw $t3, SCORE
    lw $t0, ADDR_DSPL
    addi $t0, $t0, 1452 
    
    div $a2, $t3, 1000 
    jal select_draw_function
    
    mul $t4, $a2, 1000
    sub $t3, $t3, $t4 
    div $a2, $t3, 100
    addi $t0, $t0, 20
    jal select_draw_function
    
    mul $t4, $a2, 100
    sub $t3, $t3, $t4 
    div $a2, $t3, 10
    addi $t0, $t0, 20
    jal select_draw_function
    
    mul $t4, $a2, 10
    sub $t3, $t3, $t4 
    div $a2, $t3, 1
    addi $t0, $t0, 20
    jal select_draw_function
    
    
    
select_draw_function:
    beq $a2, $zero, draw_zero    # If digit is 0, call draw_zero
    beq $a2, 1, draw_one       # If digit is 1, call draw_one
    beq $a2, 2, draw_two       # If digit is 2, call draw_two
    beq $a2, 3, draw_three     # If digit is 3, call draw_three
    beq $a2, 4, draw_four      # If digit is 4, call draw_four
    beq $a2, 5, draw_five      # If digit is 5, call draw_five
    beq $a2, 6, draw_six       # If digit is 6, call draw_six
    beq $a2, 7, draw_seven     # If digit is 7, call draw_seven
    beq $a2, 8, draw_eight     # If digit is 8, call draw_eight
    beq $a2, 9, draw_nine      # If digit is 9, call draw_nine
    # jr $ra

draw_zero: 
    jal draw_horizontal
    addi $t0, $t0, 1792 #BOTTOM HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, -1792 #LEFT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 12 #RIGHT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 1012 #LEFT BOTTOM VERT
    jal draw_vertical
    addi $t0, $t0, 12 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra

draw_one: 
    # lw $t0, ADDR_DSPL
    # addi $t0, $t0, 1452 #TOP HORIZONTAL
    addi $t0, $t0, 12 #RIGHT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 1024 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra

draw_two: 
    # lw $t0, ADDR_DSPL 
    # addi $t0, $t0, 1452 #TOP HORIZONTAL
    jal draw_horizontal
    addi $t0, $t0, 768 #MID HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, 256 #MID HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, 768 #BOTTOM HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, -1780 #RIGHT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 1012 #LEFT BOTTOM VERT
    jal draw_vertical
    jr $ra

draw_three: 
    # lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    # addi $t0, $t0, 1452 #TOP HORIZONTAL
    jal draw_horizontal
    
    addi $t0, $t0, 768 #MID HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, 256 #MID HORIZONTAL
    jal draw_horizontal
    addi $t0, $t0, 768 #BOTTOM HORIZONTAL
    jal draw_horizontal  
    addi $t0, $t0, -1524 #RIGHT TOP VERT
    jal draw_vertical 
    addi $t0, $t0, 768 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra

draw_four: 
    # lw $t0, ADDR_DSPL 
     # addi $t0, $t0, 1452 #TOP HORIZONTAL
    addi $t0, $t0, 768 #MID HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, 256 #MID HORIZONTAL
    jal draw_horizontal  
    addi $t0, $t0, -1024 #LEFT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 12 #RIGHT TOP VERT
    jal draw_vertical 
    addi $t0, $t0, 1024 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra

draw_five: 
    # lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    # addi $t0, $t0, 1452 #TOP HORIZONTAL
    jal draw_horizontal
    
    addi $t0, $t0, 768 #MID HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, 256 #MID HORIZONTAL
    jal draw_horizontal 
    
    addi $t0, $t0, 768 #BOTTOM HORIZONTAL
    jal draw_horizontal 
    
    addi $t0, $t0, -1792 #LEFT TOP VERT
    jal draw_vertical 
    addi $t0, $t0, 1036 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra

draw_six: 
    # lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    # addi $t0, $t0, 1452 #TOP HORIZONTAL
    jal draw_horizontal
    
    addi $t0, $t0, 768 #MID HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, 256 #MID HORIZONTAL
    jal draw_horizontal 
    
    addi $t0, $t0, 768 #BOTTOM HORIZONTAL
    jal draw_horizontal 
    
    addi $t0, $t0, -1792 #LEFT TOP VERT
    jal draw_vertical 
    addi $t0, $t0, 1024 #LEFT BOTTOM VERT
    jal draw_vertical
    addi $t0, $t0, 12 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra

draw_seven: 
    # lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    # addi $t0, $t0, 1452 #TOP HORIZONTAL
    jal draw_horizontal
    addi $t0, $t0, 12 #RIGHT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 1024 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra

draw_eight: 
    # lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    # addi $t0, $t0, 1452 #TOP HORIZONTAL
    jal draw_horizontal
    
    addi $t0, $t0, 768 #MID HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, 256 #MID HORIZONTAL
    jal draw_horizontal 
    
    addi $t0, $t0, 768 #BOTTOM HORIZONTAL
    jal draw_horizontal 
    
    addi $t0, $t0, -1792 #LEFT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 12 #RIGHT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 1012 #LEFT BOTTOM VERT
    jal draw_vertical
    addi $t0, $t0, 12 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra
    
draw_nine: 
    # lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    # addi $t0, $t0, 1452 #TOP HORIZONTAL
    jal draw_horizontal
    
    addi $t0, $t0, 768 #MID HORIZONTAL
    jal draw_horizontal 
    addi $t0, $t0, 256 #MID HORIZONTAL
    jal draw_horizontal 
    
    addi $t0, $t0, 768 #BOTTOM HORIZONTAL
    jal draw_horizontal 
    
    addi $t0, $t0, -1792 #LEFT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 12 #RIGHT TOP VERT
    jal draw_vertical 
    addi $t0, $t0, 1024 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra
    


draw_horizontal:
    li $t1, 0xff0000
    sw $t1, 0($t0)
    sw $t1, 4($t0)
    sw $t1, 8($t0)
    sw $t1, 12($t0)
    # addi $t0, $t0, -24
    jr $ra

draw_vertical:
    # lw $t0, ADDR_DSPL
    # addi $t0, $t0, 1452
    li $t1, 0xff0000
    li $t4, 4
    loopvert:
        sw $t1, 0($t0)
        addi $t0, $t0, 256
        addi $t4, $t4, -1
        bnez $t4, loopvert
    addi $t0, $t0, -1024
    jr $ra
