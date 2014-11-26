/*
 * Rotary encoder library for Arduino.
 */

#ifndef _3RDP_ROTARY_HXX_included
#define _3RDP_ROTARY_HXX_included

namespace rotary
{
    #define ROTARY_PIN1 8
    #define ROTARY_PIN2 9

    #define DIR_CCW 0x10
    #define DIR_CW  0x20

    void init();
    unsigned char get_value();
}

#endif // _3RDP_ROTARY_HXX_included
 
