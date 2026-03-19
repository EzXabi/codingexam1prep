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
 	li t3, 1 #Make sure notfound check doesn't trigger in first cycle
	j loopString
	
	loopString:
		lb t1, (a1) #Current char of substring
		beqz t3, notFound #If mainstringloop did not found current char of substring 
		beqz t1, endSearch
		
		addi a1, a1, 1 #Increase index of substring
		li t3, 0 #Found substring in main string
		j mainStringLoop
		#Find substring char in main string
		mainStringLoop:
			lb t2, (a0) #Load current main string char
			beqz t2, loopString
			addi a0, a0, 1 #Update index of mainstring
			beq t2, t1, foundString #If found substring quit loop
			j mainStringLoop #If not found try next char of mainstring
			
		foundString: 
			li t3, 1
			j loopString
		notFound:
			li t0, 0
		
	endSearch:
		beqz t0, badFinish #=== Bad finish
		#Otherwise => good finish
		li a0, 1 
		ret
		
		badFinish:
			li a0, -1
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