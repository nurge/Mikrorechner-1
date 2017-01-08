.text            //Ab hier Maschinenbefehle
.code 32         // ARM Befehlssatz
/* ///////////////////////////////////////////////
2 64bit Zahlen im Speicher
2 32bit Zeiger
Parameter sind die Positionen der beiden Zahlen
 ZeigerA -> ZahlA
 ZeigerB -> ZahlB
=> ZahlA=ZahlA+ZahlB
	=> Inkrement?
		=>ZahlA an ZeigerA speichern
=>danach Zeiger A und B um 32bit=4byte inkrementieren
=> ZahlA=ZahlA+ZahlB
	=> Inkrement?
		=>ZahlA an ZeigerA speichern
*/ ///////////////////////////////////////////////
.global _startup

_startup:
//initialisieren
 ldr sp, =0x40001000
 zeigerA .req r0
 zeigerB .req r1
 carry .req r4
 zahlA .req r5
 zahlB .req r6

 mov carry, #0

 //Parameter übergeben
 ldr zeigerA, =speicherA
 ldr zeigerB, =speicherB
 // Programmaufruf
 b add64

add64:
 stmfd sp!, {r5-r7, lr}	//push
 ldr zahlA, [zeigerA]
 ldr zahlB, [zeigerB]
 adds zahlA, zahlA, zahlB
 //movcs carry, #1
 str zahlA, [zeigerA]

 ldr zahlA, [zeigerA,#4]
 ldr zahlB, [zeigerB,#4]
 adcs zahlA, zahlA, zahlB

 bcs error
// mov carry,#0

// adds zahlA, zahlA, zahlB

// bcs error
// movcc carry,#0
 str zahlA, [zeigerB]

 ldmfd sp!, {r5-r7, pc}	//pull



.data
.global datastart


error:
stop:
	b stop

.data
.global data
speicherA:
.word 0xFFFFFFFF			// Wort A1
.word 0xFFFFFFFF	 		// Wort A2
speicherB:
.word 0xFFFFFFFF			// Wort B1
.word 0xFFFFFFFF			// Wort B2
.end
