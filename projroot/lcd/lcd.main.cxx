#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>

I2C::LCD lcd(2, 16, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);

extern "C" void Main()
{
	lcd.begin();

	lcd.setCursor(0, 0);
	lcd.print("Trololo..lo.lo..");
	lcd.setCursor(0, 1);
	lcd.print(" v1.0  MNi 2014 ");

	DDRD  = 0xff;
	PORTD = 0;
	uint8_t p = 1;
	for (;;)
	{
		PORTD = p;

		p <<= 1;
		if (p >= 0b10000000)
		{
			PORTD = 0;
			p = 1;
		}

		sleep300ms();
	}
}
