/*
 * ------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <phk@FreeBSD.ORG> wrote this file. As long as you retain this notice
 * you can do whatever you want with this stuff. If we meet some day,
 * and you think this stuff is worth it, you can buy me a beer in return
 * Poul-Henning Kamp
 * ------------------------------------------------------------------------
 */
#ifndef _AD9850_IMPL_H_included
#define _AD9850_IMPL_H_included

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
    AD9850(char w_clk, char fq_ud, char d7);
    void setfreq(double f);
    // set frequency in Hz
    void setphase(uint8_t p);
    // for flexibility, p is an int value and 0 <= p <= 32,
    // as input, 360 degree devide into 32 parts,
    // you will get phase increments for 360/32*p degree
   
    
    void down(); // power down
    void up(); // power on
      
  private:
    char W_CLK; // word load clock pin
    char FQ_UD; // frequency update pin
    char D7; // serial input pin
    uint32_t frequency; // delta phase
    uint8_t phase; // phase offset
    void update();
  };
  
  inline void AD9850::up() 
  {
    update(); 
  }
}

#endif // _AD9850_IMPL_H_included

