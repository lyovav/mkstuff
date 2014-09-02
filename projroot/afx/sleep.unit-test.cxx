#include "sleep.h"
#include "dwrite.h"

// Testing diode on PD1 (2 pin of mcu)

#define _blink(t1, t2) 	\
	do { 				\
		_dset(D, 1); 	\
		sleep##t1(); 	\
		_dclr(D, 1); 	\
		sleep##t2(); 	\
	} while (0)


void sleep_test_init(void)
{
	//PRR = (1 << PRUSART0);
	_dwritable(D, 1);
}

void sleep_test(void)
{
	_blink(1s, 1s);
#if 0
	_blink(2s, 2s);
	_blink(1s, 1s);
	_blink(500ms, 500ms);
	_blink(400ms, 400ms);
	_blink(300ms, 300ms);
	_blink(200ms, 200ms);
	_blink(100ms, 100ms);
	_blink(50ms, 50ms);
	_blink(40ms, 40ms);
	_blink(30ms, 30ms);
	_blink(20ms, 20ms);
	_blink(10ms, 10ms);
	_blink(5ms, 5ms);
	_blink(4ms, 4ms);
	_blink(3ms, 3ms);
	_blink(2ms, 2ms);
	_blink(1ms, 1ms);
#endif
}
