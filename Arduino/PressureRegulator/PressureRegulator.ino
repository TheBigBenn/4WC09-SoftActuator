#include "HX711.h"
#include "Ticker.h"

void LoopFixedRate();
//void LoopFixedRate2();
const int MosfetPin   = 5;
const int SampleRate  = 25000; //50Hz
//const int SampleRate2 = 10000; //100Hz
//bool LedState = false;
const int Goal        = 150;
long N = 0;
HX711 scale(A1, A0);

Ticker timer(LoopFixedRate, SampleRate, 0, MICROS_MICROS); 
//Ticker timer2(LoopFixedRate2, SampleRate2, 0, MICROS_MICROS); 

void setup() {
  Serial.begin(115200);
  pinMode(MosfetPin, OUTPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  scale.set_scale(220.f);
  delay(5000);                       
  scale.tare();				       
  timer.start(); 
 // timer2.start();          
}

void LoopFixedRate() {
//  Serial.print(N);
//  Serial.print("\t");
  Serial.println(scale.get_units(), 1); // Pressure in kPa
  analogWrite(MosfetPin,Goal);           // vary between 0  and 255
  N++;


}


//void LoopFixedRate2() {
  //Serial.println(scale.get_units(), 1); // Pressure in kPa
  //analogWrite(MosfetPin,150);           // vary between 0  and 255
  //digitalWrite(LED_BUILTIN, LedState);   // turn the LED on (HIGH is the voltage level)
//  LedState = !LedState;
  //delay(1000);                       // wait for a second
  //delay(1000);  
//}

void loop() {
  timer.update();
//  timer2.update();
}
