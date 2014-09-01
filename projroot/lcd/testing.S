#ifndef __ASSEMBLER__
#define __ASSEMBLER__
#endif /* __ASSEMBLER__ */

#include <avr/io.h>

#if 0

.section .text

.global main

.extern sleep5s
.extern sleep1s

main: /*--------------- int main(void) ---------------*/
						cli

						ldi		r17, 0b00000011
						out		DDRD, r17
loop:
						ldi		r16, 0b00000001
						out		PORTD, r16
						call	sleep1s

						ldi		r16, 0b00000000
						out		PORTD, r16
						call	sleep1s

						jmp		loop

						ret

#endif // 0

