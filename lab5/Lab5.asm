#raalrwai
#12/6/18
#Lab5
#CMPE12
#Fall 2018
#UCSC
#Compare user input with LabTest propmpts to win game.
#In order to run this file, compile Lab5Test.asm in the same folder as this program
#and enter the prompt shown in the console exactly as shown.
.text
#--------------------------------------------------------------------
give_type_prompt: 
move $t9, $a0

li $v0, 4
la $a0, userInput
syscall
move $a0, $t9
li $v0, 4
syscall

li $v0, 30
syscall
move $v0, $a0
jr $ra

check_user_input_string:
move $t6 $a0 
move $t8 $a1
move $t7 $a2
addi $sp, $sp, -12 # Push stack
sw $ra, 0($sp)

sw $s0, 8($sp)

li $v0, 9 # Allocate memory
lw $a0, 4($sp)
syscall
move $s0, $v0
move $a0, $v0 # Read the string
li $a1 100
la $a0 myarray
li $v0, 8

syscall
move $t4 $a0
move $v0, $a0 # Save string address to return

li $v0, 30
syscall
move $t3, $a0


sub   $t3, $t3, $t8
bgt $t3, $t7, zero
j one

zero:
li $v0 0
lw $ra, 0($sp) # Pop stack
lw $s0, 8($sp)
addi $sp, $sp, 12
jr $ra

one:
li $v0 1
move $a0 $t6
move $a1 $t4

jal compare_strings
lw $ra, 0($sp) # Pop stack
lw $s0, 8($sp)
addi $sp, $sp, 12
jr $ra

# input: $a0 - address of type prompt printed to user
# $a1 - time type prompt was given to user
# $a2 - contains amount of time allowed for response
#
# output: $v0 - success or loss value (1 or 0)
#--------------------------------------------------------------------
#--------------------------------------------------------------------
compare_strings:
#brancho if one in compare_chars
subi $sp $sp 4
sw $ra ($sp)
move $t0 $a0
move $t1 $a1
increment:


lb  $a0 ($t0)
lb $a1 ($t1)
 

jal compare_chars
beqz $a0 exit
beqz $a1 exit
addi $t0, $t0, 1
addi $t1, $t1, 1
j increment
 
 exit:
lw $ra ($sp)
addi $sp $sp 4
jr $ra
# input: $a0 - address of first string to compare
# $a1 - address of second string to compare
#
# output: $v0 - comparison result (1 == strings the same, 0 == strings not the same)
#--------------------------------------------------------------------
#--------------------------------------------------------------------
 
 compare_chars:
move $t2 $a0
move $t5 $a1

beq $t2, $t5 ones
j zeros

ones:
li $v0 1
move $a0 $t2
move $a1 $t5
jr $ra

zeros:
li $v0 0
move $a0 $t2
move $a1 $t5
jr $ra
# input: $a0 - first char to compare (contained in the least significant byte)
# $a1 - second char to compare (contained in the least significant byte)
#
# output: $v0 - comparison result (1 == chars the same, 0 == chars not the same)
#
#--------------------------------------------------------------------
.data
userInput: .asciiz "Type Prompt: "
newLine: .asciiz "\n"
myarray:.space 40    
