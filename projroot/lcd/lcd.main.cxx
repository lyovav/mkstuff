#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>
#include <afx/dwrite.h>

int main(void)
{
	init();

	LiquidCrystal_I2C lcd(0x20, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);

	lcd.begin(16, 2);
	lcd.backlight();
	lcd.home();
	lcd.clear();

	lcd.setCursor(0, 0);
	lcd.print("TransistorTester");
	lcd.setCursor(0, 1);
	lcd.print(" v1.0  MNi 2014 ");
	sleep1s();

	lcd.clear();

	for (;;)
	{
		sleep500ms();
	}

	return 0;
}
