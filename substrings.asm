.globl main
.data
string: .string  "blossom"
substring: .string "loss"

.text
main:
	la a0, string
	la a1, substring
	
	jal subString
	
	li t1, 1
	
	beq a0, t1, good
	bne a0, t1, notgood
	


subString:
	li t0, 1 #Still good
	lb t1, (a1) #First char of substring

	j findFirstIndex
	
	findFirstIndex:
		lb t2, (a0) #Current value of main string
		beqz t2, notFound
		beq t1, t2, foundFirstIndex
		addi a0, a0, 1 #Update index of main string
		j findFirstIndex
		
	foundFirstIndex:
		li t2, 1 #Still good 
		j loop
		loop:
			lb t0, (a0) #Value of substring char in main string
			lb t1, (a1) #Value char of substring
			
			beqz t1, endOfSubstring #If end of substring => check if still good
			beqz t0, notFound #If end of string => not found cause there is still char in substring
			bne t0, t1, notFound #If chars not equal = not found
			
			addi a0, a0, 1 #Go to next char in substring
			addi a1, a1, 1 #Go to next char in substring
			li t2, 1 #Found so keep t2 = 1
			j loop
		endOfSubstring: 
			beqz t2, notFound #Not found
			#Otherwise found
			li t0, 1
			mv a0, t0
			ret
	
	notFound:
		li t0, -1
		mv a0, t0
		ret
	found:
		li t0, 1
		mv a0, t0
		ret
		
good: 
	li t4, 1
	j end
	
notgood:
	li t4, -1
	j end
end:
	li a7, 93
	ecall