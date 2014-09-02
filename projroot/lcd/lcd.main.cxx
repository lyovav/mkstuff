#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>
#include <afx/dwrite.h>

int main(void)
{
	init();

	_dwritable(D, 7);
	_dset(D, 7);

	LiquidCrystal_I2C lcd(0x20, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);

	lcd.begin(16, 2);
	lcd.backlight();
	lcd.home();
	lcd.clear();
			 //0123456789012345
	lcd.setCursor(0, 0);
	lcd.print(" (C) JncDev v1.0");
	lcd.setCursor(0, 1);
	lcd.print("TransistorTester");
	//
	//lcd.print("Line #2 ....");

	for (;;)
	{
		sleep1s();
	}

	return 0;
}
