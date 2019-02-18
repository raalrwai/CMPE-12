.text
main: #main section of program
li	$v0, 4
la	$a0, userInput
syscall
li	$v0, 5
syscall
la	$t0, ($v0)
la      $t2, 0
second:   #check if counter is divisible by 5 or 7

 rem $t5, $t2, 5
 rem $t7, $t2, 7


beqz $t5, next #if divisible by 5
beqz $t7, next2#by 7
j next4 #not divisible by both

next:   #print out flux and a spaced bunny if divisble by both
li	$v0, 4 
 la	$a0, flux
 syscall
 beqz   $t7, next3
 j      newLineZero 
next2:  #print out bunny if divisble by 7
li	$v0, 4
la	$a0, bunny
syscall
j incrementByOne
next3:  #print out spaced bunny
li	$v0, 4
la	$a0, fluxBunny
syscall
j incrementByOne
terminate: 
li      $v0, 10
syscall
j incrementByOne
newLineZero:
beq  $t0, $t2, terminate
j incrementByOne
next4:  #print out ubteger abd replace counter with register.
li     $v0, 1
move    $a0,  $t2 #replaces a zero with the register t2
syscall
j incrementByOne
incrementByOne:  #increment by one and jump to comparison
    beq $t0, $t2, terminate
    li $v0, 4
    la $a0, newLine
    syscall
    addi	$t2, $t2, 1
    j second
.data
userInput: .asciiz "Please input a positive integer: "
flux: .asciiz "Flux"
bunny: .asciiz "Bunny"
fluxBunny: .asciiz " Bunny"
newLine: .asciiz "\n"