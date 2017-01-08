.text                       /* Specify that code goes in text segment */
.code 32                    /* Select ARM instruction set */

.global _startup            /* Specify global symbol */

_startup:

mystart:
	mov	r0, #0 				/* this is just a dummy value to check register r0 */
	mov	r1, #1				/* this is just a dummy value to check register r1 */

stop:

.end
