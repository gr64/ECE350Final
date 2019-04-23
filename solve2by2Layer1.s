main:
# 0 - 000 - green
# 1 - 001 - white
# 2 - 010 - orange
# 3 - 011 - yellow
# 4 - 100 - red
# 5 - 101 - blue

#   G
# W O Y R
#   B
# L:  0000
# L': 0001
# R:  0010
# R': 0011
# D:  0100
# D': 0101
# U:  0110
# U': 0111
# F:  1000
# F': 1001
# B:  1010
# B': 1011
# move is just add $rd, $r0, $rs
# stack data begins at memory address 2^16 - 1 and grows down
addi $sp, $sp 4000 #initializing stack pointer (unsure if necessary)
addi $27, $0, 25 # $r27 will be used to count moves stored
# either store 25 in $r27 initially and add 0 with every sw
# or store 0, and add 25 every time
#first move is in data location 25
# assume that somehow the 24 colors have been put 
# into the appropriate positions in memory (0-23)
# number of moves stored in data memory 24

# keep track of a counter in a register to see 
# how many moves you've used? store moves in dmem starting
# at address 24, after the cube state is stored?

#FOR TESTING
#addi $t0, $0, 0 # green
#addi $t1, $0, 1 # white
#addi $t2, $0, 2 # orange
#addi $t3, $0, 3 # yellow  
#addi $t4, $0, 4 # red 
#addi $t5, $0, 5 # blue 

#sw $t0, 1($0)
#nop
#sw $t0, 2($0)
#nop
#sw $t0, 3($0)
#nop
#sw $t0, 4($0)
#nop
#sw $t1, 5($0)
#nop
#sw $t1, 6($0)
#nop
#sw $t1, 7($0)
#nop
#sw $t1, 8($0)
#nop
#sw $t2, 9($0)
#nop
#sw $t2, 10($0)
#nop
#sw $t2, 11($0)
#nop
#sw $t2, 12($0)
#nop
#sw $t3, 13($0)
#nop
#sw $t3, 14($0)
#nop
#sw $t3, 15($0)
#nop
#sw $t3, 16($0)
#nop
#sw $t4, 17($0)
#nop
#sw $t4, 18($0)
#nop
#w $t4, 19($0)
#nop
#sw $t4, 20($0)
#nop
#sw $t5, 21($0)
#nop
#sw $t5, 22($0)
#nop
#sw $t5, 23($0)
#nop
#sw $t5, 24($0)
#nop

#jal R

#End testing

#first, get GYO to FrontTopRightUp
#	have to check to see if it's already in that spot
#	if not, check each other method to see what spot it is in
#	do whatever method from whichever of the 23 other states
# 	to get it to the correct spot
SolveFrontTopRightCorner:
	addi $a0, $0, 0 #green
	addi $a1, $0, 3 #yellow
	addi $a2, $0, 2 #orange

	#SWs FOR TESTING ()
	#sw $a0, 4($0)
	#sw $a1, 13($0)
	#sw $a2, 10($0)
	#END TESTING

	#TESting
	#jal BackTopRightBack
	#bne $v0, $0, BackTopRightBack2FrontTopRightUp
	#nop
	#end
	jal FrontTopRightUp
	bne $v0, $0, SolveFrontTopLeftCorner
	nop
	
	# at the end of each 2FrontTopRightUp, jump to SolveFrontTopRightCorner
	# so that it checks again to make sure it actually worked
	# note though that if the movhements don't work you'll be stuck in an 
	# infinite loop

	jal FrontTopLeftFront
	bne $v0, $0, FrontTopLeftFront2FrontTopRightUp
	nop
	jal FrontTopLeftUp
	bne $v0, $0, FrontTopLeftUp2FrontTopRightUp
	nop
	jal FrontTopLeftLeft
	bne $v0, $0, FrontTopLeftLeft2FrontTopRightUp
	nop

	jal FrontTopRightFront
	bne $v0, $0, FrontTopRightFront2FrontTopRightUp
	nop
	#jal FrontTopRightUp
	#bne $v0, $0, FrontTopRightUp2FrontTopRightUp
	#nop
	jal FrontTopRightRight
	bne $v0, $0, FrontTopRightRight2FrontTopRightUp
	nop

	jal FrontBottomLeftFront
	bne $v0, $0, FrontBottomLeftFront2FrontTopRightUp
	nop
	jal FrontBottomLeftDown
	bne $v0, $0, FrontBottomLeftDown2FrontTopRightUp
	nop
	jal FrontBottomLeftLeft
	bne $v0, $0, FrontBottomLeftLeft2FrontTopRightUp
	nop

	jal FrontBottomRightFront
	bne $v0, $0, FrontBottomRightFront2FrontTopRightUp
	nop
	jal FrontBottomRightDown
	bne $v0, $0, FrontBottomRightDown2FrontTopRightUp
	nop
	jal FrontBottomRightRight
	bne $v0, $0, FrontBottomRightRight2FrontTopRightUp
	nop

	jal BackTopLeftBack
	bne $v0, $0, BackTopLeftBack2FrontTopRightUp
	nop
	jal BackTopLeftUp
	bne $v0, $0, BackTopLeftUp2FrontTopRightUp
	nop
	jal BackTopLeftLeft
	bne $v0, $0, BackTopLeftLeft2FrontTopRightUp
	nop

	jal BackTopRightBack
	bne $v0, $0, BackTopRightBack2FrontTopRightUp
	nop
	jal BackTopRightUp
	bne $v0, $0, BackTopRightUp2FrontTopRightUp
	nop
	jal BackTopRightRight
	bne $v0, $0, BackTopRightRight2FrontTopRightUp
	nop

	jal BackBottomLeftBack
	bne $v0, $0, BackBottomLeftBack2FrontTopRightUp
	nop
	jal BackBottomLeftDown
	bne $v0, $0, BackBottomLeftDown2FrontTopRightUp
	nop
	jal BackBottomLeftLeft
	bne $v0, $0, BackBottomLeftLeft2FrontTopRightUp
	nop

	jal BackBottomRightBack
	bne $v0, $0, BackBottomRightBack2FrontTopRightUp
	nop
	jal BackBottomRightDown
	bne $v0, $0, BackBottomRightDown2FrontTopRightUp
	nop
	jal BackBottomRightRight
	bne $v0, $0, BackBottomRightRight2FrontTopRightUp
	nop

	#if none of these have worked, something has gone wrong
	# maybe check the first condition again (duplicate code) and if it doesn't
	# work throw an error and quit?


SolveFrontTopLeftCorner:
	add $v0, $0, $0 #re-initialize output argument

	addi $a0, $0, 0 #green
	addi $a1, $0, 2 #orange
	addi $a2, $0, 1 #white

	jal FrontTopLeftUp
	bne $v0, $0, SolveBackTopRightCorner
	nop

	jal FrontTopLeftFront
	bne $v0, $0, FrontTopLeftFront2FrontTopLeftUp
	nop
	#jal FrontTopLeftUp
	#bne $v0, $0, FrontTopLeftUp2FrontTopLeftUp
	#nop
	jal FrontTopLeftLeft
	bne $v0, $0, FrontTopLeftLeft2FrontTopLeftUp
	nop

	jal FrontTopRightFront
	bne $v0, $0, FrontTopRightFront2FrontTopLeftUp
	nop
	jal FrontTopRightUp
	bne $v0, $0, FrontTopRightUp2FrontTopLeftUp
	nop
	jal FrontTopRightRight
	bne $v0, $0, FrontTopRightRight2FrontTopLeftUp
	nop

	jal FrontBottomLeftFront
	bne $v0, $0, FrontBottomLeftFront2FrontTopLeftUp
	nop
	jal FrontBottomLeftDown
	bne $v0, $0, FrontBottomLeftDown2FrontTopLeftUp
	nop
	jal FrontBottomLeftLeft
	bne $v0, $0, FrontBottomLeftLeft2FrontTopLeftUp
	nop

	jal FrontBottomRightFront
	bne $v0, $0, FrontBottomRightFront2FrontTopLeftUp
	nop
	jal FrontBottomRightDown
	bne $v0, $0, FrontBottomRightDown2FrontTopLeftUp
	nop
	jal FrontBottomRightRight
	bne $v0, $0, FrontBottomRightRight2FrontTopLeftUp
	nop

	jal BackTopLeftBack
	bne $v0, $0, BackTopLeftBack2FrontTopLeftUp
	nop
	jal BackTopLeftUp
	bne $v0, $0, BackTopLeftUp2FrontTopLeftUp
	nop
	jal BackTopLeftLeft
	bne $v0, $0, BackTopLeftLeft2FrontTopLeftUp
	nop

	jal BackTopRightBack
	bne $v0, $0, BackTopRightBack2FrontTopLeftUp
	nop
	jal BackTopRightUp
	bne $v0, $0, BackTopRightUp2FrontTopLeftUp
	nop
	jal BackTopRightRight
	bne $v0, $0, BackTopRightRight2FrontTopLeftUp
	nop

	jal BackBottomLeftBack
	bne $v0, $0, BackBottomLeftBack2FrontTopLeftUp
	nop
	jal BackBottomLeftDown
	bne $v0, $0, BackBottomLeftDown2FrontTopLeftUp
	nop
	jal BackBottomLeftLeft
	bne $v0, $0, BackBottomLeftLeft2FrontTopLeftUp
	nop

	jal BackBottomRightBack
	bne $v0, $0, BackBottomRightBack2FrontTopLeftUp
	nop
	jal BackBottomRightDown
	bne $v0, $0, BackBottomRightDown2FrontTopLeftUp
	nop
	jal BackBottomRightRight
	bne $v0, $0, BackBottomRightRight2FrontTopLeftUp
	nop

SolveBackTopRightCorner:
	add $v0, $0, $0 #re-initialize output argument

	addi $a0, $0, 0 #green
	addi $a1, $0, 4 #red
	addi $a2, $0, 3 #yellow

	jal BackTopRightUp
	bne $v0, $0, SolveBackTopLeftCorner
	nop

	jal FrontTopLeftFront
	bne $v0, $0, FrontTopLeftFront2BackTopRightUp
	nop
	jal FrontTopLeftUp
	bne $v0, $0, FrontTopLeftUp2BackTopRightUp
	nop
	jal FrontTopLeftLeft
	bne $v0, $0, FrontTopLeftLeft2BackTopRightUp
	nop

	jal FrontTopRightFront
	bne $v0, $0, FrontTopRightFront2BackTopRightUp
	nop
	jal FrontTopRightUp
	bne $v0, $0, FrontTopRightUp2BackTopRightUp
	nop
	jal FrontTopRightRight
	bne $v0, $0, FrontTopRightRight2BackTopRightUp
	nop

	jal FrontBottomLeftFront
	bne $v0, $0, FrontBottomLeftFront2BackTopRightUp
	nop
	jal FrontBottomLeftDown
	bne $v0, $0, FrontBottomLeftDown2BackTopRightUp
	nop
	jal FrontBottomLeftLeft
	bne $v0, $0, FrontBottomLeftLeft2BackTopRightUp
	nop

	jal FrontBottomRightFront
	bne $v0, $0, FrontBottomRightFront2BackTopRightUp
	nop
	jal FrontBottomRightDown
	bne $v0, $0, FrontBottomRightDown2BackTopRightUp
	nop
	jal FrontBottomRightRight
	bne $v0, $0, FrontBottomRightRight2BackTopRightUp
	nop

	jal BackTopLeftBack
	bne $v0, $0, BackTopLeftBack2BackTopRightUp
	nop
	jal BackTopLeftUp
	bne $v0, $0, BackTopLeftUp2BackTopRightUp
	nop
	jal BackTopLeftLeft
	bne $v0, $0, BackTopLeftLeft2BackTopRightUp
	nop

	jal BackTopRightBack
	bne $v0, $0, BackTopRightBack2BackTopRightUp
	nop
	#jal BackTopRightUp
	#bne $v0, $0, BackTopRightUp2BackTopRightUp
	#nop
	jal BackTopRightRight
	bne $v0, $0, BackTopRightRight2BackTopRightUp
	nop

	jal BackBottomLeftBack
	bne $v0, $0, BackBottomLeftBack2BackTopRightUp
	nop
	jal BackBottomLeftDown
	bne $v0, $0, BackBottomLeftDown2BackTopRightUp
	nop
	jal BackBottomLeftLeft
	bne $v0, $0, BackBottomLeftLeft2BackTopRightUp
	nop

	jal BackBottomRightBack
	bne $v0, $0, BackBottomRightBack2BackTopRightUp
	nop
	jal BackBottomRightDown
	bne $v0, $0, BackBottomRightDown2BackTopRightUp
	nop
	jal BackBottomRightRight
	bne $v0, $0, BackBottomRightRight2BackTopRightUp
	nop



SolveBackTopLeftCorner: #green white red
	add $v0, $0, $0 #re-initialize output argument

	addi $a0, $0, 0 #green
	addi $a1, $0, 1 #white
	addi $a2, $0, 4 #red

	jal BackTopLeftUp
	bne $v0, $0, exitSolve2by2
	nop

	jal FrontTopLeftFront
	bne $v0, $0, FrontTopLeftFront2BackTopLeftUp
	nop
	jal FrontTopLeftUp
	bne $v0, $0, FrontTopLeftUp2BackTopLeftUp
	nop
	jal FrontTopLeftLeft
	bne $v0, $0, FrontTopLeftLeft2BackTopLeftUp
	nop

	jal FrontTopRightFront
	bne $v0, $0, FrontTopRightFront2BackTopLeftUp
	nop
	jal FrontTopRightUp
	bne $v0, $0, FrontTopRightUp2BackTopLeftUp
	nop
	jal FrontTopRightRight
	bne $v0, $0, FrontTopRightRight2BackTopLeftUp
	nop

	jal FrontBottomLeftFront
	bne $v0, $0, FrontBottomLeftFront2BackTopLeftUp
	nop
	jal FrontBottomLeftDown
	bne $v0, $0, FrontBottomLeftDown2BackTopLeftUp
	nop
	jal FrontBottomLeftLeft
	bne $v0, $0, FrontBottomLeftLeft2BackTopLeftUp
	nop

	jal FrontBottomRightFront
	bne $v0, $0, FrontBottomRightFront2BackTopLeftUp
	nop
	jal FrontBottomRightDown
	bne $v0, $0, FrontBottomRightDown2BackTopLeftUp
	nop
	jal FrontBottomRightRight
	bne $v0, $0, FrontBottomRightRight2BackTopLeftUp
	nop

	jal BackTopLeftBack
	bne $v0, $0, BackTopLeftBack2BackTopLeftUp
	nop
	#jal BackTopLeftUp
	#bne $v0, $0, BackTopLeftUp2BackTopLeftUp
	#nop
	jal BackTopLeftLeft
	bne $v0, $0, BackTopLeftLeft2BackTopLeftUp
	nop

	jal BackTopRightBack
	bne $v0, $0, BackTopRightBack2BackTopLeftUp
	nop
	jal BackTopRightUp
	bne $v0, $0, BackTopRightUp2BackTopLeftUp
	nop
	jal BackTopRightRight
	bne $v0, $0, BackTopRightRight2BackTopLeftUp
	nop

	jal BackBottomLeftBack
	bne $v0, $0, BackBottomLeftBack2BackTopLeftUp
	nop
	jal BackBottomLeftDown
	bne $v0, $0, BackBottomLeftDown2BackTopLeftUp
	nop
	jal BackBottomLeftLeft
	bne $v0, $0, BackBottomLeftLeft2BackTopLeftUp
	nop

	jal BackBottomRightBack
	bne $v0, $0, BackBottomRightBack2BackTopLeftUp
	nop
	jal BackBottomRightDown
	bne $v0, $0, BackBottomRightDown2BackTopLeftUp
	nop
	jal BackBottomRightRight
	bne $v0, $0, BackBottomRightRight2BackTopLeftUp
	nop

	j exitSolve2by2
#then, get GOW to FrontTopLeftUp
#	have to check to see if it's already in that spot
#	if not, check each other method to see what spot it is in
#	do whatever method from whichever of the 20 other states
# 	to get it to the correct spot
#	(only 20 other states because 3 are taken up by FrontTopRight, 1 by correct FrontTopLeftUp)
#	(which we've already established that GYO is occupying)
#then, get GWR to BackTopLeftUp
#	have to check to see if it's already in that spot
#	if not, check each other method to see what spot it is in
#	do whatever method from whichever of the 17 other states
# 	to get it to the correct spot
#	(only 17 other states because others are taken up by FrontTopRight and FrontTopLeft)
#last, get GRY to BackTopRightUp
#	have to check to see if it's already in that spot
#	if not, check each other method to see what spot it is in
#	do whatever method from whichever of the 14 other states
# 	to get it to the correct spot
#	(only 14 other states because others are taken up by FrontTopRight and FrontTopLeft and BackTopLeft)

# you put in what you expect to be there, method loads what's actually there
# and tells you if it matches
# goes clockwise from named face
# returns 1 if colors are in that orientation, 0 if not
FrontTopLeftFront: #takes in color args from $a0, $a1, $a2, returns $v0
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 9($0)
	lw $t1, 6($0)
	lw $t2, 3($0)

	bne $a0, $t0, exitFrontTopLeftFront
	bne $a1, $t1, exitFrontTopLeftFront
	bne $a2, $t2, exitFrontTopLeftFront

	addi $v0, $0, 1

	exitFrontTopLeftFront:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop

FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 3($0)
	lw $t1, 9($0)
	lw $t2, 6($0)

	bne $a0, $t0, exitFrontTopLeftUp
	bne $a1, $t1, exitFrontTopLeftUp
	bne $a2, $t2, exitFrontTopLeftUp

	addi $v0, $0, 1

	exitFrontTopLeftUp:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop

FrontTopLeftLeft:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 6($0)
	lw $t1, 3($0)
	lw $t2, 9($0)

	bne $a0, $t0, exitFrontTopLeftLeft
	bne $a1, $t1, exitFrontTopLeftLeft
	bne $a2, $t2, exitFrontTopLeftLeft

	addi $v0, $0, 1

	exitFrontTopLeftLeft:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop

FrontTopRightFront:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 10($0)
	lw $t1, 4($0)
	lw $t2, 13($0)

	bne $a0, $t0, exitFrontTopRightFront
	bne $a1, $t1, exitFrontTopRightFront
	bne $a2, $t2, exitFrontTopRightFront

	addi $v0, $0, 1

	exitFrontTopRightFront:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 4($0)
	lw $t1, 13($0)
	lw $t2, 10($0)

	bne $a0, $t0, exitFrontTopRightUp
	bne $a1, $t1, exitFrontTopRightUp
	bne $a2, $t2, exitFrontTopRightUp

	addi $v0, $0, 1

	exitFrontTopRightUp:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
FrontTopRightRight:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 13($0)
	lw $t1, 10($0)
	lw $t2, 4($0)

	bne $a0, $t0, exitFrontTopRightRight
	bne $a1, $t1, exitFrontTopRightRight
	bne $a2, $t2, exitFrontTopRightRight

	addi $v0, $0, 1

	exitFrontTopRightRight:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop

FrontBottomLeftFront:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 11($0)
	lw $t1, 21($0)
	lw $t2, 8($0)

	bne $a0, $t0, exitFrontBottomLeftFront
	bne $a1, $t1, exitFrontBottomLeftFront
	bne $a2, $t2, exitFrontBottomLeftFront

	addi $v0, $0, 1

	exitFrontBottomLeftFront:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
FrontBottomLeftDown:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 21($0)
	lw $t1, 8($0)
	lw $t2, 11($0)

	bne $a0, $t0, exitFrontBottomLeftDown
	bne $a1, $t1, exitFrontBottomLeftDown
	bne $a2, $t2, exitFrontBottomLeftDown

	addi $v0, $0, 1

	exitFrontBottomLeftDown:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
FrontBottomLeftLeft:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 8($0)
	lw $t1, 11($0)
	lw $t2, 21($0)

	bne $a0, $t0, exitFrontBottomLeftLeft
	bne $a1, $t1, exitFrontBottomLeftLeft
	bne $a2, $t2, exitFrontBottomLeftLeft

	addi $v0, $0, 1

	exitFrontBottomLeftLeft:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop

FrontBottomRightFront:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 12($0)
	lw $t1, 15($0)
	lw $t2, 22($0)

	bne $a0, $t0, exitFrontBottomRightFront
	bne $a1, $t1, exitFrontBottomRightFront
	bne $a2, $t2, exitFrontBottomRightFront

	addi $v0, $0, 1

	exitFrontBottomRightFront:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    	nop
    	nop
FrontBottomRightDown:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 22($0)
	lw $t1, 12($0)
	lw $t2, 15($0)

	bne $a0, $t0, exitFrontBottomRightDown
	bne $a1, $t1, exitFrontBottomRightDown
	bne $a2, $t2, exitFrontBottomRightDown

	addi $v0, $0, 1

	exitFrontBottomRightDown:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
FrontBottomRightRight:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 15($0)
	lw $t1, 22($0)
	lw $t2, 12($0)

	bne $a0, $t0, exitFrontBottomRightRight
	bne $a1, $t1, exitFrontBottomRightRight
	bne $a2, $t2, exitFrontBottomRightRight

	addi $v0, $0, 1

	exitFrontBottomRightRight:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
BackTopLeftBack:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 18($0)
	lw $t1, 1($0)
	lw $t2, 5($0)

	bne $a0, $t0, exitBackTopLeftBack
	bne $a1, $t1, exitBackTopLeftBack
	bne $a2, $t2, exitBackTopLeftBack

	addi $v0, $0, 1

	exitBackTopLeftBack:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 1($0)
	lw $t1, 5($0)
	lw $t2, 18($0)

	bne $a0, $t0, exitBackTopLeftUp
	bne $a1, $t1, exitBackTopLeftUp
	bne $a2, $t2, exitBackTopLeftUp

	addi $v0, $0, 1

	exitBackTopLeftUp:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
BackTopLeftLeft:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 5($0)
	lw $t1, 18($0)
	lw $t2, 1($0)

	bne $a0, $t0, exitBackTopLeftLeft
	bne $a1, $t1, exitBackTopLeftLeft
	bne $a2, $t2, exitBackTopLeftLeft

	addi $v0, $0, 1

	exitBackTopLeftLeft:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop

BackTopRightBack:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 17($0)
	lw $t1, 14($0)
	lw $t2, 2($0)

	bne $a0, $t0, exitBackTopRightBack
	bne $a1, $t1, exitBackTopRightBack
	bne $a2, $t2, exitBackTopRightBack

	addi $v0, $0, 1

	exitBackTopRightBack:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 2($0)
	lw $t1, 17($0)
	lw $t2, 14($0)

	bne $a0, $t0, exitBackTopRightUp
	bne $a1, $t1, exitBackTopRightUp
	bne $a2, $t2, exitBackTopRightUp

	addi $v0, $0, 1

	exitBackTopRightUp:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
BackTopRightRight:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 14($0)
	lw $t1, 2($0)
	lw $t2, 17($0)

	bne $a0, $t0, exitBackTopRightRight
	bne $a1, $t1, exitBackTopRightRight
	bne $a2, $t2, exitBackTopRightRight

	addi $v0, $0, 1

	exitBackTopRightRight:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop

BackBottomLeftBack:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 20($0)
	lw $t1, 7($0)
	lw $t2, 23($0)

	bne $a0, $t0, exitBackBottomLeftBack
	bne $a1, $t1, exitBackBottomLeftBack
	bne $a2, $t2, exitBackBottomLeftBack

	addi $v0, $0, 1

	exitBackBottomLeftBack:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
BackBottomLeftDown:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 23($0)
	lw $t1, 20($0)
	lw $t2, 7($0)

	bne $a0, $t0, exitBackBottomLeftDown
	bne $a1, $t1, exitBackBottomLeftDown
	bne $a2, $t2, exitBackBottomLeftDown

	addi $v0, $0, 1

	exitBackBottomLeftDown:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
BackBottomLeftLeft:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 7($0)
	lw $t1, 23($0)
	lw $t2, 20($0)

	bne $a0, $t0, exitBackBottomLeftLeft
	bne $a1, $t1, exitBackBottomLeftLeft
	bne $a2, $t2, exitBackBottomLeftLeft

	addi $v0, $0, 1

	exitBackBottomLeftLeft:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop

BackBottomRightBack:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 19($0)
	lw $t1, 24($0)
	lw $t2, 16($0)

	bne $a0, $t0, exitBackBottomRightBack
	bne $a1, $t1, exitBackBottomRightBack
	bne $a2, $t2, exitBackBottomRightBack

	addi $v0, $0, 1

	exitBackBottomRightBack:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
BackBottomRightDown:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 24($0)
	lw $t1, 16($0)
	lw $t2, 19($0)

	bne $a0, $t0, exitBackBottomRightDown
	bne $a1, $t1, exitBackBottomRightDown
	bne $a2, $t2, exitBackBottomRightDown

	addi $v0, $0, 1

	exitBackBottomRightDown:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop
BackBottomRightRight:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 16($0)
	lw $t1, 19($0)
	lw $t2, 24($0)

	bne $a0, $t0, exitBackBottomRightRight
	bne $a1, $t1, exitBackBottomRightRight
	bne $a2, $t2, exitBackBottomRightRight

	addi $v0, $0, 1

	exitBackBottomRightRight:
		lw $ra 0($sp)
		nop
		nop
		addi $sp, $sp, 4
		jr $ra
    nop
    nop



#MOVE SEQUENCES

FrontTopLeftFront2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal R
	jal Fc
	jal Rc
	jal D
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
FrontTopLeftUp2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Fc
	jal D
	jal F
	jal D
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
FrontTopLeftLeft2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner    
	nop
    nop
FrontTopRightFront2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Lc
	jal F
	jal L
	jal B
	jal R
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
FrontTopRightRight2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal B
	jal Rc
	jal Bc
	jal Lc
	jal Fc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
	nop
    nop
FrontBottomLeftFront2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal Lc
	jal Fc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
FrontBottomLeftDown2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Lc
	jal F
	jal F
	jal L
	jal B
	jal R
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
FrontBottomLeftLeft2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal B
	jal R
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
FrontBottomRightFront2FrontTopRightUp:
	addi $sp, $sp, -4 #857
	sw $ra, 0($sp) #858
	jal B #859
	jal R #860
	jal Bc #861
	lw $ra, 0($sp) #862
		nop #863
		nop #864
	addi $sp, $sp, 4 #865
	j SolveFrontTopLeftCorner #867
    nop #868
    nop #869
FrontBottomRightDown2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Lc
	jal Fc
	jal L
	jal B
	jal Rc
	jal Bc
	jal Lc
	jal Fc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
FrontBottomRightRight2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Lc
	jal Fc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackTopLeftBack2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	jal B
	jal R
	jal Dc
	jal Dc
	jal B
	jal R
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackTopLeftUp2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal F
	jal Lc
	jal Fc
	jal Dc
	jal Dc
	jal B
	jal R
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackTopLeftLeft2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal F
	jal Lc
	jal Fc
	jal D
	jal D
	jal Lc
	jal Fc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackTopRightBack2FrontTopRightUp: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackTopRightUp2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal L
	jal Bc
	jal Lc
	jal Dc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackTopRightRight2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Fc
	jal R
	jal F
	jal Dc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackBottomLeftBack2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal Dc
	jal B
	jal R
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackBottomLeftDown2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal Lc
	jal Fc
	jal L
	jal B
	jal Rc
	jal Bc
	jal Lc
	jal Fc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackBottomLeftLeft2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal Lc
	jal Fc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackBottomRightBack2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal Lc
	jal Fc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackBottomRightDown2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal Lc
	jal Fc
	jal L
	jal B
	jal Rc
	jal Bc
	jal Lc
	jal Fc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
BackBottomRightRight2FrontTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal B
	jal R
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveFrontTopLeftCorner
    nop
    nop
FrontTopLeftFront2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal R
	jal Fc
	jal Rc
	jal Bc
	jal Lc
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontTopLeftLeft2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Bc
	jal L
	jal B
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontTopRightFront2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal F
	jal Dc
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontTopRightUp2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	jal Dc
	jal R
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontTopRightRight2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal B
	jal Rc
	jal Bc
	jal Dc
	jal Bc
	jal Lc
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontBottomLeftFront2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Bc
	jal Lc
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontBottomLeftDown2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal Bc
	jal Lc
	jal B
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontBottomLeftLeft2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontBottomRightFront2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontBottomRightDown2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal Lc
	jal F
	jal L
	jal Fc
	jal Dc
	jal Bc
	jal Lc
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontBottomRightRight2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal Bc
	jal Lc
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackTopLeftBack2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackTopLeftUp2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	jal B
	jal R
	jal D
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackTopLeftLeft2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal F
	jal Lc
	jal Fc
	jal D
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackTopRightBack2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal L
	jal Bc
	jal Lc
	jal D
	jal D
	jal Bc
	jal Lc
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackTopRightUp2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Bc
	jal Dc
	jal Dc
	jal B
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackTopRightRight2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Fc
	jal R
	jal F
	jal Dc
	jal Dc
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackBottomLeftBack2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackBottomLeftDown2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal R
	jal F
	jal Rc
	jal Bc
	jal L
	jal B
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackBottomLeftLeft2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackBottomRightBack2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal Bc
	jal Lc
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackBottomRightDown2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal F
	jal Lc
	jal Fc
	jal L
	jal Dc
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
BackBottomRightRight2FrontTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal R
	jal F
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopRightCorner
    nop
    nop
FrontTopLeftFront2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontTopLeftUp2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal R
	jal Fc
	jal Rc
	jal Dc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontTopLeftLeft2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Bc
	jal L
	jal B
	jal Dc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontTopRightFront2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Lc
	jal F
	jal L
	jal D
	jal D
	jal F
	jal L
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontTopRightUp2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Lc
	jal Fc
	jal L
	jal Dc
	jal F
	jal L
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontTopRightRight2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal B
	jal Rc
	jal Bc
	jal D
	jal D
	jal Rc
	jal Bc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontBottomLeftFront2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal Rc
	jal Bc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontBottomLeftDown2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal Lc
	jal Dc
	jal L
	jal F
	jal Lc
	jal Fc
	jal Rc
	jal Bc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontBottomLeftLeft2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal F
	jal L
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontBottomRightFront2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal Dc
	jal F
	jal L
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontBottomRightDown2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal Lc
	jal D
	jal L
	jal D
	jal D
	jal Rc
	jal Bc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontBottomRightRight2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal Rc
	jal Bc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackTopLeftBack2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	jal B
	jal R
	jal F
	jal L
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackTopLeftLeft2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal F
	jal Lc
	jal Fc
	jal Rc
	jal Bc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackTopRightBack2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal L
	jal Bc
	jal Lc
	jal D
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackTopRightUp2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Fc
	jal R
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackTopRightRight2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackBottomLeftBack2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal F
	jal L
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackBottomLeftDown2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	jal Bc
	jal R
	jal F
	jal Lc
	jal Fc
	jal Rc
	jal Bc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackBottomLeftLeft2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	jal Bc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackBottomRightBack2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal Rc
	jal Bc
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackBottomRightDown2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal B
	jal Dc
	jal Bc
	jal D
	jal D
	jal F
	jal L
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
BackBottomRightRight2BackTopLeftUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	jal B
	jal R
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j exitSolve2by2
    nop
    nop
FrontTopLeftFront2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal R
	jal Fc
	jal Rc
	jal D
	jal D
	jal Fc
	jal Rc
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontTopLeftUp2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal R
	jal F
	jal Rc
	jal D
	jal Fc
	jal Rc
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontTopLeftLeft2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Bc
	jal L
	jal B
	jal D
	jal D
	jal L
	jal B
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontTopRightFront2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Lc
	jal F
	jal L
	jal D
	jal L
	jal B
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontTopRightUp2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal B
	jal Rc
	jal Bc
	jal D
	jal L
	jal B
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontTopRightRight2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal B
	jal Rc
	jal Bc
	jal D
	jal Rc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontBottomLeftFront2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal Fc
	jal Rc
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontBottomLeftDown2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Fc
	jal D
	jal Rc
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontBottomLeftLeft2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Bc
	jal D
	jal D
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontBottomRightFront2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal L
	jal B
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontBottomRightDown2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal F
	jal D
	jal D
	jal Fc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
FrontBottomRightRight2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal Fc
	jal Rc
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackTopLeftBack2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	jal B
	jal R
	jal Dc
	jal B
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackTopLeftUp2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Rc
	jal B
	jal R
	jal F
	jal L
	jal Fc
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackTopLeftLeft2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Bc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackTopRightBack2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal L
	jal Bc
	jal Lc
	jal Fc
	jal Rc
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackTopRightRight2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Fc
	jal R
	jal F
	jal L
	jal B
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackBottomLeftBack2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal L
	jal Bc
	jal L
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackBottomLeftDown2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal B
	jal Rc
	jal Bc
	jal R
	jal D
	jal L
	jal B
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackBottomLeftLeft2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Dc
	jal Fc
	jal Rc
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackBottomRightBack2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Fc
	jal Rc
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackBottomRightDown2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal D
	jal D
	jal L
	jal B
	jal Fc
	jal Rc
	jal F
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop
BackBottomRightRight2BackTopRightUp:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal L
	jal B
	jal Lc
	lw $ra, 0($sp)
		nop
		nop
	addi $sp, $sp, 4
	j SolveBackTopLeftCorner
    nop
    nop


# moves
L:  # 0000 - 0
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 1($0)
	lw $t1, 3($0)
	lw $t2, 5($0)
	lw $t3, 6($0)
	lw $t4, 7($0)
	lw $t5, 8($0)
	lw $t6, 9($0)
	lw $t7, 11($0)
	lw $t8, 18($0)
	lw $t9, 20($0)
	lw $s0, 21($0)
	lw $s1, 23($0)

	sw $t0, 9($0)
	sw $t1, 11($0)
	sw $t2, 6($0)
	sw $t3, 8($0)
	sw $t4, 5($0)
	sw $t5, 7($0)
	sw $t6, 21($0)
	sw $t7, 23($0)
	sw $t8, 3($0)
	sw $t9, 1($0)
	sw $s0, 20($0)
	sw $s1, 18($0)

	addi $s0, $0, 0 	# storing code for L in $s0
	sw $s0, 0($27)		# storing L in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop

Lc: # 0001 - 1
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 1($0)
	lw $t1, 3($0)
	lw $t2, 5($0)
	lw $t3, 6($0)
	lw $t4, 7($0)
	lw $t5, 8($0)
	lw $t6, 9($0)
	lw $t7, 11($0)
	lw $t8, 18($0)
	lw $t9, 20($0)
	lw $s0, 21($0)
	lw $s1, 23($0)

	sw $t0, 20($0)
	sw $t1, 18($0)
	sw $t2, 7($0)
	sw $t3, 5($0)
	sw $t4, 8($0)
	sw $t5, 6($0)
	sw $t6, 1($0)
	sw $t7, 3($0)
	sw $t8, 23($0)
	sw $t9, 21($0)
	sw $s0, 9($0)
	sw $s1, 11($0)

	addi $s0, $0, 1 	# storing code for Lc in $s0
	sw $s0, 0($27)		# storing Lc in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop
R:  # 0010 - 2
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 2($0)
	lw $t1, 4($0)
	lw $t2, 10($0)
	lw $t3, 12($0)
	lw $t4, 13($0)
	lw $t5, 14($0)
	lw $t6, 15($0)
	lw $t7, 16($0)
	lw $t8, 17($0)
	lw $t9, 19($0)
	lw $s0, 22($0)
	lw $s1, 24($0)

	sw $t0, 19($0)
	sw $t1, 17($0)
	sw $t2, 2($0)
	sw $t3, 4($0)
	sw $t4, 14($0)
	sw $t5, 16($0)
	sw $t6, 13($0)
	sw $t7, 15($0)
	sw $t8, 24($0)
	sw $t9, 22($0)
	sw $s0, 10($0)
	sw $s1, 12($0)

	addi $s0, $0, 2 	# storing code for R in $s0
	sw $s0, 0($27)		# storing R in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop

Rc: # 0011 - 3
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 2($0)
	lw $t1, 4($0)
	lw $t2, 10($0)
	lw $t3, 12($0)
	lw $t4, 13($0)
	lw $t5, 14($0)
	lw $t6, 15($0)
	lw $t7, 16($0)
	lw $t8, 17($0)
	lw $t9, 19($0)
	lw $s0, 22($0)
	lw $s1, 24($0)

	sw $t0, 10($0)
	sw $t1, 12($0)
	sw $t2, 22($0)
	sw $t3, 24($0)
	sw $t4, 15($0)
	sw $t5, 13($0)
	sw $t6, 16($0)
	sw $t7, 14($0)
	sw $t8, 4($0)
	sw $t9, 2($0)
	sw $s0, 19($0)
	sw $s1, 17($0)

	addi $s0, $0, 3 	# storing code for Rc in $s0
	sw $s0, 0($27)		# storing Rc in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop

D:  # 0100 - 4
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 7($0)
	lw $t1, 8($0)
	lw $t2, 11($0)
	lw $t3, 12($0)
	lw $t4, 15($0)
	lw $t5, 16($0)
	lw $t6, 19($0)
	lw $t7, 20($0)
	lw $t8, 21($0)
	lw $t9, 22($0)
	lw $s0, 23($0)
	lw $s1, 24($0)

	sw $t0, 11($0)
	sw $t1, 12($0)
	sw $t2, 15($0)
	sw $t3, 16($0)
	sw $t4, 19($0)
	sw $t5, 20($0)
	sw $t6, 7($0)
	sw $t7, 8($0)
	sw $t8, 22($0)
	sw $t9, 24($0)
	sw $s0, 21($0)
	sw $s1, 23($0)

	addi $s0, $0, 4 	# storing code for D in $s0
	sw $s0, 0($27)		# storing D in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop
    nop

Dc: # 0101 - 5
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 7($0)
	lw $t1, 8($0)
	lw $t2, 11($0)
	lw $t3, 12($0)
	lw $t4, 15($0)
	lw $t5, 16($0)
	lw $t6, 19($0)
	lw $t7, 20($0)
	lw $t8, 21($0)
	lw $t9, 22($0)
	lw $s0, 23($0)
	lw $s1, 24($0)

	sw $t0, 19($0)
	sw $t1, 20($0)
	sw $t2, 7($0)
	sw $t3, 8($0)
	sw $t4, 11($0)
	sw $t5, 12($0)
	sw $t6, 15($0)
	sw $t7, 16($0)
	sw $t8, 23($0)
	sw $t9, 21($0)
	sw $s0, 24($0)
	sw $s1, 22($0)

	addi $s0, $0, 5 	# storing code for Dc in $s0
	sw $s0, 0($27)		# storing Dc in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop
U:  # 0110 - 6
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 1($0)
	lw $t1, 2($0)
	lw $t2, 3($0)
	lw $t3, 4($0)
	lw $t4, 5($0)
	lw $t5, 6($0)
	lw $t6, 9($0)
	lw $t7, 10($0)
	lw $t8, 13($0)
	lw $t9, 14($0)
	lw $s0, 17($0)
	lw $s1, 18($0)

	sw $t0, 2($0)
	sw $t1, 4($0)
	sw $t2, 1($0)
	sw $t3, 3($0)
	sw $t4, 17($0)
	sw $t5, 18($0)
	sw $t6, 5($0)
	sw $t7, 6($0)
	sw $t8, 9($0)
	sw $t9, 10($0)
	sw $s0, 13($0)
	sw $s1, 14($0)

	addi $s0, $0, 6 	# storing code for U in $s0
	sw $s0, 0($27)		# storing U in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop
Uc: # 0111 - 7
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 1($0)
	lw $t1, 2($0)
	lw $t2, 3($0)
	lw $t3, 4($0)
	lw $t4, 5($0)
	lw $t5, 6($0)
	lw $t6, 9($0)
	lw $t7, 10($0)
	lw $t8, 13($0)
	lw $t9, 14($0)
	lw $s0, 17($0)
	lw $s1, 18($0)

	sw $t0, 3($0)
	sw $t1, 1($0)
	sw $t2, 4($0)
	sw $t3, 2($0)
	sw $t4, 9($0)
	sw $t5, 10($0)
	sw $t6, 13($0)
	sw $t7, 14($0)
	sw $t8, 17($0)
	sw $t9, 18($0)
	sw $s0, 5($0)
	sw $s1, 6($0)

	addi $s0, $0, 7 	# storing code for Uc in $s0
	sw $s0, 0($27)		# storing Uc in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop
F:  # 1000 - 8
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 3($0)
	lw $t1, 4($0)
	lw $t2, 6($0)
	lw $t3, 8($0)
	lw $t4, 9($0)
	lw $t5, 10($0)
	lw $t6, 11($0)
	lw $t7, 12($0)
	lw $t8, 13($0)
	lw $t9, 15($0)
	lw $s0, 21($0)
	lw $s1, 22($0)

	sw $t0, 13($0)
	sw $t1, 15($0)
	sw $t2, 4($0)
	sw $t3, 3($0)
	sw $t4, 10($0)
	sw $t5, 12($0)
	sw $t6, 9($0)
	sw $t7, 11($0)
	sw $t8, 22($0)
	sw $t9, 21($0)
	sw $s0, 6($0)
	sw $s1, 8($0)

	addi $s0, $0, 8 	# storing code for F in $s0
	sw $s0, 0($27)		# storing F in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop
Fc: # 1001 - 9
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 3($0)
	lw $t1, 4($0)
	lw $t2, 6($0)
	lw $t3, 8($0)
	lw $t4, 9($0)
	lw $t5, 10($0)
	lw $t6, 11($0)
	lw $t7, 12($0)
	lw $t8, 13($0)
	lw $t9, 15($0)
	lw $s0, 21($0)
	lw $s1, 22($0)

	sw $t0, 8($0)
	sw $t1, 6($0)
	sw $t2, 21($0)
	sw $t3, 22($0)
	sw $t4, 11($0)
	sw $t5, 9($0)
	sw $t6, 12($0)
	sw $t7, 10($0)
	sw $t8, 3($0)
	sw $t9, 4($0)
	sw $s0, 15($0)
	sw $s1, 13($0)

	addi $s0, $0, 9 	# storing code for Fc in $s0
	sw $s0, 0($27)		# storing Fc in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop
B:  # 1010 - 10
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 1($0)
	lw $t1, 2($0)
	lw $t2, 5($0)
	lw $t3, 7($0)
	lw $t4, 14($0)
	lw $t5, 16($0)
	lw $t6, 17($0)
	lw $t7, 18($0)
	lw $t8, 19($0)
	lw $t9, 20($0)
	lw $s0, 23($0)
	lw $s1, 24($0)

	sw $t0, 7($0)
	sw $t1, 5($0)
	sw $t2, 23($0)
	sw $t3, 24($0)
	sw $t4, 1($0)
	sw $t5, 2($0)
	sw $t6, 18($0)
	sw $t7, 20($0)
	sw $t8, 17($0)
	sw $t9, 19($0)
	sw $s0, 16($0)
	sw $s1, 14($0)

	addi $s0, $0, 10 	# storing code for B in $s0
	sw $s0, 0($27)		# storing B in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop

Bc: # 1011 - 11
	#addi $sp, $sp, -12
	#sw $ra, 0($sp)
	#sw $s0, 4($sp)
	#sw $s1, 8($sp)

	lw $t0, 1($0)
	lw $t1, 2($0)
	lw $t2, 5($0)
	lw $t3, 7($0)
	lw $t4, 14($0)
	lw $t5, 16($0)
	lw $t6, 17($0)
	lw $t7, 18($0)
	lw $t8, 19($0)
	lw $t9, 20($0)
	lw $s0, 23($0)
	lw $s1, 24($0)

	sw $t0, 14($0)
	sw $t1, 16($0)
	sw $t2, 2($0)
	sw $t3, 1($0)
	sw $t4, 24($0)
	sw $t5, 23($0)
	sw $t6, 19($0)
	sw $t7, 17($0)
	sw $t8, 20($0)
	sw $t9, 18($0)
	sw $s0, 5($0)
	sw $s1, 7($0)

	addi $s0, $0, 11 	# storing code for Bc in $s0
	sw $s0, 0($27)		# storing Bc in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	#lw   $ra, 0($sp)    # read registers from stack
	#lw   $s0, 4($sp)
    #lw   $s1, 8($sp)
    #addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
    nop
    nop

exitSolve2by2:
	addi $s0, $0, 15 # store stop code after moves
	sw $s0, 0($27)
	addi $26, $0, 25	 #adding in 25 to subtract from address count to get
	sub $28, $27, $26	 #subtracts 25 from address counter ($27 - $26) to get move count
	sw $28, 0($0) 		#storing move count3 in dmem

	div $1 $1 $1
