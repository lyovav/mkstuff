/*
 *
 * [WCD] TranzistorTester
 * MNi, September 3 2014
 * Firmware entry point
 *
 */

#include <afx/sleep.h>
#include <afx/dwrite.h>
#include <LiquidCrystal_I2C.h>
#include <Arduino.h>
#include <stdio.h>

I2C::LCD mScreen(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);

enum { _ADC_DEF_REF = 1, _ADC_MAX_VALUE = 1023 };

static unsigned read_adc(uint8_t pin)
{
	ADMUX = (_ADC_DEF_REF << 6) | (pin & 0x07);

	_SFR_BYTE(ADCSRA) |= _BV(ADSC);
	while (bit_is_set(ADCSRA, ADSC));

	unsigned lr = ADCL;
	unsigned hr = ADCH;

	return (hr << 8) | lr;
}

namespace // make it C++ static
{
	enum Modes
	{
		M_Classic = 0,
		M_Resistance,
		M_Capacitance,
		M_Diodes,
		M_Tranzistors,
		M_Induction,
		M_Count,
		M_First = M_Resistance,
		M_Last = M_Count - 1
	};

	char const* mode_chars(int8_t mode)
	{
		switch (mode)
		{
		case M_Classic:		return "-\?\?-";
		case M_Resistance:	return "-[]-";
		case M_Capacitance:	return "-||-";
		case M_Diodes:		return "->|-";
		case M_Tranzistors:	return "-()-";
		case M_Induction:	return "-^^-";
		}

		return "-?-";
	}

	char const* mode_name(int8_t mode)
	{
		switch (mode)
		{
		case M_Classic:		return "classic";
		case M_Resistance:	return "resistn";
		case M_Capacitance:	return "capasit";
		case M_Diodes:		return "diodez ";
		case M_Tranzistors:	return "tranzts";
		case M_Induction:	return "indtuct";
		}

		return "unknown";
	}

	void select_mode(int8_t mode)
	{
		switch (mode)
		{
		case M_Resistance: break;
		case M_Capacitance: break;
		case M_Diodes: break;
		case M_Tranzistors: break;
		case M_Induction: break;
		}
	}
}

extern "C" void Main()
{
	mScreen.begin();
	mScreen.home();
	mScreen.clear();

	mScreen.setCursor(0, 0);
	mScreen.print("TransistorTester");
	mScreen.setCursor(0, 1);
	mScreen.print(" v1.1  MNi 2014 ");
	sleep1s();
	mScreen.clear();

	DDRC = 0b00000000; 	// read mode for port C, PC0-PC6
	PORTD = (1 << PD7); // enable internal pullup for reset pin

	// init ADC
	_SFR_BYTE(ADCSRA) |= _BV(ADPS2);
	_SFR_BYTE(ADCSRA) |= _BV(ADPS1);
	_SFR_BYTE(ADCSRA) |= _BV(ADPS0);
	_SFR_BYTE(ADCSRA) |= _BV(ADEN);

	for (;;)
	{
		char line[2][18] = {{0}, {0}};

		//mScreen.clear();

		int pos = read_adc(3);
		int mode = pos / (_ADC_MAX_VALUE / M_Count);

		if (mode > M_Last)
				mode = M_Last;

		snprintf(line[0], 17, "%s %s", mode_name(mode), mode_chars(mode));
		snprintf(line[1], 17, "ready to testing");

		for (uint8_t i=0; i<2; i++)
		{
			mScreen.setCursor(0, i);
			mScreen.print(line[i]);
		}

		sleep300ms();
	}
}
