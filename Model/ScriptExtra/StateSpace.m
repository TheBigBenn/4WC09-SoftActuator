close all; clear all;

dt = 0.1;
tend = 1000000;

Z = 1.553807*10^(-6);     %Mass inflow component
R = 0.0001;                %Theoretical radius
gamma = pi*R^4/(8*1.802*10^(-5)*0.003); %Mass outflow component

Res = 1;   %Armature Motor Resistance
L = 0.1;     %Armature Inductance
tau0 = 0.01;  %Blocked rotor torque
Vr = 12;    %At rated voltage

Rg = 287.058;   %Specific gas constant air
T = 293.15;     %Absolute temperature
V0 = 1;         %Starting temperature

Bm = 0.1;         %Coefficient of motor friction
Jm = 1*10^(-1);         %Actuator Inertia
F = 10*10^(-6);          %Counter Torque constant (dP)

init = [0; 0 ;0 ;0];
A = [0      -gamma  0                   Z;
    Rg*T/V0 0       0                   0;
    0       0       -Res/L              -Res*tau0/(L*Vr);
    0       -F/Jm   Res*tau0/(Jm*Vr)    -Bm/Jm;] ;

B = [0; 0; 1/L; 0];
C = [0 1 0 0];
D = 0;
eigenvalues = eig(A)
sim('Model2');
figure(2)
cla;
plot(P)
%{'mass', 'deltapressure',  'current', 'rotationalvelocity'}
