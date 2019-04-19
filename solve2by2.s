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
addi $sp, $sp 65535 #initializing stack pointer (unsure if necessary)
addi $27, $0, 0 # $r27 will be used to count moves stored
# either store 25 in $r27 initially and add 0 with every sw
# or store 0, and add 25 every time

# assume that somehow the 24 colors have been put 
# into the appropriate positions in memory (0-23)

# keep track of a counter in a register to see 
# how many moves you've used? store moves in dmem starting
# at address 24, after the cube state is stored?

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
	sw $a0, 10($0)
	sw $a1, 4($0)
	sw $a2, 13 ($0)
	#END TESTING
	jal FrontTopRightUp
	bne $v0, $0, SolveFrontTopLeftCorner
	
	jal FrontTopLeftFront
	bne $v0, $0, FrontTopLeftFront2FrontTopRightUp
	# at the end of each 2FrontTopRightUp, jump to SolveFrontTopRightCorner
	# so that it checks again to make sure it actually worked
	# note though that if the movements don't work you'll be stuck in an 
	# infinite loop


SolveFrontTopLeftCorner:
	add $v0, $0, $0 #re-initialize output argument

SolveBackTopRightCorner:

SolveBackTopLeftCorner:

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
		addi $sp, $sp, 4
		jr $ra

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
		addi $sp, $sp, 4
		jr $ra

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
		addi $sp, $sp, 4
		jr $ra

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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra

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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra

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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra

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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra

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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra

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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra
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
		addi $sp, $sp, 4
		jr $ra



# move sequences from state 1 to state 2
FrontTopLeftFront2FrontTopRightUp:
	# RF'R'DF'
FrontTopLeftUp2FrontTopRightUp:
	# F'DFDF'
FrontTopLeftLeft2FrontTopRightUp:
	# F #yes this one is done

FrontTopRightFront2FrontTopRightUp:
	# L'FLBRB'
# FrontTopRightUp2FrontTopRightUp:
FrontTopRightRight2FrontTopRightUp:
	# BR'B'L'F'L

FrontBottomLeftFront2FrontTopRightUp:
	# DL'F'L
FrontBottomLeftDown2FrontTopRightUp:
	# L'FFLBRB'
FrontBottomLeftLeft2FrontTopRightUp:
	# DBRB'

FrontBottomRightFront2FrontTopRightUp:
	# BRB'
FrontBottomRightDown2FrontTopRightUp:
	# L'F'LBR'B'L'F'L
FrontBottomRightRight2FrontTopRightUp:
	# L'F'L

# direction of back corners taken from perspective of front
# so BackTopLeft is adjacent to FrontTopLeft
BackTopLeftBack2FrontTopRightUp:
	# R'BRD'D'BRB'
BackTopLeftUp2FrontTopRightUp:
	# FL'F'D'D'BRB'
BackTopLeftLeft2FrontTopRightUp:
	# FL'F'DDL'F'L

BackTopRightBack2FrontTopRightUp: 
	# R' 	#yes this one is done
BackTopRightUp2FrontTopRightUp:
	# LB'L'D'R
BackTopRightRight2FrontTopRightUp:
	# F'RFD'R

BackBottomLeftBack2FrontTopRightUp:
	# D'D'BRB'
BackBottomLeftDown2FrontTopRightUp:
	# DDL'F'LBR'B'L'F'L
BackBottomLeftLeft2FrontTopRightUp:
	# DDL'F'L

BackBottomRightBack2FrontTopRightUp:
	# D'L'F'L
BackBottomRightDown2FrontTopRightUp:
	# D'L'F'LBR'B'L'F'L
BackBottomRightRight2FrontTopRightUp:
	# D'BRB'



FrontTopLeftFront2FrontTopLeftUp:
	# RF'R'B'L'B
#FrontTopLeftUp2FrontTopLeftUp
FrontTopLeftLeft2FrontTopLeftUp:
	# B'LBRFR'

FrontTopRightFront2FrontTopLeftUp:
	# FD'RFR'
FrontTopRightUp2FrontTopLeftUp:
	# R'D'RF
FrontTopRightRight2FrontTopLeftUp:
	# BR'B'D'B'L'B

FrontBottomLeftFront2FrontTopLeftUp:
	# B'L'B
FrontBottomLeftDown2FrontTopLeftUp:
	# DDB'L'BRFR'
FrontBottomLeftLeft2FrontTopLeftUp:
	# RFR'

FrontBottomRightFront2FrontTopLeftUp:
	# D'RFR'
FrontBottomRightDown2FrontTopLeftUp:
	# DDL'FLF'D'B'L'B
FrontBottomRightRight2FrontTopLeftUp:
	# D'B'L'B

BackTopLeftBack2FrontTopLeftUp:
	# L	# yes this one is done
BackTopLeftUp2FrontTopLeftUp:
	# R'BRDL'
BackTopLeftLeft2FrontTopLeftUp:
	# FL'F'DL'

BackTopRightBack2FrontTopLeftUp:
	# LB'L'DDB'L'B
BackTopRightUp2FrontTopLeftUp:
	# B'D'D'BRFR'
BackTopRightRight2FrontTopLeftUp:
	# F'RFD'D'RFR'

BackBottomLeftBack2FrontTopLeftUp:
	# DRFR'
BackBottomLeftDown2FrontTopLeftUp:
	# DRFR'B'LBRFR'
BackBottomLeftLeft2FrontTopLeftUp:
	# DL'

BackBottomRightBack2FrontTopLeftUp:
	# DDB'L'B
BackBottomRightDown2FrontTopLeftUp:
	# DFL'F'LD'RFR'
BackBottomRightRight2FrontTopLeftUp:
	# DDRFR'



FrontTopLeftFront2BackTopLeftUp:
	# L'	#yes this is done
FrontTopLeftUp2BackTopLeftUp:
	# RF'R'D'L
FrontTopLeftLeft2BackTopLeftUp:
	# B'LBD'L

FrontTopRightFront2BackTopLeftUp:
	# L'FLDDFLF'
FrontTopRightUp2BackTopLeftUp:
	# L'F'LD'FLF'
FrontTopRightRight2BackTopLeftUp:
	# BR'B'DDR'B'R

FrontBottomLeftFront2BackTopLeftUp:
	# D'R'B'R
FrontBottomLeftDown2BackTopLeftUp:
	# D'L'D'LFL'F'R'B'R
FrontBottomLeftLeft2BackTopLeftUp:
	# D'FLF'

FrontBottomRightFront2BackTopLeftUp:
	# D'D'FLF'
FrontBottomRightDown2BackTopLeftUp:
	# DDL'DLDDR'B'R
FrontBottomRightRight2BackTopLeftUp:
	# DDR'B'R

BackTopLeftBack2BackTopLeftUp:
	# R'BRFLF'
#BackTopLeftUp2BackTopLeftUp:
BackTopLeftLeft2BackTopLeftUp:
	# FL'F'R'B'R

BackTopRightBack2BackTopLeftUp:
	# LB'L'DB'
BackTopRightUp2BackTopLeftUp:
	# F'RF 
BackTopRightRight2BackTopLeftUp:
	# B

BackBottomLeftBack2BackTopLeftUp:
	# FLF'
BackBottomLeftDown2BackTopLeftUp:
	# R'B'RFL'F'R'B'R
BackBottomLeftLeft2BackTopLeftUp:
	# R'B'R

BackBottomRightBack2BackTopLeftUp:
	# DR'B'R
BackBottomRightDown2BackTopLeftUp:
	# DBD'B'DDFLF'
BackBottomRightRight2BackTopLeftUp:
	# R'BR





FrontTopLeftFront2BackTopRightUp:
	# RF'R'DDF'R'F
FrontTopLeftUp2BackTopRightUp:
	# RFR'DF'R'F
FrontTopLeftLeft2BackTopRightUp:
	# B'LBDDLBL'

FrontTopRightFront2BackTopRightUp:
	# L'FLDLBL'
FrontTopRightUp2BackTopRightUp:
	# BR'B'DLBL'
FrontTopRightRight2BackTopRightUp:
	# BR'B'DR'

FrontBottomLeftFront2BackTopRightUp:
	# DDF'R'F
FrontBottomLeftDown2BackTopRightUp:
	# F'DR'F
FrontBottomLeftLeft2BackTopRightUp:
	# B'DDB

FrontBottomRightFront2BackTopRightUp:
	# DLBL'
FrontBottomRightDown2BackTopRightUp:
	# FDDF'
FrontBottomRightRight2BackTopRightUp:
	#

BackTopLeftBack2BackTopRightUp:
BackTopLeftUp2BackTopRightUp:
BackTopLeftLeft2BackTopRightUp:

BackTopRightBack2BackTopRightUp:
#BackTopRightUp2BackTopRightUp:
BackTopRightRight2BackTopRightUp:

BackBottomLeftBack2BackTopRightUp:
BackBottomLeftDown2BackTopRightUp:
BackBottomLeftLeft2BackTopRightUp:

BackBottomRightBack2BackTopRightUp:
BackBottomRightDown2BackTopRightUp:
BackBottomRightRight2BackTopRightUp:




# moves
L:  # 0000 - 0
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

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
	lw $s1, 23($0

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

	lw   $ra, 0($sp)    # read registers from stack
	lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    addi $sp, $sp, 12   # bring back stack pointer
    jr $ra


Lc: # 0001 - 1
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

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
	lw $s1, 23($0

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
	sw $s0, 0($27)		# storing L in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	lw   $ra, 0($sp)    # read registers from stack
	lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
R:  # 0010 - 2
Rc: # 0011 - 3
D:  # 0100 - 4
Dc: # 0101 - 5
U:  # 0110 - 6
Uc: # 0111 - 7
F:  # 1000 - 8
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

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
	lw $s1, 22($0

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

	addi $s0, $0, 8 	# storing code for Lc in $s0
	sw $s0, 0($27)		# storing L in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	lw   $ra, 0($sp)    # read registers from stack
	lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
Fc: # 1001 - 9
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

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
	lw $s1, 22($0

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

	addi $s0, $0, 9 	# storing code for Lc in $s0
	sw $s0, 0($27)		# storing L in memory
	addi $27, $27, 1 	# incrementing counter to store move location

	lw   $ra, 0($sp)    # read registers from stack
	lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    addi $sp, $sp, 12   # bring back stack pointer
    jr $ra
B:  # 1010 - 10
Bc: # 1011 - 11
