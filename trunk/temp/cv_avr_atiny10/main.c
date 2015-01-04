/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 04.01.2015
Author  : 
Company : 
Comments: 


Chip type               : ATtiny10
AVR Core Clock frequency: 8,000000 MHz
Memory model            : Tiny
External RAM size       : 0
Data Stack size         : 8
*******************************************************/

#include <tiny10.h>

// Declare your global variables here

void main(void)
{
// Declare your local variables here

// Main Clock source: Calibrated Internal 8 MHz Osc.
CCP=0xd8;
CLKMSR=(0<<CLKMS1) | (0<<CLKMS0);
// Clock Prescaler division factor: 1
CCP=0xd8;
CLKPSR=(0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);

// Voltage Level Monitor initialization
// Trigger Level: Voltage Level Monitor Disabled
// Interrupt: Off
VLMCSR=(0<<VLMF) | (0<<VLMIE) | (0<<VLM2) | (0<<VLM1) | (0<<VLM0);

// Input/Output Ports initialization
// Port B initialization
// Pull-up initialization
PUEB=(0<<PUEB3) | (0<<PUEB2) | (0<<PUEB1) | (0<<PUEB0);
// Function: Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRB=(1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
// State: Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTB=(0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Break Before Make Mode PORTB: Off
PORTCR=(0<<BBMB);

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFFFF
// Input Capture on Falling Edge
// Input Capture Noise Canceler: Off
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
TCCR0B=(0<<ICNC0) | (0<<ICES0) | (0<<WGM03) | (0<<WGM02) | (0<<CS02) | (0<<CS01) | (0<<CS00);
TCNT0=0x0000;
ICR0=0x0000;
OCR0A=0x0000;
OCR0B=0x0000;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=(0<<ICIE0) | (0<<OCIE0B) | (0<<OCIE0A) | (0<<TOIE0);

// External Interrupt(s) initialization
// INT0: Off
// Interrupt on any change on pins PCINT0-3: Off
EICRA=(0<<ISC01) | (0<<ISC00);
EIMSK=(0<<INT0);
PCICR=(0<<PCIE0);

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
// Digital input buffer on AIN0: On
// Digital input buffer on AIN1: On
DIDR0=(0<<ADC0D) | (0<<ADC1D);

// ADC initialization
// ADC disabled
ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);


while (1)
      {
      // Place your code here

      }
}
