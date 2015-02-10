#include <Arduino.h>

#define _AD9851_SOL1 1

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

static volatile unsigned long freq = 1;
static volatile bool refresh = true;

void serialEvent()
{
  char buffer[128] = {0};
  Serial.readBytesUntil('\r', buffer, sizeof(buffer)-1);
  
  freq = (volatile int_fast32_t)atol(buffer);
  refresh = true;
  
  Serial.print("Set freq - ");
  Serial.println(freq);
}

void loop()
{
#if _AD9851_SOL1
  if (refresh)
  {
    sendFrequency(freq);
    delay(2);
    refresh = false;
  }
#endif
}

