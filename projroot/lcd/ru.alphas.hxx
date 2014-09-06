#ifndef _TEXT_DOSCP__
#define _TEXT_DOSCP__

#include <LCD.h>

typedef enum
{
	RU_Alpha1 = 0,
	RU_Alpha2,
	RU_Alpha1Cap,
	RU_Alpha2Cap,
	LStringCount,
}
LStrings;

extern char const* lstring[LStringCount];

void init_cp1251(Generic::LCD const& lcd);
char const* cp1251_to_lcd(char const* source);

#endif /* _TEXT_DOSCP__ */
