/*
 *
 * [WCD] version of SLEEP routine 16Mhz version
 * MNi, Sep 3 2014
 * Refactored from `wait1000ms.S` (transistortester project)
 *
 *
 */

#ifndef __ASSEMBLER__
#define __ASSEMBLER__
#endif

.section .text

#include "sleep.h"

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
sleep100ms: 		wdr
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
sleep10us:			rcall	sleep5us
sleep5us: 			rcall	sleep1us
sleep4us: 			rcall	sleep1us
sleep3us:			rcall	sleep1us
sleep2us: 			rcall	sleep1us
sleep1us: 			rcall	sleep500ns
sleep500ns:			nop
					ret
