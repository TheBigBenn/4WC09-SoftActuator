#include "HX711.h"
#include "Ticker.h"
#include "PID_v1.h"
#include "FilterOnePole.h"

FilterOnePole Lp( LOWPASS, 1 );   // create a one pole (RC) lowpass filter

void LoopFixedRate();       
const int MosfetPin   = 5;
const int SampleRate  = 25000;

double y1, y2, y3;                                                                                                                                                          
double u1, u2, u3;      
double Error;

double Peak = 30000;
double Setpoint = 0;
double y = Peak;
double Input, Output, PWMOutput, FFOutput, FFCorrection, dP, LastPoint;
bool Step = true;

double N = 0;
double Time;
double z;
HX711 scale(A1, A0);

//Specify the links and initial tuning parameters
double Kp = 0.00015249 * 3.5 * 1.2, Ki = 0.00046323 / (2.2 * 0.8), Kd = 1.5 * 6 * 4.0088e-6;
PID myPID(&Input, &Output, &Setpoint, Kp, Ki, Kd, DIRECT);

Ticker timer(LoopFixedRate, SampleRate, 0, MICROS_MICROS);

void setup() {
  Serial.begin(115200);
  pinMode(MosfetPin, OUTPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  scale.set_scale(220.f);
  delay(5000);
  scale.tare();
  Input = scale.get_units();
  timer.start();
  myPID.SetMode(AUTOMATIC);
  ResultWrite();
}

void LoopFixedRate() {
  //Time calculation
  Time = N * 1 / 40;

  //Type of signal
  if (Step == false) {
    // Setpoint Sine
    LastPoint = Setpoint;                                       
    Setpoint = y / 2 * ((sin(Time) + sin(Time * 2) + sin(3 * Time)) / 3) + y / 2;
  }
  else {
    if (Time >= 5) {
      LastPoint = Setpoint;
      Setpoint = Peak;
    }
  }

  //Feed forward
  dP = (Setpoint - LastPoint) / 0.025;
  FFOutput = Setpoint * 7.5924e-5;

  if (FFOutput <= 0) {
    FFCorrection = 0;
  }
  else {
    if (FFOutput <= 0.6773) {
      FFCorrection =  1.032295606 * sqrt(FFOutput) + 1.35;
    }
    else {
      FFCorrection = (1 / 2.375) * FFOutput + 1.9149;
    }
  }
  if (dP <= 0) {
    FFCorrection = 0;
  }
  else {
    FFCorrection = FFCorrection * dP / 30000;
  }

  // PID Control
  Input = scale.get_units();
  Error = Setpoint - Input;
  myPID.Compute();

  // Combine PID Output en FF Output
  Output = Output + FFCorrection;                                                   

  // PWM Convert and saturation incorporation
  if (Output <= 0) {                                                                      
    Output = 0;
  }
  else {
    if (Output <= 0.5868) {
      PWMOutput = sqrt(Output / 0.000163);
    }
    else {
      if (Output <= 5) {
        PWMOutput = (Output + 0.6901) / 0.02128205128205128205128205128205;
        if (PWMOutput >= 255) {
          PWMOutput = 255;
        }
      }
      else {
        if (Output > 5) {
          PWMOutput = 255;
        }
      }
    }
  }
  //Implementation low pass
  Lp.input(PWMOutput);

  // Write to Mosfet
  analogWrite(MosfetPin, Lp.output());           // vary between 0  and 255
  N++;
  //Write new values
  ResultWrite();
}
//Function for a timer
void loop() {
  timer.update();
}

//Function for plotting
void ResultWrite() {
  Serial.print(N);
  Serial.print("\t");
  Serial.print(Setpoint);
  Serial.print("\t");
  Serial.println(Input);
}
