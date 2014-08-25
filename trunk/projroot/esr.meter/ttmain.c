//
// 25.08.2014 MNi: Michael Nikonov's version of original main.c
//
#define MAIN_C

#include "Transistortester.h"
#include <avr/io.h>

#ifndef INHIBIT_SLEEP_MODE
EMPTY_INTERRUPT(TIMER2_COMPA_vect);
EMPTY_INTERRUPT(ADC_vect);
#endif

#ifdef WITH_SELFTEST
#include "AutoCheck.c"
#endif
#ifdef AUTO_CAL
#include "mark_as_uncalibrated.c"
#endif
#if FLASHEND > 0x1fff
#include "GetIr.c"
#endif

int main(void)
{
	return 0;
}
