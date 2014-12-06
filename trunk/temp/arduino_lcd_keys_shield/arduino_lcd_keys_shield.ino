#include <LiquidCrystal.h>

namespace 
{
  LiquidCrystal lcd(8, 9, 4, 5, 6, 7);
  
  enum button_id
  {
    BID_NONE = 0, BID_RIGHT, BID_UP,
    BID_DOWN, BID_LEFT, BID_SELECT
  };
  
  static button_id get_button_id(int signal) {
    if (signal < 50) return BID_RIGHT;  
    if (signal < 100) return BID_UP; 
    if (signal < 300) return BID_DOWN; 
    if (signal < 450) return BID_LEFT; 
    if (signal < 650) return BID_SELECT;  
    return BID_NONE;
  }
}

#include "strings.h"

void setup() {
#if 1  
  lcd.begin(20, 4);
#else
  lcd.begin(16, 2);
#endif  
  lcd.setCursor(0, 0);
  lcd.print(F("{.|r~Дарофф!}"));
  lcd.setCursor(0, 2);
  lcd.print(ru_str1);
  lcd.setCursor(0, 3);
  lcd.print(ru_str2);
}

void loop() {
  int buttonSignal = analogRead(A0);
  button_id button = get_button_id(buttonSignal);  
  char button_name[] = " >^_<*";
  
  char buf[256];
  snprintf(buf, 256, "A0: %4d %c", buttonSignal, button_name[button]);
  
  lcd.setCursor(0, 1);
  lcd.print(buf);
}

