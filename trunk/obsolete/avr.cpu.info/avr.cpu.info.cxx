#include <LiquidCrystal_I2C.h>
#include <Arduino.h>
#include <stdio.h>
#include <stdarg.h>

extern "C" void Main()
{
	I2C::LCD lcd(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);

	init();
	UCSR0B = 0;		// disable UART
	sei();

	lcd.begin();

	prints(lcd, 0, " [WCD] CPU info ");
	prints(lcd, 1, " M.Nikonov 2014 ");
	delay(500);
	printl(lcd, 0, "F_CPU  %9lu", F_CPU);
	printl(lcd, 1, "                ");

}
