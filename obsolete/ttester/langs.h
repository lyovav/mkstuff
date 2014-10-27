#ifndef _ESR_METER_LANGS_H__
#define _ESR_METER_LANGS_H__

#ifndef __ASSEMBLER__ // FIXME: asm compiler didn't understood c's enums, yak!

typedef enum
{
	LANG_BRASIL = 0,
	LANG_CZECH,
	LANG_DUTCH,
	LANG_ENGLISH,
	LANG_GERMAN,
	LANG_HUNGARIAN,
	LANG_ITALIAN,
	LANG_LITHUANIAN,
	LANG_POLISH,
	LANG_RUSSIAN,
	LANG_SLOVAK,
	LANG_SLOVENE,
	LANG_UKRAINIAN,
}
SupportedLangs;

#endif /* __ASSEMBLER__ */

#endif /* _ESR_METER_LANGS_H__ */
