//
// 25.08.2014 MNi: Michael Nikonov's version of original main.c
//
#define MAIN_C

#include "Transistortester.h"
#include <avr/io.h>
#include <stdint.h>

#ifndef INHIBIT_SLEEP_MODE
EMPTY_INTERRUPT(TIMER2_COMPA_vect);
EMPTY_INTERRUPT(ADC_vect);
#endif

#ifdef __AVR_ATmega8__
#  define WDRF_HOME MCUCSR
#else
#  define WDRF_HOME MCUSR
#endif

static uint8_t get_wd_status(void)
{
	uint8_t rv = (WDRF_HOME & (1 << WDRF));					/* save Watch Dog Flag */
	WDRF_HOME &= ~(1 << WDRF);	 							/* reset Watch Dog flag */
	wdt_disable();											/* disable Watch Dog */
	return rv;
}

static int initialize(void)
{
	uint8_t wd = 0;

#ifndef PULLUP_DISABLE
	RST_PORT = (1 << RST_PIN);								/* enable internal pullup for Start-Pin */
#endif

#if (OP_MHZ == 8)
	ADCSRA = (1 << ADEN) | AUTO_CLOCK_DIV;					/* prescaler=8 or 64 (if 8Mhz clock) */
#elif !defined(OP_MHZ)
#  error "OP_MHZ must be defined!"
#endif /* OP_MHZ */

	lcd_init();

	wd = get_wd_status();
	if (0 != wd)
	{
		// TODO: report wd status
	}

	return 0;
}

int main(void)
{
	int rv = 0;

	rv = initialize();
	if (rv)
	{
		// TODO: report error
		return rv;
	}

	return 0;
}

#ifdef AUTO_CAL
#  include "mark_as_uncalibrated.c"
#endif

#if FLASHEND > 0x1fff
#  include "GetIr.c"
#endif
