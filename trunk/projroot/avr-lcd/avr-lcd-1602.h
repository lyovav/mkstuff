#ifndef _WCDAFX_AVR_LCD_1602_H_included_
#define _WCDAFX_AVR_LCD_1602_H_included_

#include <avr/io.h>

#define _USE_1BIT_LCD_MODE          1

#define LCDM_SetEntryMode           0x04
#define LCDM_SetDisplayAndCursor    0x08
#define LCDM_SetIFOptions           0x20
#define LCDM_SetCGRAMAddress        0x40
#define LCDM_SetDDRAMAddress        0x80
#define LCD_SetBias                 0x10
#define LCD_PowerControl            0x50
#define LCD_FollowerControl         0x60
#define LCD_SetContrast             0x70

#if _USE_1BIT_LCD_MODE

/* TODO: change LCD ports */
#define _LCD_RS                     PORTD
#define _LCD_E                      PORTD
#define _LCD_D0                     PORTD

/* TODO: change LCD ports */
#define _LCD_RS_PIN                 0
#define _LCD_E_PIN                  1
#define _LCD_D0_PIN                 2

#else                               /* !_USE_1BIT_LCD_MODE */

/* TODO: set to 1 on really slow LCD's */
#define _LCD_SLOW                   0

/* TODO: change LCD ports */
#define _LCD_RS                     PORTD
#define _LCD_RW                     PORTD
#define _LCD_E                      PORTD
#define _LCD_D4                     PORTB
#define _LCD_D5                     PORTB
#define _LCD_D6                     PORTB
#define _LCD_D7                     PORTB

/* TODO: change LCD ports */
#define _LCD_RS_PIN                 0
#define _LCD_RW_PIN                 1
#define _LCD_E_PIN                  2
#define _LCD_D4_PIN                 0
#define _LCD_D5_PIN                 1
#define _LCD_D6_PIN                 2
#define _LCD_D7_PIN                 3

#endif                              /* !_USE_1BIT_LCD_MODE */


#ifdef __ASSEMBLER__

.global _lcd_pulse
.global lcdspace
.global lcdnum
.global lcdchar
.global lcdcmd
.global lcdclear
.global lcdinit
.global lcdtext
.global lcdptext
.global lcdftext
.global lcdcchar
.global lcdclearline
.global lcd1
.global lcd2

.extern _lcd_pulse
.extern lcdspace
.extern lcdnum
.extern lcdchar
.extern lcdcmd
.extern lcdclear
.extern lcdinit
.extern lcdtext
.extern lcdptext
.extern lcdftext
.extern lcdcchar
.extern lcdclearline
.extern lcd1
.extern lcd2


#else

#endif

#endif /* _WCDAFX_AVR_LCD_1602_H_included_ */

