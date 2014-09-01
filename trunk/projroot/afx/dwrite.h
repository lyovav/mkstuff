#ifndef _AFX_DWRITE_H__
#define _AFX_DWRITE_H__

#include <avr/io.h>

#define _din(port, pin)			((PIN##port & (1 << pin)) != 0)
#define _dset(port, pin)		(PORT##port |= (1 << pin))
#define _dclr(port, pin)		(PORT##port &= ~(1 << pin))

#define _dwritable(port, pin)	(DDR##port |= (1 << pin))
#define _dreadable(port, pin)	(DDR##port &= ~(1 << pin))

#endif /* _AFX_DWRITE_H__ */
