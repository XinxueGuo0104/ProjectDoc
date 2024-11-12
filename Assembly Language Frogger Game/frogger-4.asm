#####################################################################
#
# CSC258H5S Fall 2021 Assembly Final Project
# University of Toronto, St. George
#
# Student: Xinxue Guo, 1005025697
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4/5 (choose the one the applies)
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. Display the number of lives remaining.
# 2. After final player death, display game over/retry screen. Restart the game if the “retry” option is chosen.
# 3. Display a death/respawn animation each time the player loses a frog.
# 4. Make the frog point in the direction that it’s traveling.
# 5. Add sound effects for movement, collisions, game end and reaching the goal area.
# 6. Add powerups to scene (slowing down time, score booster, extra lives, etc)
# Any additional information that the TA needs to know:
# - (write here, if any)
#
##################################################################### Submission



.data
############## BACKGROUND ###################
 	displayAddress: .word 0x10008000
 	frogAddress: .word 3640
 	yellow: .word 0xF2E34C
 	green: .word 0x00D100 
 	blue: .word 0x5C5CFF
 	grey: .word 0x525252
 	pink: .word 0xE151AF
 	lcolor: .word 0xFF007F
 	brown: .word 0x603000
 	red: .word  0xFF1111
 	white: .word 0xffffff
 	black: .word 0x000000
 	gcolor: .word 0xE6E2EC
 	Address1: .word 256 #background 1
 	Address12: .word 528 #
 	Address13: .word 568 #
 	Address14: .word 608
 	Address2: .word 1024 #background 2
 	Address3: .word 2048 #background 3
 	Address4: .word 2560 #background 4
 	Address5: .word 3584 #background 5
 	life1p: .word 4
 	life2p: .word 12
 	life3p: .word 20
 	gamelc: .word 784
 	gamelo: .word 2064
 	winnn: .word 1684
 ############	CAR1 LOCATION ##########
	car1line1: .word 2560  
	car1line2: .word 2688
	car1line3: .word 2816
	car1line4: .word 2944
	car1right1: .word 2684
	car1right2: .word 2812
	car1right3: .word 2940
	car1right4: .word 3068
	car1mid1: .word 2716
	car1mid2: .word 2844
	car1mid3: .word 2972
	car1mid4: .word 3100
	
############## CAR2 LOCATION ############	
	car2line1: .word 2652
	car2line2: .word 2780
	car2line3: .word 2908
	car2line4: .word 3036

########### CAR3 LOCATION ################	
	car3line1: .word 3116
	car3line2: .word 3244
	car3line3: .word 3372
	car3line4: .word 3500

########### CAR4 LOCATION ################
	car4line1: .word 3180
	car4line2: .word 3308
	car4line3: .word 3436
	car4line4: .word 3564
	car4right1: .word 3072
	car4right2: .word 3200
	car4right3: .word 3328
	car4right4: .word 3456
	car4dis1: .word 3196
	car4dis2: .word 3324
	car4dis3: .word 3452
	car4dis4: .word 3580
	car4lef1: .word 3052
	car4lef2: .word 3180
	car4lef3: .word 3308
	car4lef4: .word 3436
	
########## WOOD1 LOCATION #############
	wood1line1: .word 1052
	wood1line2: .word 1180
	wood1line3: .word 1308	
	wood1line4: .word 1436	


########## WOOD2 LOCATION #############
	wood2line1: .word 1116
	wood2line2: .word 1244
	wood2line3: .word 1372
	wood2line4: .word 1500
	wood2dis1: .word 1148
	wood2dis2: .word 1276
	wood2dis3: .word 1404
	wood2dis4: .word 1532
	wood2right1: .word 1024
	wood2right2: .word 1152
	wood2right3: .word 1280
	wood2right4: .word 1408
	

######### WOOD3 LOCATION ###############
	wood3line1: .word 1568
	wood3line2: .word 1696
	wood3line3: .word 1824
	wood3line4: .word 1952
	wood3dis1: .word 1536
	wood3dis2: .word 1664
	wood3dis3: .word 1792
	wood3dis4: .word 1920
	wood3right1: .word 1660
	wood3right2: .word 1788
	wood3right3: .word 1916
	wood3right4: .word 2044
	
		
######## WOOD4 LOCATION ################	
	wood4line1: .word 1660
	wood4line2: .word 1788
	wood4line3: .word 1916	
	wood4line4: .word 2044

#########   error number #####
	erc: .word 3	
	
######### MUSIC ############
	downn: .word 0
	leff: .word 14
	music: .word 76, 40, 70, 60

########## Heart ##########
	heart: .word 2100
																		
.text
NE:	la $t8, green 
	la $t3, Address1
	lw $t2, 0($t3)
	jal BK 
QQ:	la $t8, gcolor
	la $t3, Address12
	lw $t2, 0($t3)
	jal EK
  	la $t8, gcolor
	la $t3, Address13
	lw $t2, 0($t3)
	jal EK
	la $t8, gcolor
	la $t3, Address14
	lw $t2, 0($t3)
	jal EK
BEG:	
	lw $t0, displayAddress
	la $t8, white 
	la $t3, life1p
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	
	
	

	j START
########## RESET  #########
ERROR: 	lw $t9, erc
	subi $t9, $t9, 1
	sw $t9, erc
	addi $t1, $zero, 3640
	sw $t1, frogAddress
	
	
	jal DDFG
	
	
	la   $s6, music     #music
   	li   $s4, 500        # Duration of base (i.e., eighth) note in milliseconds
  	lw   $a0, 0($s6)     # Load notes[0]    
  	move $a1, $s4        # Set duration of note 
  	li   $a2, 127          # Set the MIDI patch [0-127] (zero is basic piano)
  	li   $a3, 64         # Set a moderate volume [0-127]
 	 li   $v0, 33         # Asynchronous play sound system call
  	syscall  
  
	beq $t9, 2, DREW
	beq $t9, 1, DREW1
	beq $t9, 0, OVER
DREW:
	lw $t0, displayAddress
	la $t8, black 
	la $t3, life1p
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	j START
DREW1: 	
	lw $t0, displayAddress
	la $t8, black 
	la $t3, life2p
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	j START

OVER:   la   $s6, music     #music
   	li   $s4, 500        # Duration of base (i.e., eighth) note in milliseconds
  	lw   $a0, 12($s6)     # Load notes[0]    
  	move $a1, $s4        # Set duration of note 
  	li   $a2, 113         # Set the MIDI patch [0-127] (zero is basic piano)
  	li   $a3, 127         # Set a moderate volume [0-127]
 	li   $v0, 33         # Asynchronous play sound system call
  	syscall
	jal GAMEOVER
OCCK:	lw $t8, 0xffff0000
	beq $t8, 1, keyboard
keyboard:lw $t2, 0xffff0004
	beq $t2, 0x72, NE
	j OCCK
	
	
		
#keyboard check 
START:	
	


KBSET:	addi $t8, $zero, 0
	sw $t8, downn	
	
	#addi $s4, $zero, 0 #counter for down (S)
	addi $s5, $zero, 6 #counter for upper (W)
	
	addi $t8, $zero, 14
	sw $t8, leff
	#addi $s6, $zero, 14 #counter for left (A)
	addi $s7, $zero, 14 #counnter for right (D)


#### basic set up ###
SET:	addi $s0, $zero, 0
	addi $s1, $zero, 0
	addi $s2, $zero, 12
	addi $s3, $zero, 16

	  
#Drew the background
TOP:	lw $t7, frogAddress
	lw $t8, heart
	beq $t7, $t8, addlife 
	j WWW
addlife:addi $t9, $zero, 3
	sw $t9, erc

WWW:	lw $t9, erc
	addi $t6, $zero, 3
	beq $t9, $t6, ADLFS
	j SEC
ADLFS:	lw $t0, displayAddress
	la $t8, white 
	la $t3, life1p
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)


SEC:	la $t8, blue
	la $t3, Address2
	lw $t2, 0($t3)
	jal BK
TH:	la $t8, yellow
	la $t3, Address3
	lw $t2, 0($t3)
	jal CK
FO:	la $t8, grey
	la $t3, Address4
	lw $t2, 0($t3)
	jal BK	
FD:	la $t8, green
	la $t3, Address5
	lw $t2, 0($t3)
	jal CK

HH:	jal ADHT
 #Drew the car
 ################  CAR 111111 #############
 #CAR1 left disappear
 	
CAL1:	lw $t1, car1line1
	la $t4, red #color
	la $t0, 0x10008000
	jal CKK
C1L2:	lw $t1, car1line2
	la $t4, red #color
	la $t0, 0x10008000
	jal CKK
C1L3:	lw $t1, car1line3
	la $t4, red #color
	la $t0, 0x10008000
	jal CKK
C1L4:	lw $t1, car1line4
	la $t4, red #color
	la $t0, 0x10008000
	jal CKK
#CAR1 right appear
C1R1:	lw $t1, car1right1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK1
C1R2:	lw $t1, car1right2
	la $t4, red #color
	la $t0, 0x10008000
	jal CK1
C1R3:	lw $t1, car1right3
	la $t4, red #color
	la $t0, 0x10008000
	jal CK1
C1R4:	lw $t1, car1right4
	la $t4, red #color
	la $t0, 0x10008000
	jal CK1	
# CAR1 mid appear
MIDL1:	lw $t1, car1mid1
	sub $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK2
MIDL2:	lw $t1, car1mid2
	sub $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK2
MIDL3:	lw $t1, car1mid3
	sub $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK2	
MIDL4:	lw $t1, car1mid4
	sub $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK2
	

########### CAR 222222 ##################
C2L1:	lw $t1, car2line1
	sub $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal MLMID
C2L2:	lw $t1, car2line2
	sub $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal MLMID
C2L3:	lw $t1, car2line3
	sub $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal MLMID
C2L4:	lw $t1, car2line4
	sub $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal MLMID

####### CAR 3333333 ################
C3L1:	lw $t1, car3line1
	add $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal MIDMR

C3L2:	lw $t1, car3line2
	add $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal MIDMR

C3L3:	lw $t1, car3line3
	add $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal MIDMR

C3L4:	lw $t1, car3line4
	add $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal MIDMR

######## CAR 4444444 #############
###FIRST FOUR SQUARE ########
C4L1:	lw $t1, car4line1
	add $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK3
C4L2:	lw $t1, car4line2
	add $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK3
C4L3:	lw $t1, car4line3
	add $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK3
C4L4:	lw $t1, car4line4
	add $t1, $t1, $s1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK3

# THE EIGHT SQUARE 
C4R1:	lw $t1, car4right1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK4
C4R2:	lw $t1, car4right2
	la $t4, red #color
	la $t0, 0x10008000
	jal CK4
C4R3:	lw $t1, car4right3
	la $t4, red #color
	la $t0, 0x10008000
	jal CK4
C4R4:	lw $t1, car4right4
	la $t4, red #color
	la $t0, 0x10008000
	jal CK4

# THE EIGHT DISAPPEAR 

C4D1:	lw $t1, car4dis1
	la $t4, red #color
	la $t0, 0x10008000
	jal CK5
C4D2:	lw $t1, car4dis2
	la $t4, red #color
	la $t0, 0x10008000
	jal CK5
C4D3:	lw $t1, car4dis3
	la $t4, red #color
	la $t0, 0x10008000
	jal CK5
C4D4:	lw $t1, car4dis4
	la $t4, red #color
	la $t0, 0x10008000
	jal CK5

# THE LEFT FOUE STEP 
C4F1:	lw $t1, car4lef1
	la $t4, red #color
	add $t1, $t1, $s1
	la $t0, 0x10008000
	jal CK6
C4F2:	lw $t1, car4lef2
	la $t4, red #color
	add $t1, $t1, $s1
	la $t0, 0x10008000
	jal CK6
C4F3:	lw $t1, car4lef3
	la $t4, red #color
	add $t1, $t1, $s1
	la $t0, 0x10008000
	jal CK6
C4F4:	lw $t1, car4lef4
	la $t4, red #color
	add $t1, $t1, $s1
	la $t0, 0x10008000
	jal CK6

#Drew the WOOD

############### WOOD 111111111 #############
W1L1:	lw $t1, wood1line1
	add $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal MIDMR

W1L2:	lw $t1, wood1line2
	add $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal MIDMR

W1L3:	lw $t1, wood1line3
	add $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal MIDMR

W1L4:	lw $t1, wood1line4
	add $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal MIDMR

################# WOOD 2222222222 ############
##First 8 Step
W2L1:	lw $t1, wood2line1
	add $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK7
W2L2:	lw $t1, wood2line2
	add $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK7
W2L3:	lw $t1, wood2line3
	add $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK7
W2L4:	lw $t1, wood2line4
	add $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK7

# Right Disappear
W2D1:	lw $t1, wood2dis1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK8
W2D2:	lw $t1, wood2dis2
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK8
W2D3:	lw $t1, wood2dis3
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK8
W2D4:	lw $t1, wood2dis4
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK8

## WOOD 2  RIGHT APPEAR 8
W2R1:	lw $t1, wood2right1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK9
W2R2:	lw $t1, wood2right2
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK9
W2R3:	lw $t1, wood2right3
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK9
W2R4:	lw $t1, wood2right4
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK9



################  WOOD 3333333 #############
W3L1:	lw $t1, wood3line1
	sub $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK10
W3L2:	lw $t1, wood3line2
	sub $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK10
W3L3:	lw $t1, wood3line3
	sub $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK10
W3L4:	lw $t1, wood3line4
	sub $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK10

	
# Right Disappear
W3D1:	lw $t1, wood3dis1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK11
W3D2:	lw $t1, wood3dis2
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK11
W3D3:	lw $t1, wood3dis3
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK11
W3D4:	lw $t1, wood3dis4
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK11

## WOOD 3  RIGHT APPEAR 8
W3R1:	lw $t1, wood3right1
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK12
W3R2:	lw $t1, wood3right2
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK12
W3R3:	lw $t1, wood3right3
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK12
W3R4:	lw $t1, wood3right4
	la $t4, brown #color
	la $t0, 0x10008000
	jal CK12	

################ WOOD 444444444 #############
W4L1:	lw $t1, wood4line1
	sub $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal MLMID
W4L2:	lw $t1, wood4line2
	sub $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal MLMID
W4L3:	lw $t1, wood4line3
	sub $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal MLMID
W4L4:	lw $t1, wood4line4
	sub $t1, $t1, $s1
	la $t4, brown #color
	la $t0, 0x10008000
	jal MLMID

	
	
#######################Drew the frog###############

CHECK:	lw $t8, 0xffff0000
	beq $t8, 1, keyboard_input
	j FROG
 	
 	
FROG:	la $t7, frogAddress
	lw $t2, 0($t7)
	la $t0, 0x10008000
	add $t1, $t0, $t2
	lw $t3, 0($t1)
	addi $t5, $t1, 12
	lw $t6, 0($t5)
	la $t8, brown
	lw $t9, 0($t8)

	bne $t9, $t3, NO
SFC:	bne $t9, $t6, NO
	

	beq $s5, 2, respond_to_A
	beq $s5, 1, respond_to_D
	

	
	
NO:	jal CAN
	la $t7, frogAddress
	la $t0, 0x10008000
	la $t8, pink
	lw $t5, 0($t8)
	lw $t2, 0($t7)
	add $t1, $t0, $t2
	jal LOOP
	j CIRE
 
 
keyboard_input:	
	lw $t2, 0xffff0004
	
	la   $s6, music     #music
   	li   $s4, 200        # Duration of base (i.e., eighth) note in milliseconds
  	lw   $a0, 4($s6)     # Load notes[0]    
  	move $a1, $s4        # Set duration of note 
  	li   $a2, 112         # Set the MIDI patch [0-127] (zero is basic piano)
  	li   $a3, 127         # Set a moderate volume [0-127]
 	li   $v0, 33         # Asynchronous play sound system call
  	syscall
	
WW:	beq $t2, 0x77, respond_to_W
	j AA
	
	
	
#addi $s5, $zero, 0 #counter for upper (W)
respond_to_W:
	ble $s5, 6, WC
	j WT
WC:	bgtz $s5, MVW
	j WT
MVW:	
	la $t0, 0x10008000
	la $t7, frogAddress
	lw $t2, 0($t7)
	subi $t2, $t2, 512
	sw $t2, frogAddress
	jal CAN
	la $t0, 0x10008000
	la $t8, pink
	la $t7, frogAddress
	lw $t2, 0($t7)
	add $t1, $t0, $t2
	jal LOOP
	subi $s5, $s5, 1
	lw $t9, downn
	addi $t9, $t9, 1
	sw $t9, downn	
	
	
	j CIRE
WT:	
	jal CAN
	la $t0, 0x10008000
	la $t8, pink
	la $t7, frogAddress
	lw $t2, 0($t7)
	add $t1, $t0, $t2
	jal LOOP
	j CIRE

#addi $s4, $zero, 0 #counter for down (S)	
SS:	beq $t2, 0x73, respond_to_S
	j DD
respond_to_S: 
	lw $t9, downn	
	ble $t9, 6, SC
	j ST
SC:	bgtz $t9, MVS
	j ST
MVS:	la $t0, 0x10008000
	la $t7, frogAddress
	lw $t2, 0($t7)
	addi $t2, $t2, 512
	sw $t2, frogAddress
	jal CAN
	la $t0, 0x10008000
	la $t8, pink
	la $t7, frogAddress
	lw $t2, 0($t7)
	add $t1, $t0, $t2
	jal LOOPS
	lw $t9, downn
	subi $t9, $t9, 1
	sw $t9, downn	
	addi $s5, $s5, 1
	j CIRE
ST:	
	jal CAN
	la $t0, 0x10008000
	la $t8, pink
	la $t7, frogAddress
	lw $t2, 0($t7)
	add $t1, $t0, $t2
	jal LOOPS
	j CIRE

#addi $s7, $zero, 14 #counnter for right (D)
DD:	beq $t2, 0x64, respond_to_D
	j DT
respond_to_D: 
	ble $s7, 27, DC
	j DT
DC:	bgtz $s7, MVD
	j DT
MVD:	la $t0, 0x10008000
	la $t7, frogAddress
	lw $t2, 0($t7)
	addi $t2, $t2, 4
	sw $t2, frogAddress
	jal CAN
	la $t0, 0x10008000
	la $t8, pink
	la $t7, frogAddress
	lw $t2, 0($t7)
	add $t1, $t0, $t2
	jal LOOPR
	
	addi $s7, $s7, 1
	lw $t9, leff
	subi $t9, $t9, 1
	sw $t9, leff
	j CIRE
DT:	
	jal CAN
	la $t0, 0x10008000
	la $t8, pink
	la $t7, frogAddress
	lw $t2, 0($t7)
	add $t1, $t0, $t2
	jal LOOPR
	j CIRE

#addi $s6, $zero, 14 #counter for left (A)	
AA: 	beq $t2, 0x61, respond_to_A
	j  SS
respond_to_A: 
	lw $t9, leff
	blt $t9, 28, AC
	j AT
AC:	bgtz $t9, MVA
	j AT
MVA:	la $t0, 0x10008000
	la $t7, frogAddress
	lw $t2, 0($t7)
	subi $t2, $t2, 4
	sw $t2, frogAddress
	jal CAN
	la $t0, 0x10008000
	la $t8, pink
	la $t7, frogAddress
	lw $t2, 0($t7)
	add $t1, $t0, $t2
	jal LOOPL
	lw $t9, leff
	addi $t9, $t9, 1
	sw $t9, leff
	subi $s7, $s7, 1
	j CIRE
AT:	
	jal CAN
	la $t0, 0x10008000
	la $t8, pink
	la $t7, frogAddress
	lw $t5, 0($t8)
	lw $t2, 0($t7)
	add $t1, $t0, $t2
	jal LOOPL
	j CIRE
	
	

##### EACH CIRCLE  #############
CIRE:	
	bgt $s0, 14, SET	
 
CONT:	beq $s5, 0, WIN 
	addi $s0, $s0, 1
	addi $s1, $s1, 4
	subi $s2, $s2, 1
	subi $s3, $s3, 1
	li $v0, 32
	li $a0, 1000
	syscall
	
	j TOP #background 
	

########### WIN #########
WIN: 	la $t8, green
	la $t3, frogAddress
	lw $t2, 0($t3)
	jal EK
	
	la   $s6, music      # Initialize the pointer
  	li   $s4, 1000        # Duration of base (i.e., eighth) note in milliseconds
  	lw   $a0, 0($s6)     # Load notes[0]    
  	move $a1, $s4        # Set duration of note 
  	li   $a2, 6         # Set the MIDI patch [0-127] (zero is basic piano)
 	li   $a3, 127        # Set a moderate volume [0-127]
 	li   $v0, 33         # Asynchronous play sound system call
  	syscall
  	
  	jal WINIMG
  	addi $t1, $zero, 3640
  	sw $t1, frogAddress
  	j START
  
																								
######### THE EXIT ########																		
																														
Exit: 	li $v0, 10
	syscall 
	
	
############################################################################################
############################################################################################	
########## HELPER FOR LINE GO LEFT DECREAS ##############
CKK:	ble $s0, 8, INCL
	j RE
INCL:	addi $t2, $zero, 0 #counter
	addi $t3, $zero, 8 #length
	sub $t3, $t3, $s0 
LOOP1:	beq $t2, $t3, RE
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	addi $t1, $t1, 4
	addi $t2, $t2, 1
	j LOOP1
RE:	jr $ra

########## HELPER FOR LINE GO LEFT INCREASE ##############
CK1:	ble $s0, 8, DEC
	j RET
DEC:	addi $t2, $zero, 0 #counter
DECL:	beq $t2, $s0, RET
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j DECL
RET:	jr $ra

######## HELPER FOR LINE GO MIDE ############
CK2:	bgt $s0, 8, MIDH
	j RES
MIDH:	addi $t2, $zero, 0 #counter
MIDHL:	beq $t2, 8, RES
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j MIDHL
RES:	jr $ra

######## HELPER FOR LINE MOVE LEFT MID POSITION #######

MLMID:	addi $t2, $zero, 0 #counter
MLMIDL:	beq $t2, 8, SAF
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j MLMIDL
SAF:	jr $ra	

####### HELPER FOR MIND MOVE RIGHT ######### 

MIDMR:	addi $t2, $zero, 0 #counter
MIDMRL:	beq $t2, 8, MIDMRE 
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j MIDMRL
MIDMRE:	jr $ra	
				
#######  HELPER FOR FIRST FOUR SQUARE ########
CK3:	bgt $s0, 8 FFSJ
	ble $s0, 4, FFS
	j FFSJ
FFS:	addi $t2, $zero, 0 #counter
FFSL:	beq $t2, 8, FFSJ 
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j FFSL
FFSJ:	jr $ra	

######### HELPER FOR EIGHT RIGHT SQUARE #####
CK4:	bgt $s0, 12, RRFJ
	bgt $s0, 4, RRF
	j RRFJ
RRF:	addi $t2, $zero, 0 #counter
	subi $t7, $s0, 4
RRFL:	beq $t2, $t7, RRFJ 
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	addi $t1, $t1, 4
	addi $t2, $t2, 1
	j RRFL
RRFJ:	jr $ra	

######### HELPER FOR DISAPPEAR #########
CK5:	bgt $s2, 0, KEEP
	j DISJ
KEEP:	bgt $s0, 4, DIS
	j DISJ
DIS:	addi $t2, $zero, 0 #counter
	
DISL:	beq $t2, $s2, DISJ 
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j DISL
DISJ:	
	jr $ra

########## HELPER LEFT FOUR STEP ########
CK6:	bgt $s0, 16, LFTJ
	j KK
KK:	bgt $s0, 12, LFT
	j LFTJ
LFT:	addi $t2, $zero, 0 #counter
LFTL:	beq $t2, 8, LFTJ 
	lw $t5, 0($t4) #load color
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j LFTL
LFTJ:	
	jr $ra


################# HELPER FOR WOOD 2 RIGHT 8 #########
CK7:	bgt $s0, 8 CK7SJ
CK7S:	addi $t2, $zero, 0 #counter
CK7SL:	beq $t2, 8, CK7SJ 
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j CK7SL
CK7SJ:	jr $ra	

#HELPER FOR WOOD 2 DIS 8 
CK8:	ble $s0, 8 CK8J
	bgt $s0, 8, CK8S
CK8S:	addi $t2, $zero, 0 #counter	
CK8L:	beq $t2, $s3, CK8J 
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j CK8L
CK8J:	
	jr $ra

# HELPER FOR WOOD 2 APPEAR 8
CK9:	ble $s0, 8 CK9J
	bgt $s0, 8, CK9F
CK9F:	addi $t2, $zero, 0 #counter
	subi $t7, $s0, 8
CK9L:	beq $t2, $t7, CK9J 
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	addi $t1, $t1, 4
	addi $t2, $t2, 1
	j CK9L
CK9J:	jr $ra	

############## HELPER WOOD 3 ##############
CK10:	bgt $s0, 8 CK10J
CK10S:	addi $t2, $zero, 0 #counter
CK10L:	beq $t2, 8, CK10J 
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	addi $t1, $t1, 4
	addi $t2, $t2, 1
	j CK10L
CK10J:	jr $ra	

#HELPER FOR WOOD 3 DIS 8 
CK11:	bgt $s0, 8 CK11L
	j CK11E
CK11L:	addi $t2, $zero, 0 #counter
	addi $t3, $zero, 16 #length
	sub $t3, $t3, $s0 
CK111:	beq $t2, $t3, RE
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	addi $t1, $t1, 4
	addi $t2, $t2, 1
	j CK111
CK11E:	jr $ra

# HELPER FOR WOOD 3 APPEAR 8
CK12:	ble $s0, 8 CK12J
	bgt $s0, 8, CK12F
CK12F:	addi $t2, $zero, 0 #counter
	subi $t7, $s0, 8
CK12L:	beq $t2, $t7, CK12J 
	lw $t5, 0($t4) #load color  
	add $t6, $t1, $t0 #location
	sw $t5, 0($t6)
	subi $t1, $t1, 4
	addi $t2, $t2, 1
	j CK12L
CK12J:	jr $ra	



########################## HELPER FOR BACKFGROUND ##############
## Road HELPER ###
BK:	addi $t6, $zero, 0 #counter loop1
	addi $t7, $zero, 0 #counter loop2
	la $t0, 0x10008000  
LOPP:	bge $t6, 32, LOPP2
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t6, $t6, 1
	addi $t2, $t2, 4
	j LOPP
LOPP2:	addi $t7, $t7, 1
	beq $t7, 8, FH
	addi $t6, $zero, 0
	addi  $t2, $t2, 0
	j LOPP
FH:	jr $ra


CK:	addi $t6, $zero, 0 #counter loop1
	addi $t7, $zero, 0 #counter loop2
	la $t0, 0x10008000  
LPP:	bge $t6, 32, LPP2
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t6, $t6, 1
	addi $t2, $t2, 4
	j LPP
LPP2:	addi $t7, $t7, 1
	beq $t7, 4, F
	addi $t6, $zero, 0
	addi  $t2, $t2, 0
	j LPP
F:	jr $ra



EK:	addi $t6, $zero, 0 #counter loop1
	addi $t7, $zero, 0 #counter loop2
	la $t0, 0x10008000  
EKP:	bge $t6, 4, EK2
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t6, $t6, 1
	addi $t2, $t2, 4
	j EKP
EK2:	addi $t2, $t2,112 
	addi $t7, $t7, 1
	beq $t7, 4, EKF
	addi $t6, $zero, 0
	j EKP
EKF:	jr $ra


######## DREW THE FROG #########

LOOP:		
	sw $t5, 0($t1)
	add $t1, $t1, 12
	sw $t5, 0($t1)
	add $t1, $t1, 116
	sw $t5, 0($t1)
	add $t1, $t1,4
	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 120
	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 120
	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1) 
	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1)	
	jr $ra 
 
 LOOPL:	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 8
	sw $t5, 0($t1)
	add $t1, $t1, 120
	sw $t5, 0($t1)
 	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 120
	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 116
	sw $t5, 0($t1)
	add $t1, $t1, 4
	sw $t5, 0($t1)
	add $t1, $t1, 8
	sw $t5, 0($t1)
	jr $ra
 
 LOOPR:	sw $t5, 0($t1)
	add $t1, $t1, 8
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 116
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 120
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 120
 	sw $t5, 0($t1)
 	add $t1, $t1, 8
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	jr $ra
 
 LOOPS:	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 120
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 120
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 4
 	sw $t5, 0($t1)
 	add $t1, $t1, 116
 	sw $t5, 0($t1)
 	add $t1, $t1, 12
 	sw $t5, 0($t1)
 	jr $ra
 
 
 
 

############# FROG CHECK ############
CAN:	la $t7, frogAddress
	lw $t2, 0($t7)
	la $t0, 0x10008000
	add $t1, $t0, $t2
	addi $t5, $t1, 12
	lw $t3, 0($t1)
	lw $t6, 0($t5)
	la $t8, red
	lw $t9, 0($t8)
	beq $t9, $t3, ERROR
	beq $t9, $t6, ERROR
	la $t8, blue
	lw $t9, 0($t8)
	beq $t9, $t3, ERROR
	beq $t9, $t6, ERROR
	jr $ra

########### life remaining #########
#### The life number
life3:	la $t9, white
	la $t1, life3p
	la $t0, 0x10008000
	lw $t5, 0($t9) #color 
	lw $t6, 0($t1)
	add $t1, $t6, $t0
	sw $t5, 0($t1)
	
life2:	la $t9, white
	la $t2, life2p
	la $t0, 0x10008000
	lw $t5, 0($t9) #color 
	lw $t7, 0($t2)
	add $t2, $t7, $t0
	sw $t5, 0($t2)	
	
life1:	la $t9, white
	la $t3, life1p
	la $t0, 0x10008000
	lw $t5, 0($t9) #color  
	lw $t8, 0($t3)
	add $t3, $t8, $t0
	sw $t5, 0($t3)
	jr $ra


########### GAME OVER ###########
GAMEOVER:
	lw $t0, displayAddress
	la $t8, black 
	la $t3, life3p
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	
	lw $t0, displayAddress
	la $t8, white 
	la $t3, gamelc
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 32
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 48
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 28
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 48
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 32
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 52
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	
	
	lw $t0, displayAddress
	la $t8, white 
	la $t3, gamelo
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 40
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 36
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 24
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 36
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 24
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 36
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 40
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 24
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 48
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	
	jr $ra
	
WINIMG:	
	lw $t0, displayAddress
	la $t8, white 
	la $t3, winnn
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 52
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 56
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 56
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 60
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 20
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 16
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	jr $ra
	
ADHT:		
	lw $t0, displayAddress
	la $t8, lcolor  
	la $t3, heart
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)	
	addi $t2, $t2, 8
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 120
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 124
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	jr $ra
	
DDFG:	lw $t0, displayAddress
	la $t8, pink 
	la $t3, frogAddress
	lw $t2, 0($t3)
	lw $t5, 0($t8) #color
	add $t1, $t2, $t0
	sw $t5, 0($t1)		
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 120
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 124
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 4
	add $t1, $t2, $t0
	sw $t5, 0($t1)
	addi $t2, $t2, 120
	add $t1, $t2, $t0
	sw $t5, 0($t1) 
	addi $t2, $t2, 12
	add $t1, $t2, $t0
	sw $t5, 0($t1) 
	jr $ra 
	
	
	
	
	
	
	
	
