#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>

I2C::LCD mScreen(2, 16, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);

extern "C" void Main()
{
	mScreen.begin();
	mScreen.display();

	mScreen.setCursor(0, 0);
	mScreen.print("Trololo..lo.lo..");
	mScreen.setCursor(0, 1);
	mScreen.print(" v1.0  MNi 2014 ");

	DDRD  = 0xff;
	PORTD = 0;

	for (;;)
	{
		uint8_t p = 0;
		for (int i=0; i<4; i++)
		{
			p |= 1;
			PORTD = p;
			p <<= 1;
			sleep500ms();
		}

		//PORTD = 0xff;
		//sleepms(20000);

		for (int i=0; i<4; i++)
		{
			p >>= 1;
			PORTD = p;
			sleep500ms();
		}
	}
}
