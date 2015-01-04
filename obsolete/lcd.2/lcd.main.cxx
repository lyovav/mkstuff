#include <Arduino.h>
#include <LiquidCrystal.h>

LiquidCrystal lcd(13, 12, 8, 9, 10, 11);

extern "C" void Main()
{
    init();

	lcd.begin(16, 2);

	lcd.setCursor(0, 0);
	lcd.print("  1602 Library  ");
	lcd.setCursor(0, 1);
	lcd.print("    WCD 2015    ");

	while (1)
	    ;
}
