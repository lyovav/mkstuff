// Control a AD9851 DDS based on the good work of others including:
// Mike Bowthorpe, http://www.ladyada.net/rant/2007/02/cotw-ltc6903/ and
// http://www.geocities.com/leon_heller/dds.html
// This code by Peter Marks http://marxy.org

#include <Arduino.h>

#define DDS_CLOCK 180000000

byte LOAD = 11; 
byte CLOCK = 9; 
byte DATA = 10;
byte LED = 13;

void outOne();
void outZero();
void byte_out(unsigned char byte);

/*
void setup()
{
  pinMode (DATA, OUTPUT); // sets pin 10 as OUPUT
  pinMode (CLOCK, OUTPUT); // sets pin 9 as OUTPUT
  pinMode (LOAD, OUTPUT); // sets pin 8 as OUTPUT
  pinMode (LED, OUTPUT);
}

void loop()
{
  // Do a frequency sweep in Hz
  for(unsigned long freq = 10000000; freq < 10001000; freq++)
  {
    sendFrequency(freq);
    delay(2);
  }
}
*/

void sendFrequency(unsigned long frequency)
{
  unsigned long tuning_word = (frequency * pow(2, 32)) / DDS_CLOCK;
  digitalWrite (LOAD, LOW); // take load pin low

  for(int i = 0; i < 32; i++)
  {
    if ((tuning_word & 1) == 1)
      outOne();
    else
      outZero();
    tuning_word = tuning_word >> 1;
  }
  byte_out(0x09);

  digitalWrite (LOAD, HIGH); // Take load pin high again
}

void byte_out(unsigned char byte)
{
  int i;

  for (i = 0; i < 8; i++)
  {
    if ((byte & 1) == 1)
      outOne();
    else
      outZero();
    byte = byte >> 1;
  }
}

void outOne()
{
  digitalWrite(CLOCK, LOW);
  digitalWrite(DATA, HIGH);
  digitalWrite(CLOCK, HIGH);
  digitalWrite(DATA, LOW);
}

void outZero()
{
  digitalWrite(CLOCK, LOW);
  digitalWrite(DATA, LOW);
  digitalWrite(CLOCK, HIGH);
}
