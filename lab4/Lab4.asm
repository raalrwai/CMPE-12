#Rami Alrwais, 
#raalrwai, 
#11/22/18, 
#Lab4,
#CMPE12, 
#Fall 2018,
#UC Santa Cruz,
#Takes in program arguments and convert them to decimal and two's complement to compute the sum 
#and print out to the command line,
#To add program argument's, compile the program by pressing Run and Assemble, then head to 
#the execute section and input a maximum of two values in the range of -64 to 63 to compute
#the respective sums.  

#PseudoCode:
#Reads in values from Argument Line.
#Stores these values in memory address's.
#Loads the address's of values.
#DeReference the value's twice
#to perform some sort of arithmitic or conversion.
#Print these stored values along with pre stored
#data messages indicating what each converion
#represents; Two's complement Binary, Arithmitic or Morris.

.text 
main: #main section of program

li $v0 4          #Print user message
la $a0, userInput
syscall

li $v0 4
la  $a0, newLine
syscall

la $t0, ($a1)    #load address of first address
lw $t1, ($t0)
lb $t3, ($t1)

li $v0, 4        #print the argument
la $a0, ($t1)
syscall

li $v0, 4         #load a space in between inputs
la $a0, space
syscall 

lw $t5, 4($t0)    #load second input 
li $v0 4
la $a0, ($t5)
lb $t4,  ($t5)
syscall

LOOP1: nop
subi $t3 $t3 48
beq $t3 -48 LOOP2
nop
blt $t3, $zero, NEG1 
nop

                 #Add the current digit to s1
mul $s1 $s1 10   #add   $t5, $t4, $t3  
add $s1 $t3 $s1 
addi $t1 $t1 1
lb $t3 ($t1)

b LOOP1
nop

NEG1: nop
   add $t6 $t6 1  # $t6 is reserved for negaive flag for first number
   addi $t1 $t1 1
   lb $t3 ($t1)
   b LOOP1
   nop


LOOP2: nop
subi $t4 $t4 48
beq $t4 -48 SUM
nop
blt $t4, $zero, NEG2 
nop

                  #Add the current digit to s1
mul $s2 $s2 10    #add   $t5, $t4, $t3  
add $s2 $t4 $s2 
addi $t5 $t5 1
lb $t4 ($t5)

b LOOP2
nop         

NEG2: nop
   add $t7 $t7 1  # $t6 is reserved for negaive flag for first number
   addi $t5 $t5 1
   lb $t4 ($t5)
   b LOOP2
   nop   

SUM: nop
beq $t6, 1 TC1
beq $t7, 1 TC2
b CONT
TC1:nop              #twos complement
        not $s1 $s1
        addi $s1 $s1 1
        addi $t6 $t6 -1
        b SUM
        nop


TC2:nop            #twos complement
        not $s2 $s2
        addi $s2 $s2 1
        addi $t7 $t7 -1
        b CONT
        nop

PRINT:
li $v0 4         #new line
la  $a0, newLine
syscall

li $v0 4         #Print sum in decimal
la $a0, flux
syscall

li $v0 4         #new line
la  $a0, newLine

CONT:
li $v0 4         #new line
la  $a0, newLine
syscall

li $v0 4         #new line
la  $a0, newLine
syscall

li $v0 4         #Print sum in decimal
la $a0, flux
syscall

li $v0 4         #new line
la  $a0, newLine
syscall

add $s0 $s1 $s2  #SUM o9f the two numbers

move $t8 $s0
move $t9 $s0
ble $s0 $zero NEG3   
CHECK:
bge $t8, 100, LOOP4

j  LOOP3
LOOP4:

li $v0, 11
div    $t0 $t8 100
addi $a0 $t0 48

syscall
mfhi $t1
div $t2 $t0 10
addi $a0  $t1  48
syscall
mfhi $t3
addi $a0 $t3 48
syscall
j TCFINISH
LOOP3: nop

li $v0, 11
div $t4 $t8 10
addi $a0 $t4 48

syscall
mfhi $t5
addi $a0  $t5  48
syscall
nop
j TCFINISH
NEG3: nop
li $a0, 45
li $v0  11
syscall
mul $t8 $s0 -1
j CHECK
                  
TCFINISH: 
li $v0 4         #new line
la  $a0, newLine
syscall

li $v0 4         #new line
la  $a0, newLine
syscall

li $v0 4         #Print sum in twos complement
la $a0, fluxBunny
syscall

li $v0 4         #new line
la  $a0, newLine
syscall

la      $t4, -1
lw  $t1, mask
tcmask:
addi $t4, $t4, 1
beq $t4, 32,  terminate
and $t2, $t1, $s0
beqz  $t2, fin    
#beq  $t2, $t1, fin
li $v0 11
la $a0 49
syscall
srl $t1, $t1, 1
j tcmask
 
fin:
li $v0 11
la $a0 48
syscall
srl $t1, $t1, 1
j tcmask 
    
terminate:
    li $v0 4         #new line
    la  $a0, newLine
    syscall
    li  $v0, 10
    syscall
.data
mask: .word 0X80000000
userInput: .asciiz "You entered the decimal numbers: "
flux: .asciiz "The sum in decimal is: "
space: .asciiz " "
fluxBunny: .asciiz "The sum in two’s complement binary is: "
newLine: .asciiz "\n"

