#include <afx/sleep.h>
#include <afx/lcd/LiquidCrystal_I2C.h>
#include <stdint.h>

int main(void)
{
	LiquidCrystal_I2C lcd();

	for (;;)
	{
		sleep100ms();
	}

	return 0;
}

