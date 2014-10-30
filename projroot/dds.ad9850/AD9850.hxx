/*
 * ------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <phk@FreeBSD.ORG> wrote this file. As long as you retain this notice
 * you can do whatever you want with this stuff. If we meet some day,
 * and you think this stuff is worth it, you can buy me a beer in return
 * Poul-Henning Kamp
 * ------------------------------------------------------------------------
 */

#ifndef _AD9850_HXX_included
#define _AD9850_HXX_included

#include <Arduino.h>
#include <stdint.h>

namespace dds
{
    /*
     * NOTE: For device start-up in serial mode,
     * hardwire pin 2 at 0, pin 3 at 1, and pin 4 at 1
     *
     */

    class AD9850
    {
    public:
        AD9850(uint8_t w_clk, uint8_t fq_ud, uint8_t d7, uint8_t rst);

        // set frequency in Hz
        void setfreq(double f);

        // for flexibility, p is an integer value and 0 <= p <= 32,
        // as input, 360 degree divide into 32 parts,
        // you will get phase increments for 360/32*p degree
        void setphase(uint8_t p);

        void down() const;      // power down
        void up() const;        // power on

    private:
        uint8_t W_CLK_;         // word load clock pin
        uint8_t FQ_UD_;         // frequency update pin
        uint8_t D7_;            // serial input pin
        uint32_t frequency_;    // delta phase
        uint8_t phase_;         // phase offset

        void update() const;
    };

    inline void AD9850::up() const
    {
        update();
    }
}

#endif // _AD9850_HXX_included

