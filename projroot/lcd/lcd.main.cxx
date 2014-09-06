#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>

I2C::LCD lcd(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);

extern "C" void Main()
{
	lcd.begin();

	lcd.setCursor(0, 0);
	lcd.print("CharGen Example ");
	lcd.setCursor(0, 1);
	lcd.print(" v1.0  MNi 2014 ");

	sleep2s();
	lcd.clear();

	static const uint8_t smiley[8] = {
	  0b00000,
	  0b00000,
	  0b01010,
	  0b00000,
	  0b00000,
	  0b10001,
	  0b01110,
	  0b00000
	};

	const uint8_t armsUp[8] = {
	  0b00100,
	  0b01010,
	  0b00100,
	  0b10101,
	  0b01110,
	  0b00100,
	  0b00100,
	  0b01010
	};

	uint8_t frownie[8] = {
	  0b00000,
	  0b00000,
	  0b01010,
	  0b00000,
	  0b00000,
	  0b00000,
	  0b01110,
	  0b10001
	};

	lcd.createChar(0, smiley);
	lcd.createChar(1, armsUp);
	lcd.createChar(2, frownie);

	lcd.setCursor(0, 0);
	lcd.print((char)0);

	lcd.setCursor(2, 0);
	lcd.print((char)1);

	lcd.setCursor(4, 0);
	lcd.print((char)2);
}
