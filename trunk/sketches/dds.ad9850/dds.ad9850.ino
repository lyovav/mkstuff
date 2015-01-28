// 27.01.2015 Refactored for Arduino IDE

#include <stdio.h>
#include <stdarg.h>
#include <LiquidCrystal.h>
#include "AD9850.h"
#include "rotary.h"

/*
static int_fast32_t get_multiplier(volatile int& cursor)
{
    static const int_fast32_t vals[] = { 1L, 10L, 100L, 1000L, 10000L, 100000L, 1000000L, 10000000L, 100000000L };
    static const int dsize = (int) (sizeof(vals) / sizeof(vals[0]));

    if (cursor > (dsize - 1))
        cursor = (dsize - 1);

    if (cursor < 0)
        cursor = 0;

    return vals[cursor];
}
*/

static const uint8_t btnCursor = A3;
static const int_fast32_t freqLimitValue = 999999999L;

LiquidCrystal lcd(6, 7, 8, 9, 10, 11, 12);
dds::AD9850 ad9850(3, 2, 4, 5);

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

void show_logo();

void setup()
{
  sei();
  
  Serial.begin(9600);
  
  lcd.begin(16, 2);
  show_logo();
  delay(1500);
  
  //rotary::init();
  lcd.clear();
  lcd.cursor();

  //pinMode(btnCursor, INPUT);
  //digitalWrite(btnCursor, HIGH);
}

volatile unsigned char enc = 0;
volatile bool refresh = true;
volatile int_fast32_t freq = 1;
volatile int cursor = 0;

void serialEvent()
{
  if (Serial.available())
  {
    char buffer[128] = {0};
    Serial.readBytesUntil('\r', buffer, sizeof(buffer)-1);
    
    freq = (volatile int_fast32_t)atol(buffer);
    refresh = true;
    
    Serial.print("Set freq - ");
    Serial.println(freq);
  }
}

void loop()
{
  /*
    int encPressed = analogRead(btnCursor);
    unsigned char encChanged = rotary::get_value();

    if (encChanged)
    {
        enc = encChanged;

        if (encPressed < 511)
        {
            if (DIR_CCW == enc)
                --cursor;
            else if (DIR_CW == enc)
                ++cursor;

            get_multiplier(cursor);
        }
        else
        {
            int_fast32_t ml = get_multiplier(cursor);

            if (DIR_CCW == enc)
            {
                freq -= ml;
                if (freq < 0)
                    freq = 0;

            }
            else if (DIR_CW == enc)
            {
                freq += ml;
                if (freq > freqLimitValue)
                    freq = freqLimitValue;
            }
        }

        refresh = true;
        delay(50);
    }
    */

    if (refresh)
    {
        ad9850.setfreq(freq);

        int megs = freq / 1000000L;
        int kils = (freq - (megs * 1000000L)) / 1000L;
        int hnds = (freq - (megs * 1000000L) - (kils * 1000L));

    	printl(0, " %03d %03d %03d Hz ", megs, kils, hnds);

        unsigned cpos = 11 - cursor;

        if (cursor > 2) --cpos;
        if (cursor > 5) --cpos;

    	lcd.setCursor(cpos, 0);

        refresh = false;
    }
}


