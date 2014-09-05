#include "sleep.h"

extern "C" void sleepms(unsigned int us)
{
#if F_CPU >= 20000000L
	__asm__ __volatile__
	(
		"nop" "\n\t"
		"nop"
	);

	if (--us == 0)
		return;

	us = (us<<2) + us;
	us -= 2;

#elif F_CPU >= 16000000L
	if (--us == 0)
		return;

	us <<= 2;
	us -= 2;
#else
	if (--us == 0)
		return;

	if (--us == 0)
		return;

	us <<= 1;

	us--;
#endif

	__asm__ __volatile__
	(
		"1: sbiw %0,1" "\n\t" 				// 2 cycles
		"   brne 1b" : "=w" (us) : "0" (us) // 2 cycles
	);
}
