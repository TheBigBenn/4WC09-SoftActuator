#ifndef _CONTROL_H_
#define _CONTROL_H_

#define STATEDIM 2   
#define DECIMEL 4    
#define ParseMsgT -1
#define ParseMsgY0 0
#define ParseMsgY1 1
#define ParseMsgY2 2
#define ParseMsgU0 3
#define ParseMsgU1 4
#define ParseMsgU2 5

class Control 
{
  public:
    //unsigned long CycleCount = 0;
    float eps = 0.0001;
    bool runActive = false;
    float dt = 0.0;
    float t = 0.0;
    float Kp = 20;
    float Ki = 1;
    float Kd = 0.0001;

    float Y0[STATEDIM]={2.5, 0}; 
    float Y[STATEDIM]={0, 0}; 
    float U[STATEDIM]={0, 0}; 
    float Ytmp[STATEDIM];           
    float K1[STATEDIM], K2[STATEDIM], K3[STATEDIM], K4[STATEDIM];

    void beginControl();
    void controlProcess();
    bool getControlProcessStatus();
    void updateTime();
    void setUpdateRateControl(float tmp);
    void setActive(bool tmp);

    void setGain(float kp, float ki, float kd);
    void setKp(float tmp);
    void setKi(float tmp);
    void setKd(float tmp);

    void StateSpace(float t, float Y[], float Y_p[]);
    void initStateSpace();
    void updateStateSpace();
    void showStates();
    void showControllerTime();

    void parseDataControl(int msg, float data);
    float getDataControl(int msg);
};

#endif
