#include <LiquidCrystal_I2C.h>
#include <Arduino.h>
#include <afx/sleep.h>
#include <afx/dwrite.h>
#include <stdint.h>
#include <avr/interrupt.h>
#include <avr/io.h>
#include <avr/pgmspace.h>

extern "C" void Main()
{
	uint8_t y = 0xff;
	DDRD = y;
	while (1)
	{
		PORTD = y; // & 0x7f;
		//sleepms(50);
		++y;
	}
}

#if 0

I2C::LCD lcd(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);


extern "C" void Main()
{
	init();

	lcd.begin();

	lcd.setCursor(0, 0);
	lcd.print("    TINY DDS    ");
	lcd.setCursor(0, 1);
	lcd.print("  MNi  09.2014  ");

	analogWrite(A0, 0);

	//sleep2s();
	//lcd.clear();

	setup();

	while (1)
	{
		if (c4ms > 250)
		{                 // timer / wait fou a full second
			c4ms = 0;
			dfreq = 1000; // analogRead(0);             // read Poti on analog pin 0 to adjust output frequency from 0..1023 Hz

			cbi(TIMSK2, TOIE2);              // disble Timer2 Interrupt
			tword_m = pow(2, 32) * dfreq / refclk; // calulate DDS new tuning word
			sbi(TIMSK2, TOIE2);              // enable Timer2 Interrupt

			//Serial.print(dfreq);
			//Serial.print("  ");
			//Serial.println(tword_m);
		}

		sbi(PORTD, 6); // Test / set PORTD,7 high to observe timing with a scope
		cbi(PORTD, 6); // Test /reset PORTD,7 high to observe timing with a scope
	}
}

#endif
