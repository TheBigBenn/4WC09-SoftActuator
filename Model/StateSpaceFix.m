clear all; close all;
%% Variables
dt = 0.0001;
tstart = 1;
tend = 10;

Vinit = 0;
Vend = 1.5;
Vs = 1.3;
Period = 25;              %Length of measurement
Freq = 1;                 %Base frequency
Vboundupper = 5;          %Upper motor saturation voltage  
Vboundlower = 0;          %Lower motor saturation voltage

Z = 1.553807*10^(-6);     %Mass inflow component
gamma = 1.4811e-09;       %Gamma for Tank and Actuator

P = 0.00015249;             %P Action  
I = 0.00046323;             %I Action
Dc = (4.0088e-6)*2;         %D Action
N = 8.8595;                 %Filtering Coefficient

Pend = 30000;               %Highest possible pressure

Res = 10;                   %Armature Motor Resistance
L = 0.509;                  %Motor Inductance 
Rg = 287.058;               %Specific gas constant air
T = 293.15;                 %Absolute temperature
Bm = 8.6457e-06;            %Motor friction coefficient
F = 1.3447e-07;             %Counter torque coefficient
Jm = 3.0991e-09;            %Inertia Motor
RatedRatio = 0.0049254;     %Ratio between tau0 and Vr
tau0 = RatedRatio;          %Blocked rotor torque at a rated voltage
Vr = 1;                     %Rated Voltage

%V0 = 1.31997174781e-5;      %Starting Volume Act
V0 = 7.658796956e-5;        %Volume both
%V0 =  6.61532995599999e-05; %Volume Tank

%% Calculating system matrices
init = [0 ;0 ;0];
A = [-gamma*Rg*T/V0  0                   Z;                  %Mass
     0               -Res/L              -Res*tau0/(L*Vr);   %Current
     -(F/Jm)*(Rg*T/V0)   Res*tau0/(Jm*Vr)    -Bm/Jm;] ;      %Omega
B = [0; 1/L; 0];
C = [Rg*T/V0 0 0];
D = 0;

eigenvalues = eig(A);

%% Running the model and modelling the response
sim('Model2');
figure(1)
hold on
plot(Sig, '--')
plot(Req)
xlabel('Time (s)');
ylabel('Pressure difference (Pa)');
legend('Signal', 'Response')
hold off

figure(2)
zerot = [0 0];
trange = [0 tend];
x = -1226;
y = 213.9;
upperbound = [y y];
lowerbound = [x x];
hold on
plot(Error)
plot(trange, zerot, '--')
plot(trange, [upperbound', lowerbound'], '--r')
title('Error')
xlabel('Time (s)')
ylabel('Error (Pa)')
hold off
legend('Error', 'Zero line', 'Bounds')