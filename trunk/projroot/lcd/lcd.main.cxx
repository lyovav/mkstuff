#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>

LiquidCrystal_I2C mScreen(0x20, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);

int main(void)
{
	init();

	mScreen.begin(16, 2);
	mScreen.backlight();
	mScreen.home();
	mScreen.clear();

	mScreen.setCursor(0, 0);
	mScreen.print("Trololo..lo.lo..");
	mScreen.setCursor(0, 1);
	mScreen.print(" v1.0  MNi 2014 ");

	for (;;)
	{
		sleep10ms();
	}

	return 0;
}
