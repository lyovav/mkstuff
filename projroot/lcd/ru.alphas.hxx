#ifndef _TEXT_DOSCP__
#define _TEXT_DOSCP__

#include <LCD.h>

typedef enum
{
	RU_Alpha1 = 0,
	RU_Alpha2,
	LStringCount,
}
LStrings;

extern char const* lstring[LStringCount];

void init_ru_cp(Generic::LCD const& lcd);

#endif /* _TEXT_DOSCP__ */
