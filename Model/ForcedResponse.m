clear all; close all;

dt = 0.0001;
tstart = 1;
tend = 10;
Vinit = 0;
Vend = 1.5;
Vs = 1.3;
Period = 25;
Freq = 2;

Vboundupper = 5;
Vboundlower = 0;

Z = 1.553807*10^(-6);     %Mass inflow component
% gamma = 8.9133e-10;       %Old Gamma Act
gamma = 1.4811e-09;         %Gamma for Tank and Actuator

P = 0.00015249;
I = 0.00046323;
Dc = (4.0088e-6)*2;
N = 8.8595;

Pend = 20000;

Res = 10;   %Armature Motor Resistance
L = 0.509;  %Motor Inductance 


Rg = 287.058;   %Specific gas constant air
T = 293.15;     %Absolute temperature

%V0 = 1.3199717478164160156616666324604e-5;         %Starting Volume Act
V0 = 7.658796956e-5;                               %Volume both
%V0 =  6.615329955999999e-05;                        %Volume Tank
    

    Bm = 8.6457e-06;
    F = 1.3447e-07;
    Jm = 3.0991e-09;
    RatedRatio = 0.0049254;
    
 tau0 = RatedRatio;
 Vr = 1;




init = [0 ;0 ;0];
A = [-gamma*Rg*T/V0  0                   Z;                      %Mass
     0               -Res/L              -Res*tau0/(L*Vr);       %Current
     -(F/Jm)*(Rg*T/V0)   Res*tau0/(Jm*Vr)    -Bm/Jm;] ;              %Omega

B = [0; 1/L; 0];
C = [Rg*T/V0 0 0];
%C = [0 1 0];

D = 0;

eigenvalues = eig(A);


s = tf('s');
Im = [1 0 0;
    0 1 0;
    0 0 1];
Inv = (s*Im - A)^-1*B;
Gs = C*Inv;
FF = 1/Gs;
FFd = c2d(FF,1/40, 'tustin');


Cm = [B, A*B, (A^2)*B]
At = A'
Ct = C'

Om = [Ct, At*Ct, (At^2)*Ct]


%syms t

%x(t) = exp(A*t)*integral(exp(-A*tau),0,t)

