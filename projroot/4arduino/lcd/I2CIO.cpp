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
// @file IO.h
// This file implements a basic IO library using the PCF8574 I2C IO Expander
// chip.
// 
// @brief 
// Implement a basic IO library to drive the PCF8574* I2C IO Expander ASIC.
// The library implements basic IO general methods to configure IO pin direction
// read and write uint8_t operations and basic pin level routines to set or read
// a particular IO port.
//
//
// @version API 1.0.0
//
// @author F. Malpartida - fmalpartida@gmail.com
// ---------------------------------------------------------------------------

#include "I2CIO.h"
#include <Wire.h>

extern "C" {
	#include "twi.h"
}

namespace I2C
{
    IO::IO(uint8_t addr)
        : _i2cAddr(addr)
        , _dirMask(0xff)
        , _shadow(0)
        , _initialised(false)
    {}

    // PUBLIC METHODS
    // ---------------------------------------------------------------------------

    bool IO::begin()
    {
       TwoWire::begin();

       _initialised = TwoWire::requestFrom(_i2cAddr, (uint8_t)1);
       _shadow = TwoWire::read();

       return _initialised;
    }

    void IO::pinMode ( uint8_t pin, uint8_t dir )
    {
       if ( _initialised )
       {
          if ( OUTPUT == dir )
          {
             _dirMask &= ~( 1 << pin );
          }
          else
          {
             _dirMask |= ( 1 << pin );
          }
       }
    }

    //
    // read
    uint8_t IO::read() const
    {
       uint8_t rv = 0;

       if ( _initialised )
       {
          TwoWire::requestFrom(_i2cAddr, (uint8_t)1);
          rv = (_dirMask & TwoWire::read());
       }

       return rv;
    }

    bool IO::write(uint8_t value)
    {
       int status = 0;

       if (_initialised)
       {
          // Only write HIGH the values of the ports that have been initialised as
          // outputs updating the output shadow of the device
          _shadow = (value & ~(_dirMask));

          TwoWire::beginTransmission(_i2cAddr);
          TwoWire::write(_shadow);

          status = TwoWire::endTransmission();
       }

       return (status == 0);
    }

    uint8_t IO::digitalRead(uint8_t pin) const
    {
       uint8_t pinVal = 0;

       // Check if initialized and that the pin is within range of the device
       // -------------------------------------------------------------------
       if ( ( _initialised ) && ( pin <= 7 ) )
       {
          // Remove the values which are not inputs and get the value of the pin
          pinVal = this->read() & _dirMask;
          pinVal = ( pinVal >> pin ) & 0x01; // Get the pin value
       }

       return pinVal;
    }

    //
    // digitalWrite
    int IO::digitalWrite(uint8_t pin, uint8_t level)
    {
       uint8_t writeVal;
       int status = 0;

       // Check if initialized and that the pin is within range of the device
       // -------------------------------------------------------------------
       if ((_initialised) && (pin <= 7))
       {
          // Only write to HIGH the port if the port has been configured as
          // an OUTPUT pin. Add the new state of the pin to the shadow
          writeVal = ( 1 << pin ) & ~_dirMask;
          if ( level == HIGH )
          {
             _shadow |= writeVal;
          }
          else
          {
             _shadow &= ~writeVal;
          }

          status = this->write(_shadow);
       }

       return status;
    }
}
