#include <FlexiTimer2.h>
#include <DHT.h>
#include "def.h"

#define DEL_MOVIE 250

DHT dht(11, DHT11); // датчик подключён к pin11

byte SCR[3];
byte seg[7] = {1, 2, 3, 4, 5, 6, 7};
//     segment A  B  C  D  E  F  G
byte cat[3] = {8, 9, 10};
//      catode 1  2  3

void setup() {
  for(byte i=0; i<7; i++) {
      pinMode(seg[i],OUTPUT); digitalWrite(seg[i],LOW);
    }
  for(byte i=0; i<3; i++) {
      pinMode(cat[i],OUTPUT); digitalWrite(cat[i],HIGH);
    }
  dht.begin();
  FlexiTimer2::set(5, ind);
  FlexiTimer2::start();
}

void loop() {
  byte h = dht.readHumidity();
  byte t = dht.readTemperature();
  if (!t && !h) no_dht(); 
  else {tmp(t); hmd(h);}  
}

void tmp(byte t) {
  shift(DASH); delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift(15);   delay(DEL_MOVIE);
  shift(16);   delay(DEL_MOVIE);
  shift(17);   delay(1500);
  shift(DASH); delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift((t/10)%10); delay(DEL_MOVIE);
  shift(t%10);      delay(DEL_MOVIE);
  shift(DEGRE);     delay(4000);
}

void hmd(byte h) {
  shift(DASH); delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift(14);   delay(DEL_MOVIE);
  shift(16);   delay(DEL_MOVIE);
  shift(13);   delay(1500);
  shift(DASH); delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift((h/10)%10); delay(DEL_MOVIE);
  shift(h%10);
  SCR[0] = 0;       delay(4000);  
}

void no_dht(void) {
  shift(DASH); delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift(11);   delay(DEL_MOVIE);
  shift(12);   delay(DEL_MOVIE);
  shift(DASH); delay(DEL_MOVIE);
  shift(13);   delay(DEL_MOVIE);
  shift(14);   delay(DEL_MOVIE);
  shift(15);   delay(DEL_MOVIE);
}

void shift(byte i) {
  SCR[0] = SCR[1];
  SCR[1] = SCR[2];
  SCR[2] = DIG_LED[i];
}

void ind(void) {
  static byte pos = 0;
  for(byte i=0; i<3; i++) digitalWrite(cat[i], HIGH);
  for(byte i=0; i<7; i++) digitalWrite(seg[i], SCR[pos] & 1<<i ? HIGH : LOW);
  digitalWrite(cat[pos], LOW);
  if(++pos == 3) pos = 0;
}
