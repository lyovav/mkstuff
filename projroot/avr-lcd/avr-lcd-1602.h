#ifndef _WCDAFX_AVR_LCD_1602_H_included_
#define _WCDAFX_AVR_LCD_1602_H_included_

#include <avr/io.h>

#define LCDM_SetEntryMode           0x04
#define LCDM_SetDisplayAndCursor    0x08
#define LCDM_SetIFOptions           0x20
#define LCDM_SetCGRAMAddress        0x40
#define LCDM_SetDDRAMAddress        0x80
#define LCD_SetBias                 0x10
#define LCD_PowerControl            0x50
#define LCD_FollowerControl         0x60
#define LCD_SetContrast             0x70

#define _LCD_RS
#define _LCD_RW
#define _LCD_E
#define _LCD_D4
#define _LCD_D5
#define _LCD_D6
#define _LCD_D7

#ifdef __ASSEMBLER__
#else
#error "implemented for assembly source only"
#endif

#endif /* _WCDAFX_AVR_LCD_1602_H_included_ */

