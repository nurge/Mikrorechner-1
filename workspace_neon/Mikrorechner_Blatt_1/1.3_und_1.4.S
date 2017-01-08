.text                       /* Specify that code goes in text segment */
.code 32                    /* Select ARM instruction set */

.global _startup            /* Specify global symbol */

_startup:

mystart:
	mov	r0, #0
	mov	r1, #1
myloop:
	adds r0, r0, r1		// wohin?/woher1?/woher2?
	bcc myloop 			// max Wert sollte 2^32-1 sein
//	mov	r0, #123
stop:
	b stop

.end
