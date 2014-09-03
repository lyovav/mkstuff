#include <LiquidCrystal_I2C.h>
#include <afx/sleep.h>
#include <afx/dwrite.h>

LiquidCrystal_I2C mScreen(0x20, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);

namespace // make it C++ static
{
	enum Modes
	{
		M_First = 0,
		M_Generator = M_First,
		M_Resistance,
		M_Capacitance,
		M_Diodes,
		M_Tranzistors,
		M_Frequency,
		M_Count
	};

	static void rotate_mode_index(int8_t& mode)
	{
		if (mode > M_Count - 1)
			mode = M_First;

		else if (mode < 0)
			mode = M_Count - 1;
	}

	static int8_t init_mode()
	{
		// TODO: read mode from EEPROM
		return M_First;
	}

	static void increment_mode(int8_t& mode)
	{
		++mode;
		rotate_mode_index(mode);
		// TODO: store mode to EEPROM
	}
}

static void display(int8_t mode);

int main(void)
{
	init();

	mScreen.begin(16, 2);
	mScreen.backlight();
	mScreen.home();
	mScreen.clear();

	mScreen.setCursor(0, 0);
	mScreen.print("TransistorTester");
	mScreen.setCursor(0, 1);
	mScreen.print(" v1.0  MNi 2014 ");
	sleep1s();
	mScreen.clear();

	DDRD &= ~(1 << 7);

	bool bdown = false;
	int8_t mode = init_mode();
	for (;;)
	{
		display(mode);

		bool bpress = (0 == (PIND & (1 << 7)));
		if (bpress)
		{
			bdown = true;
			sleep50ms();
		}
		else
		{
			if (bdown && !bpress)
			{
				increment_mode(mode);
				bdown = false;
			}
		}

		sleep10ms();
	}

	return 0;
}

static void display(int8_t mode)
{
	char line[2][17] = {{0}, {0}};

	switch (mode)
	{
	case M_Generator:
		line[0][0] = 'G';
		break;

	case M_Resistance:
		line[0][0] = 'R';
		break;

	case M_Capacitance:
		line[0][0] = 'C';
		break;

	case M_Diodes:
		line[0][0] = 'D';
		break;

	case M_Tranzistors:
		line[0][0] = 'T';
		break;

	case M_Frequency:
		line[0][0] = 'F';
		break;

	default:
		strncpy(line[0], "Invalid mode -- ", 16);
		strncpy(line[1], " -- Select other", 16);
	}

	mScreen.clear();

	for (uint8_t i=0; i<2; i++)
	{
		mScreen.setCursor(0, i);
		mScreen.print(line[i]);
	}
}
