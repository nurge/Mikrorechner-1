.text                       /* Specify that code goes in text segment */
.code 32                    /* Select ARM instruction set */

.global _startup            /* Specify global symbol */

_startup:
	ldr sp, =0x40001000 					/* RAM Start = 0x40000000, Stack = 4kByte Offset */
	status .req r10
	mov status, #0
main:
	mov status, #99
	bl sub1
	mov status, #99
	bl sub2
	mov status, #99
	bl sub3
	mov status, #0

	bal main

sub1:
	stmfd sp!, {lr}
	mov status, #1
	bl subsub1
	ldmfd sp!, {pc}
sub2:
	stmfd sp!, {lr}
	mov status, #2
	ldmfd sp!, {pc}
sub3:
	stmfd sp!, {lr}
	mov status, #3
	ldmfd sp!, {pc}
subsub1:
	stmfd sp!, {lr}
	mov status, #11
	bl sub3
	ldmfd sp!, {pc}
stop:
	bal stop

.data
.global data
datastart:

.end
