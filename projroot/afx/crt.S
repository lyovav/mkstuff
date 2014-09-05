#ifndef __ASSEMBLER__
#define __ASSEMBLER__
#endif

.section .text

.global __cxa_pure_virtual
.global main
.extern Main

main:
                    sei
                    call        Main
                    ret

__cxa_pure_virtual: rjmp        __cxa_pure_virtual
