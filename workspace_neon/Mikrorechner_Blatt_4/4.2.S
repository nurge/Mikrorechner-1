.text            //Ab hier Maschinenbefehle
.code 32         // ARM Befehlssatz
//.ARM           // geht genauso

.global _startup   // Global in ganzen projekt bekanntes label

_startup:
mystartup:


ldr sp, =0x40001000 		// RAM Start = 0x40000000, Stack = 4kByte Offset



	ldr r4, =8				// Count Variable
	ldr r5, =0x0f			// Mask
	ldr r6, =0				// BCD_cy Carry
	ldr r7, =0				// Result
	ldr r0, =0x025			// numA
	ldr r1, =0x024			// numB
	ldr r8, =0				// tem1=r8
	ldr r9, =0 				// tem2=r9


	bl while				//Jump1

	b ende
//

while:						// while r4 > 0
	stmfd sp!, {r4-r9,lr}

	AND r8, r5, r0			// tem1= numA AND MASK
	AND r9, r5, r1			// tem2= numB AND MASK

	add r8, r8, r9			// tem1= tem1 + tem2
	add r8, r8 ,r6			// tem1= tem1 + BCD_cy

	subs r8, r8, #10		// tem1= tem1-10
	bcc iffalse				// r8 negativ flag gesetzt jump to iffalse
	b iftrue				//


		iftrue:
		mov r6, #1		  // BCD_cy #1 setzen
		b endif

		iffalse:
		add r8, r8, #10  // tem1= tem1+10
		mov r6, #0		// 	BCD_cy= #0
		b endif

	endif:
	add r7, r7, r8		// Result = result + tem1
	mov r0, r0, ror #4	// Rotiere numA um 4Bit
	mov r1, r1, ror #4	// Rotiere numB um 4Bit
	mov r7, r7, ror #4  // Rotiere Result um 4Bit

	subs r4, r4, #1		// Count -1
	bne while
	//return / ergebnis=value/BCD_cy=carry


	ldmfd sp!, {r4-r9,pc}

ende:
	nop

.end

