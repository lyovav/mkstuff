#include <afx/sleep.h>
#include <avr/io.h>

#define LOW 	0
#define HIGH 	1
#define OUTPUT 	1
#define INPUT 	0

#define digitalRead(P)			((PIND & (1 << P)) != 0)

#define digitalWrite(P,ST)      { if(ST == HIGH){ \
            						(PORTD |= (1 << P)); \
            					  } else { \
            						(PORTD &= ~(1 << P)); \
								}}

#define pinMode(P,ST)	        { if(ST == OUTPUT){ \
									(DDRD |= (1 << P)); \
								  } else { \
									(DDRD &= ~(1 << P)); \
								}}


int main(void)
{
	pinMode(0, OUTPUT);

	while (1)
	{
		digitalWrite(0, HIGH);
		sleep1s();
		digitalWrite(0, LOW);
		sleep1s();
	}

	return 0;
}
