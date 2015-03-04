// 27.01.2015 Refactored for Arduino IDE

#include <stdio.h>
#include <stdarg.h>
#include <LiquidCrystal.h>
#include "ad9850.h"

volatile unsigned char enc = 0;
volatile bool refresh = true;
volatile int_fast32_t freq = 1;
volatile int cursor = 0; 

LiquidCrystal lcd(2, 3, 4, 5, 6, 7, 8);
dds::AD9850 ad9850(9, 10, 11, 12);

void prints(uint8_t row, char const* text)
{
  lcd.setCursor(0, row);
  lcd.print(text);
  Serial.println(text);
} 

void printl(uint8_t row, char const* format, ...)
{
  va_list ap;
  va_start(ap, format);
  
  char buffer[129] = {0};
  vsnprintf(buffer, 128, format, ap);
  
  prints(row, buffer);
  va_end(ap); 
}

void setup()
{
  sei();
  
  Serial.begin(9600);
  
  lcd.begin(20, 4);
  lcd.clear();
  
  {
    static const char cyr_l1[] = { "   DDS \xa1" "e\xbd" "epa\xbfop" };
    static const char cyr_l2[] = { "  H\xb8ko\xbdo\xb3 M.  2015" };
    prints(0, cyr_l1);
    prints(3, cyr_l2);
    delay(2300);
  }
}

void serialEvent()
{
  if (Serial.available())
  {
    char buffer[128] = {0};
    Serial.readBytesUntil('\r', buffer, sizeof(buffer)-1);
    
    freq = (volatile int_fast32_t)atol(buffer);
    refresh = true;
    
    Serial.print("<< ");
    Serial.println(buffer);
  }
}

void loop()
{
    if (refresh)
    {
        ad9850.setfreq(freq);

        int megs = freq / 1000000L;
        int kils = (freq - (megs * 1000000L)) / 1000L;
        int hnds = (freq - (megs * 1000000L) - (kils * 1000L));

    	printl(1, "   %03d %03d %03d Hz ", megs, kils, hnds);

        unsigned cpos = 11 - cursor;

        if (cursor > 2) --cpos;
        if (cursor > 5) --cpos;

    	lcd.setCursor(cpos, 0);

        refresh = false;
    }
}


