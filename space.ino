//Space Helmet . Competición NASAS 2014 SPACEAPPS
#include <SoftwareSerial.h>
int RelayPin =  9;
int RelaySTATE;// The number of Relay pin (8)
int LDRpin=1;
int valorLDR;    //Aquí almacenamos los datos recogidos del LDR:
int tempPin =0;
int temp;
int valorLDR1;
long interval = 1000;  // interval at which to blink (milliseconds)
int i=0;
bool alert = false;

void setup() {
  Serial.begin(9600);
  pinMode(RelayPin, OUTPUT); 
  pinMode(LDRpin, INPUT);
  pinMode(tempPin,INPUT); 

}

void loop()
{
valorLDR = analogRead(LDRpin);
valorLDR1=1025-valorLDR;
temp = analogRead(tempPin);
temp=temp*10/2;
Serial.write(200);
Serial.write(200);
Serial.write(200);
Serial.write(valorLDR1);
Serial.write(temp);
delay(100);
if (valorLDR1 >= 20 && !alert)
  {
  for(i=0;i<20;i++)
    {
    digitalWrite(RelayPin,HIGH);
    delay(250);
    digitalWrite(RelayPin,LOW);
    delay(250); 
    }
  alert = true;
  }
}

