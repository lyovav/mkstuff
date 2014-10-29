#include <stdio.h>
#include <LiquidCrystal_I2C.h>
#include <Arduino.h>
#include <afx/sleep.h>

enum miscConsts
{
	btnSelectModePin = 2,
	rotaryValuePin = A0,
	W_CLK = 8,   // Pin 8 - connect to AD9850 module word load clock pin (CLK)
	FQ_UD = 9,   // Pin 9 - connect to freq update pin (FQ)
	DATA = 10,   // Pin 10 - connect to serial data load pin (DATA)
	RESET = 11,  // Pin 11 - connect to reset pin (RST)
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

#define pulseHigh(pin) do { digitalWrite(pin, HIGH); digitalWrite(pin, LOW); } while (0)

int_fast32_t rx=7200000; // Starting frequency of VFO
int_fast32_t rx2=1; // variable to hold the updated frequency
int_fast32_t increment = 10; // starting VFO update increment in HZ.
int buttonstate = 0;
int  hertzPosition = 5;
byte ones, tens, hundreds, thousands, tenthousands, hundredthousands, millions ;  //Placeholders
int_fast32_t timepassed = millis(); // int to hold the arduino miilis since startup
int memstatus = 1;  // value to notify if memory is current or old. 0=old, 1=current.
int ForceFreq = 1;  // Change this to 0 after you upload and run a working sketch to activate the EEPROM memory.  YOU MUST PUT THIS BACK TO 0 AND UPLOAD THE SKETCH AGAIN AFTER STARTING FREQUENCY IS SET!

// transfers a byte, a bit at a time, LSB first to the 9850 via serial DATA line
static void tfr_byte(byte data)
{
	for (int i=0; i<8; i++, data>>=1)
	{
		digitalWrite(DATA, data & 0x01);
		pulseHigh(W_CLK);
		// after each bit sent, CLK is pulsed high
	}
}

// frequency calc from datasheet page 8 = <sys clock> * <frequency tuning word>/2^32
static void sendFrequency(double frequency)
{
  uint32_t freq = frequency * 4294967295lu / 125000000lu;
  // note 125 MHz clock on 9850.  You can make 'slight' tuning variations here by adjusting the clock frequency.

  for (int b=0; b<4; b++, freq>>=8)
	  tfr_byte(freq & 0xFF);

  tfr_byte(0x000);   // Final control byte, all 0 for 9850 chip
  pulseHigh(FQ_UD);  // Done!  Should see output
}

extern "C" void Main()
{
	init();

	pinMode(btnSelectModePin, INPUT);
	pinMode(rotaryValuePin, INPUT);
	pinMode(FQ_UD, OUTPUT);
	pinMode(W_CLK, OUTPUT);
	pinMode(DATA, OUTPUT);
	pinMode(RESET, OUTPUT);

	pulseHigh(RESET);
	pulseHigh(W_CLK);
	pulseHigh(FQ_UD);  // this pulse enables serial mode on the AD9850 - Datasheet page 12.

	lcd.begin();

	/*         0123456789012345 */
	lcd.setCursor(0, 0);
	lcd.print(" [WCD] mini-DDS ");
	lcd.setCursor(0, 1);
	lcd.print("     v1.0       ");

	sleep1000ms();

	sendFrequency(39999999.);

	int pres = -1;
	while (1)
	{
		bool outValues = false;
		int res = analogRead(rotaryValuePin);

		if (pres != res)
		{
			pres = res;
			outValues = true;
		}

		if (isButtonPressed(btnSelectModePin))
		{
			incMode();
			outValues = true;
		}

		if (outValues)
		{
			char line[2][64] = {{0}, {0}};

			snprintf(line[0], 16, "M %d", ddsMode);
			snprintf(line[1], 16, "R %d", res);

			lcd.clear();
			for (int i=0; i<2; i++)
			{
				lcd.setCursor(0, i);
				lcd.print(line[i]);
			}

			sleep200ms();
		}
	}
}
