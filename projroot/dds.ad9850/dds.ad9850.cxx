#include <stdio.h>
#include <LiquidCrystal_I2C.h>
#include <Arduino.h>
#include <afx/sleep.h>
#include <afx/strings.xtoa.h>
#include <afx/strings.xftoa.h>
#include "AD9850.hxx"
#include "rotary.hxx"

static int_fast32_t get_multiplier(int& cursor)
{
    static const int_fast32_t vals[] = { 1L, 10L, 100L, 1000L, 10000L, 100000L, 1000000L, 10000000L, 100000000L };
    static const int dsize = (int) (sizeof(vals) / sizeof(vals[0]));

    if (cursor > (dsize - 1))
        cursor = (dsize - 1);

    if (cursor < 0)
        cursor = 0;

    return vals[cursor];
}


extern "C" void Main()
{
    static const uint8_t btnCursor = A3;
    static const int_fast32_t freqLimitValue = 999999999L;

    I2C::LCD lcd(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);
    dds::AD9850 ad9850(3, 2, 4, 5);

    init();
    lcd.begin();

	prints(lcd, 0, " [WCD] mini-DDS ");
	prints(lcd, 1, " M.Nikonov 2014 ");
	delay(700);

    sei();
    rotary::init();
    lcd.clear();
    lcd.cursor();

    pinMode(btnCursor, INPUT);
    digitalWrite(btnCursor, HIGH);

    unsigned char enc = 0;
    bool refresh = true;
    int_fast32_t freq = 1;
    int cursor = 0;

    while (1)
    {
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
        }

        if (refresh)
        {
            ad9850.setfreq(freq);

            int megs = freq / 1000000L;
            int kils = (freq - (megs * 1000000L)) / 1000L;
            int hnds = (freq - (megs * 1000000L) - (kils * 1000L));

        	printl(lcd, 0, " %03d %03d %03d Hz ", megs, kils, hnds);

            unsigned cpos = 11 - cursor;

            if (cursor > 2) --cpos;
            if (cursor > 5) --cpos;

        	lcd.setCursor(cpos, 0);

            refresh = false;
        }
    }
}
