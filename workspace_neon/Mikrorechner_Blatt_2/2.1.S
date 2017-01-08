.text                       /* Specify that code goes in text segment */
.code 32                    /* Select ARM instruction set */

.global _startup            /* Specify global symbol */

_startup:
/*
/////////////////////////KONZEPT////////////////////////////////////////////////////
addiere LOW_A und LOW_B:
 > 2^32 -> carry setzen und LOW_C = LOW_C = LOW_A + LOW_B
 < 2^32 -> LOW_C = LOW_A + LOW_B und carry = 0

 carry nicht gesetzt -> HIGH_C = 0
 carry gesetzt -> HIGH_C = 1

 addiere HIGH_A und HIGH_C:
 > 2^32 -> carry2 setzen und HIGH_C = carry + HIGH_A
 < 2^32 -> HIGH_C = HIGH_C + HIGH_A und carry2 = 0

 addiere HIGH_B und HIGH_C:
 > 2^32 -> carry2 setzen und HIGH_C = HIGH_C + HIGH_B
 < 2^32 -> HIGH_C = HIGH_C + HIGH_B
 -> carry2 ist der Übertrag
////////////////////////////////////////////////////////////////////////////////////

*/
low_a .req r0
low_b .req r2
low_c .req r5
high_a .req r1
high_b .req r3
high_c .req r6
carry2 .req r7

mov carry2, #0
mov low_c, #0
mov high_c, #0

mov low_a, #0xFFFFFFFF
mov high_a, #0xFFFFFFFF
mov low_b, #10
mov high_b, #10


prog:
	adds low_c, low_a, low_b					// wohin?/woher1?/woher2?
	movcs high_c, #1

	adds high_c, high_c, high_a
	movcs carry2, #1

	adds high_c, high_c, high_b
	addcs carry2, carry2, #1

stop:
	bal stop

.end
