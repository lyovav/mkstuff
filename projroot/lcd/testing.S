#ifndef __ASSEMBLER__
#define __ASSEMBLER__
#endif /* __ASSEMBLER__ */

#include <avr/io.h>

.global main

.extern sleep500ms
.extern sleep1s

.section .text

main: /*--------------- int main(void) ---------------*/
						ret
