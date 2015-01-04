#ifndef _WCD_Tiny_LCD_Lib_h__included__
#define _WCD_Tiny_LCD_Lib_h__included__

typedef struct _LCD_CNF
{
  uint8_t rs;           // LOW: command.  HIGH: character.
  uint8_t rw;           // LOW: write to LCD.  HIGH: read from LCD.
  uint8_t en;           // activated by a HIGH pulse.
  uint8_t dp[4];        // Data pins config
}
LCD_CNF;

void LCD_ctor(LCD_CNF* lcd); 

#endif /* _WCD_Tiny_LCD_Lib_h__included__ */ 
