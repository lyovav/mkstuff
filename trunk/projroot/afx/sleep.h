#ifndef _AFX_SLEEP_H__
#define _AFX_SLEEP_H__

/***
 * sleep stuff UNIT TEST:
 *
 *
		#include <afx/sleep.h>
		#include <afx/dwrite.h>

		// Testing diode on PD0 (1 pin of mcu)

		#define _blink(t1, t2) 	\
			do { 				\
				_dset(D, 0); 	\
				sleep##t1(); 	\
				_dclr(D, 0); 	\
				sleep##t2(); 	\
			} while (0)


		static void _sleep_test(void)
		{
			_dwritable(D, 0);

			while (1)
			{
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
				sleep1s();
			}
		}

 *
 */

#ifndef __ASSEMBLER__

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

void sleep5s(void);
void sleep4s(void);
void sleep3s(void);
void sleep2s(void);
void sleep1s(void);
void sleep1000ms(void);
void sleep500ms(void);
void sleep400ms(void);
void sleep300ms(void);
void sleep200ms(void);
void sleep100ms(void);
void sleep50ms(void);
void sleep40ms(void);
void sleep30ms(void);
void sleep20ms(void);
void sleep10ms(void);
void sleep5ms(void);
void sleep4ms(void);
void sleep3ms(void);
void sleep2ms(void);
void sleep1ms(void);
void sleep500us(void);
void sleep400us(void);
void sleep300us(void);
void sleep200us(void);
void sleep100us(void);
void sleep50us(void);
void sleep40us(void);
void sleep30us(void);
void sleep20us(void);
void sleep10us(void);
void sleep5us(void);
void sleep4us(void);
void sleep3us(void);
void sleep2us(void);
void sleep1us(void);
void sleep500ns(void);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#else /* __ASSEMBLER__ */
	.global sleep5s
	.global sleep4s
	.global sleep3s
	.global sleep2s
	.global sleep1s
	.global sleep1000ms
	.global sleep500ms
	.global sleep400ms
	.global sleep300ms
	.global sleep200ms
	.global sleep100ms
	.global sleep50ms
	.global sleep40ms
	.global sleep30ms
	.global sleep20ms
	.global sleep10ms
	.global sleep5ms
	.global sleep4ms
	.global sleep3ms
	.global sleep2ms
	.global sleep1ms
	.global sleep500us
	.global sleep400us
	.global sleep300us
	.global sleep200us
	.global sleep100us
	.global sleep50us
	.global sleep40us
	.global sleep30us
	.global sleep20us
	.global sleep10us
	.global sleep5us
	.global sleep4us
	.global sleep3us
	.global sleep2us
	.global sleep1us
	.global sleep500ns
#endif /* __ASSEMBLER__ */

#endif /* _AFX_SLEEP_H__ */
