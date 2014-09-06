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
	lcd.printf(" %d  MNi 2014", 100);

	sleep3s();
	lcd.clear();

	init_ru_cp(lcd);

	//lcd.setCursor(0, 0);
	//lcd.print(lstring[RU_Alpha1]);

	//lcd.setCursor(0, 1);
	//lcd.print(lstring[RU_Alpha2]);
}
