.text                       /* Specify that code goes in text segment */
.code 32                    /* Select ARM instruction set */

.global _startup            /* Specify global symbol */

_startup:
.equ marker, 4
.equ next_word, 4
.equ durchlaeufe, 5

	pointer .req r8
	counter .req r9
	ergebnis_low .req r0
	ergebnis_high .req r1
	temp .req r5

	ldr pointer, =datastart
	ldr counter, =durchlaeufe
	mov ergebnis_low, #0
	mov ergebnis_high, #0
	mov temp, #0

multiplikation:
	cmp counter, #0							// fertig?
	beq stop								// Ja: Stop; Nein: Weiter
	ldr temp, [pointer]						// Lade Zahl im Speicherbereich, auf den "Pointer" zeigt in "temp"
	adds ergebnis_low, ergebnis_low, temp	// füge den Wert aus temp dem Ergebnis hinzu
	addcs ergebnis_high, ergebnis_high, #1	// Überlauf? Ja: Ergebnis>32bit => ergebnis_high +1; Nein: weiter
	subs counter, counter, #1				// merken: eins erledigt
	add pointer, pointer, #next_word		// pointer auf nächstes "word" bewegen
	bal multiplikation						// und noch eine Runde

stop:
	bal stop

.data
.global data
datastart:
.word 0xFFFFFFFF// Wort 1
.word 2 		// Wort 2
.word 3			// Wort 3
.word 4			// Wort 4
.word 5			// Wort 5
.end
