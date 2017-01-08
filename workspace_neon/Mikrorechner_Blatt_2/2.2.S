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
/////////////////////////KONZEPT////////////////////////////////////////////////////
faktor_a * faktor_b <=> SUMME über faktor_a von 1 bis faktor_b

////////////////////////////////////////////////////////////////////////////////////

*/
faktor_a .req r0
faktor_b .req r1
ergebnis_low .req r3
ergebnis_high .req r4

mov ergebnis_low, #0
mov ergebnis_high, #0
mov faktor_a, #0xFFFFFFFF
mov faktor_b, #0xFFFFFFFF
prog:
	cmp faktor_b, #0							// fertig?
	beq stop									// wenn fertig -> stop
	adds ergebnis_low, ergebnis_low, faktor_a	// "multiplikation" durch addition
	addcs ergebnis_high, ergebnis_high, #1		// Überlauf? wenn ja: ins most significant word +1
	sub faktor_b, faktor_b, #1					// Eine Runde geschafft
	bal prog									// auf jeden Fall noch eine Runde (mit oder ohne Operation)
stop:
	bal stop

.end
