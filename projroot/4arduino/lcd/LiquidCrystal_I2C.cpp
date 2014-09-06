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
// @file LiquidCrystal_I2C.c
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
//
// @author F. Malpartida - fmalpartida@gmail.com
// ---------------------------------------------------------------------------

#include "LiquidCrystal_I2C.h"

namespace I2C
{
	LCD::~LCD()
	{}

    LCD::LCD(uint8_t rows, uint8_t cols
           , uint8_t addr
           , uint8_t en
           , uint8_t rw
           , uint8_t rs
           , uint8_t d4
           , uint8_t d5
           , uint8_t d6
           , uint8_t d7
           , uint8_t blp
           , uint8_t pol
           , uint8_t charsize
           )
        : Super(rows, cols, (backlight_pol)pol, charsize)
        , _backlightPinMask(1 << blp)
        , _backlightStsMask(LCD_NOBACKLIGHT)
        , _i2cio(addr)
        , _En(1 << en)
        , _Rw(1 << rw)
        , _Rs(1 << rs)
    {
       _data_pins[0] = (1 << d4);
       _data_pins[1] = (1 << d5);
       _data_pins[2] = (1 << d6);
       _data_pins[3] = (1 << d7);
    }

    void LCD::setBacklightPin(uint8_t value, backlight_pol pol)
    {
       _backlightPinMask = (1 << value);
       _polarity = pol;
       setBacklight(BACKLIGHT_OFF);
    }

    void LCD::setBacklight(uint8_t value)
    {
       // Check if backlight is available
       // ----------------------------------------------------
       if ( _backlightPinMask != 0x0 )
       {
          // Check for polarity to configure mask accordingly
          // ----------------------------------------------------------
          if  (((_polarity == POSITIVE) && (value > 0)) ||
               ((_polarity == NEGATIVE) && (value == 0)))
          {
             _backlightStsMask = _backlightPinMask & LCD_BACKLIGHT;
          }
          else
          {
             _backlightStsMask = _backlightPinMask & LCD_NOBACKLIGHT;
          }

          _i2cio.write(_backlightStsMask);
       }
    }

    bool LCD::init()
    {
       bool rv = false;

       // initialize the backpack IO expander
       // and display functions.
       // ------------------------------------------------------------------------
       if (_i2cio.begin())
       {
          _i2cio.portMode(I2C::IO::OUTPUT);
          _displayfunction |= LCD_4BITMODE;
          _i2cio.write(0);  // Set the entire port to LOW
          rv = true;
       }

       return rv;
    }

    size_t LCD::send(uint8_t value, uint8_t mode) const
    {
       // No need to use the delay routines since the time taken to write takes
       // longer that what is needed both for toggling and enable pin an to execute
       // the command.

       if ( mode == FOUR_BITS )
       {
          write4bits((value & 0x0F), COMMAND);
       }
       else
       {
          write4bits((value >> 4), mode);
          write4bits((value & 0x0F), mode);
       }

       return 1;
    }

    void LCD::write4bits(uint8_t value, uint8_t mode) const
    {
       uint8_t pinMapValue = 0;

       // Map the value to LCD pin mapping
       for ( uint8_t i = 0; i < 4; i++ )
       {
          if ( ( value & 0x1 ) == 1 )
          {
             pinMapValue |= _data_pins[i];
          }
          value = ( value >> 1 );
       }

       // Is it a command or data
       if ( mode == DATA )
          mode = _Rs;

       pinMapValue |= mode | _backlightStsMask;
       pulseEnable(pinMapValue);
    }

    void LCD::pulseEnable(uint8_t data) const
    {
       _i2cio.write(data |  _En);  // En HIGH
       _i2cio.write(data & ~_En);  // En LOW
    }
}
