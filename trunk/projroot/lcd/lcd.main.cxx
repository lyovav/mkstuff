#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal.h>
#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>
#include <afx/dwrite.h>

int main(void)
{
	init();

	LiquidCrystal_I2C lcd(0x27);

	lcd.begin(16, 2);
	lcd.home();
	lcd.setBacklight(255);
	lcd.print(1024);

	for (;;)
	{
		::sleep200ms();
	}

	return 0;
}
