#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>
#include <Arduino.h>

I2C::LCD lcd(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);

extern "C" void Main()
{
	lcd.begin();

	lcd.setCursor(0, 0);
	lcd.print(" [WCD] CPU info ");
	lcd.setCursor(0, 1);
	lcd.print(" M.Nikonov 2014 ");

	//sleep3s();
}
