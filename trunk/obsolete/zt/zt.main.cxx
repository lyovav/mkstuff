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

// fsdgdsgdfsgsdfgdfg
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

	struct ModeDesc
	{
		char const* name;
		char const* chars;
	};

	static const ModeDesc _modes_info[] =
	{
	/* M_Classic */		{ "debug      ", "-**-" },
	/* M_Resistance */	{ "resistance ", "-[]-" },
	/* M_Capacitance */	{ "capacitance", "-||-" },
	/* M_Diodes */		{ "diodez     ", "->|-" },
	/* M_Tranzistors */	{ "tranzistors", "-()-" },
	/* M_Induction */	{ "induction  ", "-^^-" },
	};

	char const* mode_chars(int8_t mode)
	{
		if (mode < M_Count)
			return _modes_info[mode].chars;

		return "-?-";
	}

	char const* mode_name(int8_t mode)
	{
		if (mode < M_Count)
			return _modes_info[mode].name;

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

void start(uint8_t mode);
void stop(uint8_t mode);
bool is_testbtn_pressed();

extern "C" void Main()
{
	mScreen.begin();
	mScreen.home();
	mScreen.clear();

	mScreen.setCursor(0, 0);
	mScreen.print("TransistorTester");
	mScreen.setCursor(0, 1);
	mScreen.print(" v1.1  MNi 2014 ");

	DDRC = 0b00000000; 							// read mode for port C, PC0-PC6
	DDRD &= ~(1 << 7);							// button pin on read mode
	PORTD = (1 << PD7); 						// enable internal pullup for reset pin

	sei();

	sleep1s();
	mScreen.clear();

	// init ADC
	_SFR_BYTE(ADCSRA) |= _BV(ADPS2);
	_SFR_BYTE(ADCSRA) |= _BV(ADPS1);
	_SFR_BYTE(ADCSRA) |= _BV(ADPS0);
	_SFR_BYTE(ADCSRA) |= _BV(ADEN);

	for (;;)
	{
		int pos = read_adc(3);
		int mode = pos / (_ADC_MAX_VALUE / M_Count);

		if (mode > M_Last)
			mode = M_Last;

		mScreen.setCursor(0, 0);
		mScreen.print(mode_name(mode));
		mScreen.print(" ");
		mScreen.print(mode_chars(mode));
		mScreen.setCursor(0, 1);
		mScreen.print("press  test  btn");

		if (is_testbtn_pressed())
			start(mode);

		sleep300ms();
	}
}

bool is_testbtn_pressed()
{
	bool bpress = (0 == (PIND & (1 << 7)));
	if (bpress)
	{
		while (0 == (PIND & (1 << 7)))
			sleep1ms();

		return true;
	}

	return false;
}

void stop(uint8_t mode)
{
	while (!is_testbtn_pressed())
		sleep1ms();
}

void start(uint8_t mode)
{
	mScreen.clear();

	stop(mode);
}
