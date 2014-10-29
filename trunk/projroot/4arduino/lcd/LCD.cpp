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
// @file LCD.cpp
// This file implements a basic liquid crystal library that comes as standard
// in the Arduino SDK.
// 
// @brief 
// This is a basic implementation of the HD44780 library of the
// Arduino SDK. This library is a refactored version of the one supplied
// in the Arduino SDK in such a way that it simplifies its extension
// to support other mechanism to communicate to LCDs such as I2C, Serial, SR, ...
// The original library has been reworked in such a way that this will be
// the base class implementing all generic methods to command an LCD based
// on the Hitachi HD44780 and compatible chipsets.
//
// This base class is a pure abstract class and needs to be extended. As reference,
// it has been extended to drive 4 and 8 bit mode control, LCDs and I2C extension
// backpacks such as the I2CLCDextraIO using the PCF8574* I2C IO Expander ASIC.
//
//
// @version API 1.1.0
//
// 2014.09.05 MNi - refactoring
// 2012.03.29 bperrybap - changed comparision to use LCD_5x8DOTS rather than 0
// @author F. Malpartida - fmalpartida@gmail.com
// ---------------------------------------------------------------------------

#include "LCD.h"
#include <stdio.h>
#include <string.h>
#include <inttypes.h>

namespace Generic
{
    LCD::~LCD()
    {}

    // Constructor
    LCD::LCD(uint8_t cols, uint8_t rows, backlight_pol bp, uint8_t charsize)
        : _displayfunction((rows < 2 ? LCD_1LINE : (rows == 2 ? LCD_2LINE : 0)))
        , _displaycontrol(LCD_DISPLAYON | LCD_CURSOROFF | LCD_BLINKOFF)
        , _displaymode(LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT)
        , _numlines(rows)
        , _cols(cols)
        , _polarity(bp)
    {
        // for some 1 line displays you can select a 10 pixel high font
        if ((charsize != LCD_5x8DOTS) && (_numlines == 1))
            _displayfunction |= LCD_5x10DOTS;
    }

    void LCD::setBacklight(uint8_t value) const
    {}

    // PUBLIC METHODS
    // ---------------------------------------------------------------------------
    // When the display powers up, it is configured as follows:
    //
    // 1. Display clear
    // 2. Function set:
    //    DL = 1; 8-bit interface data
    //    N = 0; 1-line display
    //    F = 0; 5x8 dot character font
    // 3. Display on/off control:
    //    D = 0; Display off
    //    C = 0; Cursor off
    //    B = 0; Blinking off
    // 4. Entry mode set:
    //    I/D = 1; Increment by 1
    //    S = 0; No shift
    //
    // Note, however, that resetting the Arduino doesn't reset the LCD, so we
    // can't assume that its in that state when a sketch starts (and the
    // LiquidCrystal constructor is called).
    // A call to begin() will reinitialize the LCD.
    //
    void LCD::begin() const
    {
       // SEE PAGE 45/46 FOR INITIALIZATION SPECIFICATION!
       // according to datasheet, we need at least 40ms after power rises above 2.7V
       // before sending commands. Arduino can turn on way before 4.5V so we'll wait
       // 50
       // ---------------------------------------------------------------------------
       sleepms(50000);

       //put the LCD into 4 bit or 8 bit mode
       // -------------------------------------
       if (!(_displayfunction & LCD_8BITMODE))
       {
          // this is according to the hitachi HD44780 datasheet
          // figure 24, pg 46

          // we start in 8bit mode, try to set 4 bit mode
          send(0x03, FOUR_BITS);
          sleepms(4500);

          // second try
          send(0x03, FOUR_BITS);
          sleepms(4500);

          // third go!
          send(0x03, FOUR_BITS);
          sleepms(150);

          // finally, set to 4-bit interface
          send(0x02, FOUR_BITS);
       }
       else
       {
          // this is according to the hitachi HD44780 datasheet
          // page 45 figure 23

          // Send function set command sequence
          command(LCD_FUNCTIONSET | _displayfunction);
          sleepms(4500);

          // second try
          command(LCD_FUNCTIONSET | _displayfunction);
          sleepms(150);

          // third go
          command(LCD_FUNCTIONSET | _displayfunction);
       }

       // finally, set # lines, font size, etc.
       command(LCD_FUNCTIONSET | _displayfunction);

       display();

       // clear the LCD
       clear();

       // set the entry mode
       command(LCD_ENTRYMODESET | _displaymode);

       backlight();
    }

    void LCD::setCursor(uint8_t col, uint8_t row) const
    {
       const uint8_t row_offsetsDef[]   = { 0x00, 0x40, 0x14, 0x54 }; // For regular LCDs
       const uint8_t row_offsetsLarge[] = { 0x00, 0x40, 0x10, 0x50 }; // For 16x4 LCDs

       if ( row >= _numlines )
       {
          row = _numlines-1;    // rows start at 0
       }

       // 16x4 LCDs have special memory map layout
       // ----------------------------------------
       if ( _cols == 16 && _numlines == 4 )
       {
          command(LCD_SETDDRAMADDR | (col + row_offsetsLarge[row]));
       }
       else
       {
          command(LCD_SETDDRAMADDR | (col + row_offsetsDef[row]));
       }
    }

    void LCD::setCursor20x4(uint8_t col, uint8_t row) const
    {
       const uint8_t offset[] = { 0x00, 0x40, 0x10, 0x50 };

       if ( row >= _numlines )
          row = _numlines-1;

       command(LCD_SETDDRAMADDR | ((offset[row] + col) & 0x0f));
    }

    // Write to CGRAM of new characters
    void LCD::createChar(uint8_t location, uint8_t const* charmap) const
    {
       location &= 0x7;

       command(LCD_SETCGRAMADDR | (location << 3));
       sleepms(30);

       for (int i=0; i<8; i++)
       {
          write(charmap[i]);
          sleepms(40);
       }
    }

    size_t LCD::send(uint8_t value, uint8_t mode) const
    {
    	// TODO: report pure virtual call
    	return 0;
    }

    size_t LCD::write(uint8_t value) const
    {
    	return send(value, DATA);
    }
}
