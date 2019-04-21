addi $sp, $sp 65535 #initializing stack pointer (unsure if necessary)
addi $27, $0, 0 # $r27 will be used to count moves stored

SolveFrontTopRightCorner:
	addi $a0, $0, 0 #green
	addi $a1, $0, 3 #yellow
	addi $a2, $0, 2 #orange

	#SWs FOR TESTING ()
	sw $a0, 4($0)
	sw $a1, 13($0)
	sw $a2, 10($0)
	#END TESTING
	jal FrontTopRightUp
	bne $v0, $0, exit

	addi $rstatus, $0, 17 #for sadness

	j exit

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

exit:
	addi $rstatus, $0, 31