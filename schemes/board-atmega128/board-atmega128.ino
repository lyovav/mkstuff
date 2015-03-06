void setup()
{
  //pinMode(ADC2, INPUT);
  
  Serial.begin(9600);
  Serial.println("Hello Moto!\n");
}

int prevbn = -1;

void loop()
{
  int temp = analogRead(2);
  int bn = temp / 50;
  
  if (prevbn != bn)
  {
    Serial.println(bn);
    prevbn = bn;
  }
}
