#ifndef _TEXT_DOSCP__
#define _TEXT_DOSCP__

typedef enum
{
	RU_HelloPeople = 0,
	EN_HelloPeople,
	LStringCount,
}
LStrings;

extern char const* lstring[LStringCount];

#endif /* _TEXT_DOSCP__ */
