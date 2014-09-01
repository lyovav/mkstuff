/*
 *
 * [WCD] version of SLEEP routine
 * MNi, Aug 31 2014
 * Refactored from `wait1000ms.S` (transistortester project)
 *
 *
 */

#ifndef __ASSEMBLER__
#define __ASSEMBLER__
#endif /* __ASSEMBLER__ */

#include "sleep.h"

.section .text

sleep5s:			rcall	sleep1s
sleep4s:			rcall 	sleep1s
sleep3s:			rcall 	sleep1s
sleep2s:			rcall 	sleep1s
sleep1s:
sleep1000ms:		rcall 	sleep500ms
sleep500ms:			rcall 	sleep100ms
sleep400ms:			rcall	sleep100ms
sleep300ms:			rcall	sleep100ms
sleep200ms:			rcall	sleep100ms
sleep100ms: 		//wdr
					rcall 	sleep50ms
sleep50ms: 			rcall	sleep10ms
sleep40ms:			rcall 	sleep10ms
sleep30ms:			rcall	sleep10ms
sleep20ms:			rcall	sleep10ms
sleep10ms:			rcall 	sleep5ms
sleep5ms:			rcall	sleep1ms
sleep4ms:			rcall	sleep1ms
sleep3ms:			rcall	sleep1ms
sleep2ms:			rcall 	sleep1ms
sleep1ms: 			rcall 	sleep500us
sleep500us:			rcall 	sleep100us
sleep400us:			rcall	sleep100us
sleep300us:			rcall 	sleep100us
sleep200us:			rcall	sleep100us
sleep100us:			rcall	sleep50us
sleep50us: 			rcall 	sleep10us
sleep40us: 			rcall 	sleep10us
sleep30us: 			rcall 	sleep10us
sleep20us: 			rcall 	sleep10us
sleep10us:
#if F_CPU == 1000000
 					nop
 					nop
 					nop
sleep5us:
sleep4us:
sleep3us:
sleep2us:
sleep1us:
#endif
#if F_CPU == 2000000
					rcall	sleep5us
sleep5us:			nop
 					nop
sleep4us:			nop
sleep3us:
sleep2us:
sleep1us:
#endif
#if F_CPU == 4000000
					rcall	sleep5us
sleep5us:			nop
 					nop
 					nop
 					nop
sleep4us:			rcall	sleep2us
sleep2us:			nop
sleep1us:
#endif
#if F_CPU == 8000000
					rcall 	sleep5us
sleep5us:			rcall 	sleep1us
sleep4us:			rcall	sleep1us
sleep3us:			rcall	sleep1us
sleep2us:			rcall 	sleep1us
sleep1us:			nop
#endif
#if F_CPU == 16000000
					rcall	sleep5us
sleep5us: 			rcall	sleep1us
sleep4us: 			rcall	sleep1us
sleep3us:			rcall	sleep1us
sleep2us: 			rcall	sleep1us
sleep1us: 			rcall	sleep500ns
sleep500ns:			nop
#endif
					ret
