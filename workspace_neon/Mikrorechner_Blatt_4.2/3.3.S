.text                       /* Specify that code goes in text segment */
.code 32                    /* Select ARM instruction set */

.global _startup            /* Specify global symbol */

_startup:

/////////////////////////KONZEPT////////////////////////////////////////////////////
//		DIVISION von GANZEN, POSITIVEN Zahlen<2^32
////////////////////////////////////////////////////////////////////////////////////

dividend .req r0
divisor .req r1
quotient .req r2
rest .req r3
error .req r4
temp .req r5
temp2 .req r6

mov temp, #0
mov error, #0
mov rest, #0
mvn temp2, #0



main:
	mov dividend, #2
	mov divisor,  #1
	mov quotient, #-1
	sub temp2, temp2, divisor
	bal check
	bal main

div:

	subs dividend, dividend, divisor	// teilen
	cmp dividend, #0					// noch teilbar?
	addhi quotient, quotient, #1		// ja=> +1
	cmp temp2, dividend
	bhi div								// und nochmal
										// nein=> weiter
	add rest, dividend, divisor			//
	mov dividend, temp					// kosmetisch

	ldmfd sp!, {pc}
	mov error, #66
	bal stop

check:
	mov temp, dividend
	// check if div by 0
	cmp divisor, #0
	moveq error, #99
	beq stop

	//chek if quot>1 or dividend =0
	cmp divisor, dividend
	movhi error, #33					//...if higher
	bhi stop
	stmfd sp!, {lr}
	bal div
	bal main

stop:
	bal stop

.end
