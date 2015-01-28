#ifndef __ASSEMBLER__
#define __ASSEMBLER__
#endif

#include "avr-lcd-1602.h"

#if _USE_1BIT_LCD_MODE

#define preg_1                  r24
#define preg_2                  r22

#define set_en_low              cbi         _SFR_IO_ADDR(_LCD_E), _LCD_E_PIN
#define set_en_high             sbi         _SFR_IO_ADDR(_LCD_E), _LCD_E_PIN

#define set_rs_low              cbi         _SFR_IO_ADDR(_LCD_RS), _LCD_RS_PIN
#define set_rs_high             sbi         _SFR_IO_ADDR(_LCD_RS), _LCD_RS_PIN

#define set_b0_low              cbi         _SFR_IO_ADDR(_LCD_D0), _LCD_D0_PIN
#define set_b0_high             sbi         _SFR_IO_ADDR(_LCD_D0), _LCD_D0_PIN


.section .text

_lcd_pulse:         sbrc                preg_1, 0
                    set_rs_high
                    sbrs                preg_1, 0
                    set_rs_low

                    set_en_low
                    sbrc                preg_2, 7
                    set_b0_high
                    sbrs                preg_2, 7
                    set_b0_low
                    set_en_high

                    set_en_low
                    sbrc                preg_2, 6
                    set_b0_high
                    sbrs                preg_2, 6
                    set_b0_low
                    set_en_high

                    set_en_low
                    sbrc                preg_2, 5
                    set_b0_high
                    sbrs                preg_2, 5
                    set_b0_low
                    set_en_high

                    set_en_low
                    sbrc                preg_2, 4
                    set_b0_high
                    sbrs                preg_2, 4
                    set_b0_low
                    set_en_high

                    set_en_low
                    sbrc                preg_2, 3
                    set_b0_high
                    sbrs                preg_2, 3
                    set_b0_low
                    set_en_high

                    set_en_low
                    sbrc                preg_2, 2
                    set_b0_high
                    sbrs                preg_2, 2
                    set_b0_low
                    set_en_high

                    set_en_low
                    sbrc                preg_2, 1
                    set_b0_high
                    sbrs                preg_2, 1
                    set_b0_low
                    set_en_high

                    set_en_low
                    sbrc                preg_2, 0
                    set_b0_high
                    sbrs                preg_2, 0
                    set_b0_low
                    set_en_high

                    ret

#endif /* _USE_1BIT_LCD_MODE */
