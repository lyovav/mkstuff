#include "ru.alphas.hxx"
#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>

I2C::LCD lcd(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);

extern "C" void Main()
{
	lcd.begin();

	lcd.setCursor(0, 0);
	lcd.print("CharGen Example ");
	lcd.setCursor(0, 1);
	lcd.print("   MNi 2014     ");

	sleep3s();

	init_cp1251(lcd);

	for (;;)
	{
		for (int i = 1; i >= 0; i--)
		{
			lcd.clear();

			lcd.setCursor(0, 0);
			lcd.print(cp1251_to_lcd(lstring[i * 2]));

			lcd.setCursor(0, 1);
			lcd.print(cp1251_to_lcd(lstring[i * 2 + 1]));

			return ;
			sleep3s();
		}
	}
}
