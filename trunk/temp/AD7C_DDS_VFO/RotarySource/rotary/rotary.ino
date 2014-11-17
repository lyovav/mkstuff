#include "rotary.impl.h"

Rotary r = Rotary(2, 3);

void setup() {
  Serial.begin(9600);
  PCICR  |= (1 << PCIE2);
  PCMSK2 |= (1 << PCINT23) | (1 << PCINT0);
  sei();
}

void loop() {

}

ISR(PCINT2_vect) 
{
  unsigned char result = r.process();
  if (result) {
    Serial.println(result == DIR_CW ? "Right" : "Left");
  }
}
