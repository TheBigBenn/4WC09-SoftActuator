#include "SORO.h"
#include "Control.h"
#include <math.h>
//#include "Signals.h"

////////////////////////////////////////////////////////////////////////
void Control::beginControl(){
  initStateSpace();
}

////////////////////////////////////////////////////////////////////////
void Control::setActive(bool tmp){
  runActive = tmp;
}

////////////////////////////////////////////////////////////////////////

void Control::controlProcess(){
  if(runActive){
    updateTime();         // update time t =+ dt
    updateStateSpace();   // update the state space
  }
  else{
    initStateSpace();     // reset the state space
  }
}

////////////////////////////////////////////////////////////////////////
bool Control::getControlProcessStatus(){
  return runActive;
}

////////////////////////////////////////////////////////////////////////
void Control::StateSpace(float t, float Y[], float Y_p[]){

  // ODE parameters:
  const double mu=.01;
  
  Y_p[0] = Y[1];
  Y_p[1] = mu*(1-Y[0]*Y[0])*Y[1] - Y[0];
}

////////////////////////////////////////////////////////////////////////
void Control::initStateSpace(){
  for (int i=0; i<STATEDIM; i++) {
    Y[i] = Y0[i];
    U[i] = 0;
  }
  t = 0;
}

////////////////////////////////////////////////////////////////////////
void Control::updateStateSpace(){

  StateSpace(t, Y, K1);
  for (int i=0; i<STATEDIM; i++) {
    Ytmp[i] = Y[i] + K1[i]*dt*0.5;
  }
  
  StateSpace(t + dt*0.5, Ytmp, K2);
  for (int i=0; i<STATEDIM; i++) {
    Ytmp[i] = Y[i] + K2[i]*dt*0.5;
  }
  
  StateSpace(t + dt*0.5, Ytmp, K3);
  for (int i=0; i<STATEDIM; i++) {
    Ytmp[i] = Y[i] + K3[i]*dt;
  }
  
  StateSpace(t + dt, Ytmp, K4);
  for (int i=0; i<STATEDIM; i++) {
    Y[i] = Y[i] + dt / 6.0 * (K1[i] + 2.0*(K2[i] + K3[i]) + K4[i]);
  }
}

////////////////////////////////////////////////////////////////////////
void Control::updateTime(){
  t += dt;
}

////////////////////////////////////////////////////////////////////////
void Control::setUpdateRateControl(float tmp){
  dt = tmp*1e-6;
}

////////////////////////////////////////////////////////////////////////
void Control::setGain(float kp, float ki, float kd){
  //Serial.println("//SRM: setting control gains ");
  
  if(fabsf(kp) > eps){
    setKp(kp);
    setKi(ki);
    setKd(kd);
  }
  else{
    
  }
}

////////////////////////////////////////////////////////////////////////
void Control::setKp(float tmp){
    Kp = tmp;
}

////////////////////////////////////////////////////////////////////////
void Control::setKi(float tmp){
    Ki = tmp;
}

////////////////////////////////////////////////////////////////////////
void Control::setKd(float tmp){
    Kd = tmp;
}

////////////////////////////////////////////////////////////////////////
void Control::showStates(){
  for(int i = 0; i < STATEDIM; i++){
   Console.print(Y[i],DECIMEL);
   Console.print("\t");
  }
}

////////////////////////////////////////////////////////////////////////
void Control::showControllerTime(){
  float freq = 5;
  Console.print(t,DECIMEL);
  Console.print("\t");
  //Console.print(( 2*(1.0/(1.0 + exp(-freq*t)) - 0.5 ) )*sin(2*PI*freq*t),DECIMEL);
}
////////////////////////////////////////////////////////////////////////
void Control::parseDataControl(int msg, float data){
  //if(msg == ParseMsgY0){Y[0] = data;}
  if(msg == ParseMsgY0){Y[0] = data;}
  if(msg == ParseMsgY1){Y[1] = data;}
  if(msg == ParseMsgY2){Y[2] = data;}
  if(msg == ParseMsgU0){U[0] = data;}
  if(msg == ParseMsgU1){U[1] = data;}
  if(msg == ParseMsgU2){U[2] = data;}
}

////////////////////////////////////////////////////////////////////////
float Control::getDataControl(int msg){
  if(msg == ParseMsgY0){return Y[0];}
  if(msg == ParseMsgY1){return Y[1];}
  if(msg == ParseMsgY2){return Y[2];}
  if(msg == ParseMsgU0){return U[0];}
  if(msg == ParseMsgU1){return U[1];}
  if(msg == ParseMsgU2){return U[2];}
  if(msg == ParseMsgT){return t;}
}
