#ifndef _ESRM_TBITMAP_INCLUDED__
#define _ESRM_TBITMAP_INCLUDED__

#include <avr/pgmspace.h>

struct tbitmap
{
   unsigned char type;
   unsigned char width;
   unsigned char height;
   unsigned char stuffing;
   const unsigned char *data;
};

// Supported Bitmap types
#define BITMAP_UNCOMPRESSED     1

#endif /* _ESRM_TBITMAP_INCLUDED__ */
