//
// 07.02.2015 MNi: Refactored I2C 
// 
// Перед сборкой проекта распаковать содержимое `LiquidCrystal_V1.2.1.zip` 
// в папку с библиотеками ардуино IDE (у меня - c:\Program Files (x86)\Arduino\libraries)
// т.е. все файлы архива должны лежать в c:\Program Files (x86)\Arduino\libraries\LiquidCrystal 
// не в отдельной папке а в папке LiquidCrystal.
// Файл keywords.txt можно смело заменять файлом из архива.
//

// 27.01.2015 MNi: Refactored for Arduino IDE

#include <stdio.h>
#include <stdarg.h>
#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include "ad9850.h"

volatile unsigned char enc = 0;
volatile bool refresh = true;
volatile int_fast32_t freq = 1;
volatile int cursor = 0; 

//
// Все три адресные контакта должны быть замкнуты
// lcd i2c подключается к sda/scl пинам ардуино
//
LiquidCrystal_I2C lcd(0x20, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);

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
    // TODO: сменить или убрать splash 
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


