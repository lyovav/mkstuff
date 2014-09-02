#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal.h>
#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>
#include <afx/dwrite.h>

extern void sleep_test(void);
extern void sleep_test_init(void);

int main(void)
{
	init();

	//LiquidCrystal_I2C lcd(0x27, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);
	//LiquidCrystal_I2C lcd(0x20, 4, 5, 6, 0, 1, 2, 3, 7, NEGATIVE);
	LiquidCrystal_I2C lcd(0x20, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);

	lcd.begin(16, 2);
	lcd.backlight();
	lcd.home();
	lcd.clear();
	lcd.setCursor(0, 0);
	lcd.print("1234567890123456");
	lcd.setCursor(0, 1);
	lcd.print("Line #2 ....");

	sleep_test_init();

	for (;;)
	{
		sleep_test();
	}

	return 0;
}
