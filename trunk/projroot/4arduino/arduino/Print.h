/*
  Print.h - Base class that provides print() and println()
  Copyright (c) 2008 David A. Mellis.  All right reserved.

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

#ifndef Print_h
#define Print_h

#include "Printable.h"
#include "WString.h"
#include <inttypes.h>
#include <string.h>

enum
{
  DEC = 10
, HEX = 16
, OCT = 8
, BIN = 2
};

class Print
{
public:
    Print();
    virtual ~Print();
    virtual size_t write(uint8_t) const;
    virtual size_t write(uint8_t const* buffer, size_t size) const;
  
    int getWriteError() const;
    void setWriteError(int err) const;
    void clearWriteError() const;

    size_t write(char const* str) const;
    size_t print(__FlashStringHelper const*) const;
    size_t print(String const&) const;
    size_t print(char const*) const;
    size_t print(char) const;
    size_t print(unsigned char, int = DEC) const;
    size_t print(int, int = DEC) const;
    size_t print(unsigned int, int = DEC) const;
    size_t print(long, int = DEC) const;
    size_t print(unsigned long, int = DEC) const;
    size_t print(double, int = 2) const;
    size_t print(const Printable&) const;

#ifdef _PRINT_USES_ELIPSIS
    size_t printf(char const* format, ...) const;
#endif /* _PRINT_USES_ELIPSIS */

private:
    mutable int write_error;

    size_t printNumber(unsigned long, uint8_t) const;
    size_t printFloat(double, uint8_t) const;
};

inline Print::Print()
    : write_error(0)
{}

inline size_t Print::write(const char *str) const
{
    if (str == NULL)
        return 0;

    return write((const uint8_t *)str, strlen(str));
}

inline int Print::getWriteError() const { return write_error; }
inline void Print::setWriteError(int err) const { write_error = err; }
inline void Print::clearWriteError() const { write_error = 0; }

inline size_t Print::print(char const* str) const { return write(str); }
inline size_t Print::print(char c) const { return write(c); }
inline size_t Print::print(unsigned char b, int base) const { return print((unsigned long) b, base); }
inline size_t Print::print(int n, int base) const { return print((long) n, base); }
inline size_t Print::print(unsigned int n, int base) const { return print((unsigned long) n, base); }
inline size_t Print::print(double n, int digits) const { return printFloat(n, digits); }
inline size_t Print::print(Printable const& x) const { return x.printTo(*this); }

#endif
