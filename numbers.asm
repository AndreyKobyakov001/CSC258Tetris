#DRAWING FUNCTIONS - TODO: remove $t0 addr_dspl initialization and replace where the score is updated in game_loop to appropriately change values. Offset of 0, 20, 40, 60 for each digit of 4-digit score. 
draw_zero: 
    lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    addi $t0, $t0, 1452 #TOP HORIZONTAL
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
    lw $t0, ADDR_DSPL
    addi $t0, $t0, 1452 #TOP HORIZONTAL
    addi $t0, $t0, 12 #RIGHT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 1024 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra

draw_two: 
    lw $t0, ADDR_DSPL 
    addi $t0, $t0, 1452 #TOP HORIZONTAL
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
    lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    addi $t0, $t0, 1452 #TOP HORIZONTAL
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
    lw $t0, ADDR_DSPL 
     addi $t0, $t0, 1452 #TOP HORIZONTAL
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
    lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    addi $t0, $t0, 1452 #TOP HORIZONTAL
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
    lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    addi $t0, $t0, 1452 #TOP HORIZONTAL
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
    lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    addi $t0, $t0, 1452 #TOP HORIZONTAL
    jal draw_horizontal
    addi $t0, $t0, 12 #RIGHT TOP VERT
    jal draw_vertical
    addi $t0, $t0, 1024 #RIGHT BOTTOM VERT
    jal draw_vertical 
    jr $ra

draw_eight: 
    lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    addi $t0, $t0, 1452 #TOP HORIZONTAL
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
    lw $t0, ADDR_DSPL
    # TO BE REMOVED; initialize $t0 at summoning point
    #Each respective digit of ABCD takes an offset of 0, 20, 40, 60 - an exercise to the implementer. 
    # addi $t0, $t0, 60
    addi $t0, $t0, 1452 #TOP HORIZONTAL
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
