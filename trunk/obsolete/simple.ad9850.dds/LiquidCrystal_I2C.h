// ---------------------------------------------------------------------------
// Created by Francisco Malpartida on 20/08/11.
// Copyright 2011 - Under creative commons license 3.0:
//        Attribution-ShareAlike CC BY-SA
//
// This software is furnished "as is", without technical support, and with no 
// warranty, express or implied, as to its usefulness for any purpose.
//
// Thread Safe: No
// Extendable: Yes
//
// @file LCD.h
// This file implements a basic liquid crystal library that comes as standard
// in the Arduino SDK but using an I2C IO extension board.
// 
// @brief 
// This is a basic implementation of the LiquidCrystal library of the
// Arduino SDK. The original library has been reworked in such a way that 
// this class implements the all methods to command an LCD based
// on the Hitachi HD44780 and compatible chipsets using I2C extension
// backpacks such as the I2CLCDextraIO with the PCF8574* I2C IO Expander ASIC.
//
// The functionality provided by this class and its base class is identical
// to the original functionality of the Arduino LiquidCrystal library.
//
//
// @author F. Malpartida - fmalpartida@gmail.com
// ---------------------------------------------------------------------------

#ifndef _LiquidCrystal_I2C_h
#define _LiquidCrystal_I2C_h

#include "LCD.h"
#include "I2CIO.h"
#include <inttypes.h>

namespace I2C
{
    using namespace Generic;

    enum
    {
        /*!
         @defined
         @abstract   LCD_NOBACKLIGHT
         @discussion NO BACKLIGHT MASK
         */
         LCD_NOBACKLIGHT = 0x00

        /*!
         @defined
         @abstract   LCD_BACKLIGHT
         @discussion BACKLIGHT MASK used when backlight is on
         */
        , LCD_BACKLIGHT   = 0xff
    };

    class LCD: public Generic::LCD
    {
    public:
        typedef Generic::LCD Super;

        enum
        {
            /*!
             @defined
             @abstract   LCD data-line allocation this library only supports 4 bit LCD control
             mode.
             @discussion D4, D5, D6, D7 LCD data lines pin mapping of the extender module
             */
            D4 = 0, D5, D6, D7,

            /*!
             @defined
             @abstract   Enable bit of the LCD
             @discussion Defines the IO of the expander connected to the LCD Enable
             */
            EN = 6,  // Enable bit

            /*!
             @defined
             @abstract   Read/Write bit of the LCD
             @discussion Defines the IO of the expander connected to the LCD Rw pin
             */
            RW = 5,  // Read/Write bit

            /*!
             @defined
             @abstract   Register bit of the LCD
             @discussion Defines the IO of the expander connected to the LCD Register select pin
             */
            RS = 4,  // Register select bit

            BLP = 3,
        };

        /*!
         @method
         @abstract   Class constructor.
         @discussion Initializes class variables and defines the I2C address of the
         LCD. The constructor does not initialize the LCD.

         @param      addr[in] I2C address of the IO expansion module. For I2CLCDextraIO,
         the address can be configured using the on board jumpers.
         @param      En[in] LCD En (Enable) pin connected to the IO extender module
         @param      Rw[in] LCD Rw (Read/write) pin connected to the IO extender module
         @param      Rs[in] LCD Rs (Reset) pin connected to the IO extender module
         @param      d4[in] LCD data 0 pin map on IO extender module
         @param      d5[in] LCD data 1 pin map on IO extender module
         @param      d6[in] LCD data 2 pin map on IO extender module
         @param      d7[in] LCD data 3 pin map on IO extender module
         */
        LCD(uint8_t cols, uint8_t rows, uint8_t addr
          , uint8_t en = EN
          , uint8_t rw = RW
          , uint8_t rs = RS
          , uint8_t d4 = D4
          , uint8_t d5 = D5
          , uint8_t d6 = D6
          , uint8_t d7 = D7
          , uint8_t blp = BLP
          , uint8_t pol = POSITIVE
          , uint8_t charsize = LCD_5x8DOTS
          );

        virtual ~LCD();

        /*!
         @function
         @abstract   LCD initialization and associated HW.
         @discussion Initializes the LCD to a given size (col, row). This methods
         initializes the LCD, therefore, it MUST be called prior to using any other
         method from this class or parent class.

         The begin method can be overloaded if necessary to initialize any HW that
         is implemented by a library and can't be done during construction, here
         we use the Wire class.

         @param      cols[in] the number of columns that the display has
         @param      rows[in] the number of rows that the display has
         @param      charsize[in] size of the characters of the LCD: LCD_5x8DOTS or
         LCD_5x10DOTS.
         */
        void begin();

        /*!
         @function
         @abstract   Sets the pin to control the backlight.
         @discussion Sets the pin in the device to control the backlight. This device
         doesn't support dimming backlight capability.

         @param      0: backlight off, 1..255: backlight on.
         */
        void setBacklightPin(uint8_t value, backlight_pol pol);

        /*!
         @function
         @abstract   Switch-on/off the LCD backlight.
         @discussion Switch-on/off the LCD backlight.
         The setBacklightPin has to be called before setting the backlight for
         this method to work. @see setBacklightPin.

         @param      value: backlight mode (HIGH|LOW)
         */
        virtual void setBacklight(uint8_t value);

    private:
        uint8_t _backlightPinMask;  // Backlight IO pin mask
        uint8_t _backlightStsMask;  // Backlight status mask
        mutable I2C::IO _i2cio;		// I2CIO PCF8574* expansion module driver I2CLCDextraIO
        uint8_t _En;                // LCD expander word for enable pin
        uint8_t _Rw;                // LCD expander word for R/W pin
        uint8_t _Rs;                // LCD expander word for Register Select pin
        uint8_t _data_pins[4];      // LCD data lines

        /*!
         @method
         @abstract   Initializes the LCD class
         @discussion Initializes the LCD class and IO expansion module.
         */
        bool init();

        /*!
         @method
         @abstract   Writes an 4 bit value to the LCD.
         @discussion Writes 4 bits (the least significant) to the LCD control data lines.
         @param      value[in] Value to write to the LCD
         @param      more[in]  Value to distinguish between command and data.
         COMMAND == command, DATA == data.
         */
        void write4bits(uint8_t value, uint8_t mode) const;

        /*!
         @method
         @abstract   Pulse the LCD enable line (En).
         @discussion Sends a pulse of 1 uS to the Enable pin to execute an command
         or write operation.
         */
        void pulseEnable(uint8_t) const;

        /*!
         @function
         @abstract   Send a particular value to the LCD.
         @discussion Sends a particular value to the LCD for writing to the LCD or
         as an LCD command.

         Users should never call this method.

         @param      value[in] Value to send to the LCD.
         @param      mode[in] DATA - write to the LCD CGRAM, COMMAND - write a
         command to the LCD.
         */
        virtual size_t send(uint8_t value, uint8_t mode) const;
        
        virtual size_t write(uint8_t value);

    private:
        LCD(LCD const&);
        LCD& operator = (LCD const&);
    };

    inline void LCD::begin()
    {
       init();
       Super::begin();
       setBacklight(BACKLIGHT_ON);
    }
}

#endif /* _LiquidCrystal_I2C_h */