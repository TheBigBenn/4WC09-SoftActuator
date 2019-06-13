#include "HX711.h"
#include "Ticker.h"

void LoopFixedRate();
//void LoopFixedRate2();
const int MosfetPin   = 5;
const int SampleRate  = 25000; //40Hz
int OutputS = 0;
int Time = -30;
int Cycle = 0;
//int Goal = 111.5;
int Goal = 180;
long N;
int CycleTime = 400;
//const int SampleRate2 = 10000; //100Hz
bool LedState = false;

HX711 scale(A1, A0);

Ticker timer(LoopFixedRate, SampleRate, 0, MICROS_MICROS);
//Ticker timer2(LoopFixedRate2, SampleRate2, 0, MICROS_MICROS);
void setup() {
  Serial.begin(115200);
  pinMode(MosfetPin, OUTPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  scale.set_scale(220.f);
  delay(2000);
  scale.tare();
  timer.start();
  // timer2.start();
}
//scale.get_units(), 1
void LoopFixedRate() {
  Serial.print(N);
  Serial.print("\t");
  Serial.println(scale.get_units(), 1); // Pressure in kPa

  if (Time == 0) {
    if (OutputS == Goal) {
      OutputS = 0;
      LedState = !LedState;
      analogWrite(MosfetPin, OutputS);
      digitalWrite(LED_BUILTIN, LedState);
    }
    else {
      if (OutputS == 0) {
        OutputS = Goal;
        LedState = !LedState;
        analogWrite(MosfetPin, OutputS);
        digitalWrite(LED_BUILTIN, LedState);
      }
    }
  }
  Time++;
  if (Time >= CycleTime) {
    Time = 0;
  }
  N++;
}

//120

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
