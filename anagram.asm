.globl main
.data
	string1: .string "night"
	string2: .string "thing"
	
.text
main:
	la a0, string1
	la a1, string2
	
	jal checkAnagram
	
	li a7, 93
	ecall

checkAnagram:
	mv s0, a0
	mv s1, a1
	
	addi sp, sp, -4 #Update sp
	sw ra, 0(sp) #Store ra

	jal length #Length of a0
	mv s2, a0 #Move length 1 to s2
	
	lw ra, 0(sp) #Restore ra
	addi sp, sp, 4 #Update sp
	
	addi sp, sp, -4 #Update sp
	sw ra, 0(sp) #Store ra
	
	mv a0, a1
	jal length #Length of a1(a0)
	mv s3, a0 #Move length 2 to s3
	
	lw ra, 0(sp) #Restore ra
	addi sp, sp, 4 #Update sp
	f
	mv a0, s0 # a0 == adress of string 1
	mv a1, s1 # a1 == adress os string 2
	mv t0, s2 # t0 == length of string 1
	mv t1, s3 # t1 == length of string 2
	
	bne t0, t1, noAnagram #If not same length no anagram
	loop1:
		#t0 == length
		mv a1, s1 #Restore adress of a1 in new loop
		li t2, 0 #Found var
		lb t4, (a0) #Current value of index in string 1
		
		beqz t4, endLoop
		
		addi a0, a0, 1 #Next index of char 1
		
		j loop2
		endLoop2:
			beqz t2, notFound #Set not found to 1
			j loop1
			notFound:
				li t6, 1
				j endLoop
		endLoop:
			beqz t6, anagramFound
			j noAnagram
		loop2:
			lb t5, (a1) #Char at string 2
			addi a1, a1, 1 #Update index of string 2
						
			beq t4, t5, equal #If equal set found to 1 and quit loop
			
			bnez t5, loop2 #If not end of string again loop
			j endLoop2
			equal:
				li t2, 1
				j endLoop2
	
noAnagram:
	li a0, -1
	ret
	
anagramFound:
	li a0, 1
	ret
	
length:
	#a0 == adress of array
	li t0, 0 #Length 1
	j loop
	loop:
		lb t1, (a0)
		beqz t1, finish
		addi t0, t0, 1
		addi a0, a0, 1
		j loop
	finish:
		mv a0, t0
		ret
