#include <stdio.h>
#include <LiquidCrystal_I2C.h>
#include <Arduino.h>
#include <afx/sleep.h>
#include <afx/strings.xtoa.h>
#include <afx/strings.xftoa.h>
#include "AD9850.hxx"

namespace dds
{
    enum
    {
        btnChangeDivisor = 2,
        rotaryValuePin = A0,
    };

    const double FREQ_MAX = 99999999.;

    I2C::LCD lcd(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);
    dds::AD9850 ad9850(8, 9, 10, 11);

    bool isButtonPressed(int pin)
    {
        int rv = digitalRead(pin);

        while (HIGH == digitalRead(pin)) ;

        return HIGH == rv;
    }

    template <typename T>
    void displayValue(T x, int col, int row)
    {
        lcd.setCursor(0, row);
        lcd.print("                ");

        char temp[17] = {0};
        Strings::ConvertFrom<T, char>(x, 10, temp, 16, false);

        lcd.setCursor(col, row);
        lcd.print(temp);
    }

    void updateFreqency(int res, int_fast32_t& theFreq, int_fast32_t divisor)
    {
        double k = res / 1023.;
        double tempFreq = (FREQ_MAX / (double) divisor) * k;

        theFreq = (int_fast32_t) tempFreq;
        ad9850.setfreq(theFreq);
    }

    int_fast32_t shiftX(int& n, int inc)
    {
        static const int_fast32_t vals[] = { 1000000, 100000, 10000, 1000, 100, 10, 1 };
        static const int dsize = (int) (sizeof(vals) / sizeof(vals[0]));

        n += inc
                        ;
        if (n > (dsize - 1))
            n = 0;

        if (n < 0)
            n = (dsize - 1);

        return vals[n];
    }
}

extern "C" void Main()
{
    using namespace dds;

    init();

    pinMode(btnChangeDivisor, INPUT);
    pinMode(rotaryValuePin, INPUT);

    lcd.begin();

    /*         0123456789012345 */
    lcd.setCursor(0, 0);
    lcd.print(" [WCD] mini-DDS ");
    lcd.setCursor(0, 1);
    lcd.print("     v1.0       ");

    sleep1000ms();

    int_fast32_t theFreq = 0;

    int idiv = -1;
    int_fast32_t divisor = shiftX(idiv, 1);

    sei();

    int pres = -1;
    unsigned long ms = millis();

    while (1)
    {
        int res = analogRead(rotaryValuePin);

        if (isButtonPressed(btnChangeDivisor))
        {
            divisor = shiftX(idiv, 1);
            updateFreqency(res, theFreq, divisor);
        }

        if (pres != res)
        {
            pres = res;
            updateFreqency(res, theFreq, divisor);
        }

        if ((millis() - ms) > 1000LU)
        {
            displayValue(theFreq, 2, 0);
            displayValue(divisor, 2, 1);

            ms = millis();
        }
    }
}
