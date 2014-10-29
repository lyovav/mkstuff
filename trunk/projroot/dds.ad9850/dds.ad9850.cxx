#include <stdio.h>
#include <LiquidCrystal_I2C.h>
#include <Arduino.h>
#include <afx/sleep.h>
#include "AD9850.hxx"

enum miscConsts
{
	btnSelectModePin = 2,
	rotaryValuePin = A0,
};

enum ddsModes
{
	ddsModeSilence = -1,
	ddsModeSine = 0,
	ddsModeSaw,
	ddsModeTria,
	ddsModeSquare,
	ddsModeMax
};

static I2C::LCD lcd(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);
static int ddsMode = ddsModeSilence;
static dds::AD9850 ad9850(8, 9, 10, 11);

static void incMode()
{
	++ddsMode;
	if (ddsMode > (ddsModeMax - 1))
		ddsMode = 0;
}

static bool isButtonPressed(int pin)
{
	static int prev = -1;
	int val = digitalRead(pin);

	if (prev != val)
	{
		prev = val;
		return HIGH == val;
	}

	return false;
}

static void showX(int row, int_fast32_t x, char const* postfix)
{
	byte millions = int(x/1000000);
	byte hundredthousands = ((x/100000)%10);
	byte tenthousands = ((x/10000)%10);
	byte thousands = ((x/1000)%10);
	byte hundreds = ((x/100)%10);
	byte tens = ((x/10)%10);
	byte ones = ((x/1)%10);

	lcd.setCursor(0, row);
    lcd.print("                ");

	if (millions > 9)
		lcd.setCursor(1, row);
	else
		lcd.setCursor(2, row);

	lcd.print(millions);
	lcd.print(".");
	lcd.print(hundredthousands);
	lcd.print(tenthousands);
	lcd.print(thousands);
	lcd.print(".");
	lcd.print(hundreds);
	lcd.print(tens);
	lcd.print(ones);
	lcd.print(postfix);
}

static void updateFreq(int res, int_fast32_t& theFreq, int_fast32_t divisor)
{
	double k = res / 1023.;
	double tempFreq = (39999999. / (double)divisor) * k;
	theFreq = (int_fast32_t)tempFreq;

	ad9850.setfreq(theFreq);
}

extern "C" void Main()
{
	init();

	pinMode(btnSelectModePin, INPUT);
	pinMode(rotaryValuePin, INPUT);

	lcd.begin();

	/*         0123456789012345 */
	lcd.setCursor(0, 0);
	lcd.print(" [WCD] mini-DDS ");
	lcd.setCursor(0, 1);
	lcd.print("     v1.0       ");

	sleep1000ms();

	int_fast32_t theFreq = 0;
	int_fast32_t divisor = 1;
	int divi = 0;

	int pres = -1;
	while (1)
	{
		bool outValues = false;
		int res = analogRead(rotaryValuePin);

		if (isButtonPressed(btnSelectModePin))
		{
			static const int_fast32_t divs[] = { 1, 10, 100, 1000, 10000, 100000, 1000000 };

			++divi;
			if (divi > (int)((sizeof(divs) / sizeof(divs[0])) - 1))
				divi = 0;

			divisor = divs[divi];
			updateFreq(res, theFreq, divisor);

			outValues = true;
		}

		if (pres != res)
		{
			pres = res;
			outValues = true;

			updateFreq(res, theFreq, divisor);
		}

		if (outValues)
		{
			showX(0, theFreq, " Mhz  ");
			showX(1, divisor, " Div  ");

			//sleep400ms();
		}
	}
}
