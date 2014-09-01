#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal.h>
#include <4arduino/lcd-1.0/LiquidCrystal_I2C.h>
#include <afx/sleep.h>
#include <afx/dwrite.h>

int main(void)
{
	init();

	LiquidCrystal_I2C lcd(0x27, 16, 2);

	lcd.init();
	lcd.clear();
	lcd.setBacklight(255);
	lcd.printstr("Trolololo...");

	for (;;)
	{
		::sleep200ms();
	}

	return 0;
}
