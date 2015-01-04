#ifndef __ASSEMBLER__
#define __ASSEMBLER__
#endif

#include <avr/io.h>

.section .text
.global main
main:

infloop:    rjmp    infloop
