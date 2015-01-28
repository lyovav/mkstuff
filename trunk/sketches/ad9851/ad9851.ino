#include <Arduino.h>

#define _AD9851_SOL1 0

#if _AD9851_SOL1
extern byte LOAD; 
extern byte CLOCK; 
extern byte DATA;
extern byte LED;

void sendFrequency(unsigned long frequency);
#endif

void setup()
{
  Serial.begin(9600);
  
#if _AD9851_SOL1  
  pinMode(DATA, OUTPUT);
  pinMode(CLOCK, OUTPUT);
  pinMode(LOAD, OUTPUT);
  pinMode(LED, OUTPUT);
#endif  
}

void loop()
{
  if (Serial.available())
  {
  }
  
#if _AD9851_SOL1
  for (unsigned long freq = 10000000; freq < 10001000; freq++)
  {
    sendFrequency(freq);
    delay(2);
  }
#endif
}

