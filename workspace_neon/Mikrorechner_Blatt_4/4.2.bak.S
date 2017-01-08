.text                       /* Specify that code goes in text segment */
.code 32                    /* Select ARM instruction set */
/////////////////////////////////////////////////////////////////
// Umständlich? warum nicht einfach im Speicher zusammensetzen?//
/////////////////////////////////////////////////////////////////
.global _startup            /* Specify global symbol */
	.equ nibble_mask, 0xf

	//.equ BCD1,  0b0001000100010001 // 1111
	//.equ BCD2,  0b0000000100100011 //+0123
								   //=1234
// kann nur 8 bit breite Zahlen per mov reinladen...
//LSG: Zahlen im speicher ablegen.. siehe vorherige Aufgaben
//->http://stackoverflow.com/questions/10261300/invalid-constant-after-fixup

_startup:
	ldr sp, =0x40001000 					/* RAM Start = 0x40000000, Stack = 4kByte Offset */
	BCD_A .req r0
	BCD_B .req r1
	mask .req r2
	tempA .req r9
	tempB .req r10
	counter .req r3
	ergebnis .req r4
	carry .req r5
main:
	ldr BCD_A, =0x1111
	ldr BCD_B, =0x0123
	ldr mask, =nibble_mask
	bl bcdadd

	bal main


bcdadd:
	//stmfd sp!, {lr}
	mov counter, #4
	and tempA, BCD_A, mask
	and tempB, BCD_B, mask
	mov BCD_A, BCD_A, ror #4
	mov BCD_B, BCD_B, ror #4

	adds ergebnis,tempA,tempB
	cmp ergebnis, #9
	movhi carry,#1

	cmp counter, #0
	bne bcdadd
	//ldmfd sp!, {pc}

stop:
	bal stop

.data
.global data
datastart:
.word 0b0001000100010001// BCD1
.word 0b0000000100100011// BCD2

.end
