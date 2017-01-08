.text                       /* Specify that code goes in text segment */
.code 32                    /* Select ARM instruction set */

.global _startup            /* Specify global symbol */

_startup:
/*
mov r0,  #0
mov r1,  #0
mov r2,  #0
mov r3,  #0
mov r4,  #0
mov r5,  #0
mov r6,  #0
mov r7,  #0
mov r8,  #0
mov r9,  #0
mov r10, #0
*/
.equ next_word, 4
.equ A_low, 0					/* Offset für A_low */
.equ A_high, 4					/* Offset für A_low */
.equ B_low, 8					/* Offset für A_low */
.equ B_high, 12					/* Offset für A_low */
.equ save_low, 0x40000100
.equ save_high, 0x40000110
.equ save_result, 0x40000120
	temp_A .req r5
	temp_B .req r6
	temp_C .req r7
	pointer .req r0
	merker .req r1
	ldr pointer, =datastart
	full .req r10
	mvn full, #0
prog:
	ldr temp_A, [pointer, #A_low]
	ldr temp_B, [pointer, #B_low]
	adds temp_C, temp_A, temp_B					// wohin?/woher1?/woher2?
	movcs merker, #1
	movcc merker, #0
	ldr pointer, =save_low
	str merker, [pointer]
	str temp_C, [pointer, #next_word]
	ldr pointer, =datastart

	ldr temp_A, [pointer, #A_high]
	ldr temp_B, [pointer, #B_high]
	adds temp_C, temp_A, temp_B					// wohin?/woher1?/woher2?
	movcs merker, #1
	movcc merker, #0
	ldr pointer, =save_high
	str merker, [pointer]
	str temp_C, [pointer, #next_word]
	ldr pointer, =datastart



stop:
	bal stop

.data
.global data
datastart:
.word 0xFFFFFFFF 	//A LOW
.word 0xFFFFFFFF 	//A HIGH
.word 10			//B LOW
.word 10			//B HIGH
.end
