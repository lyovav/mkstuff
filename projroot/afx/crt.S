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

#ifdef _WITHOUT_ARDUINO_CRT_
__cxa_pure_virtual: rjmp        __cxa_pure_virtual
#endif // _WITHOUT_ARDUINO_CRT_
