close all; clear all;
%% Variables
addpath('Data');
addpath('Data/Verwerkt');
FileName = 'test.txt';
Div = 0.01;
Tsignal = 15;
margin = 5;
Period = 20;
SampleRate = 0.025;

%% Read data and convert to 1x2 cell 
fileID = fopen(FileName);
formatSpec = '%f %f';
Data = textscan(fileID, formatSpec);
fclose(fileID);
%% Convert cell to arrays
Time = zeros(length(Data),1);
TimeCellF = Data{(1)};
PressureF = Data{1,2};

TimeCell = TimeCellF(2:(length(TimeCellF)-1))-TimeCellF(2);
Pressure = PressureF(2:length(PressureF));
%% Convert Duration to seconds
for i = 1:length(TimeCell)
   Time(i) = TimeCell(i)*SampleRate; 
end

%% Set up new Vectors
Start =600;
%End   = l + 5;
End =800;
Pplot = Pressure(Start:End) - Pressure(1,1);
Tplot = Time(Start:End) - Time(Start,1);

%% Recover Voltage signal
SplitName = split(FileName, 'V');

V = Div*str2double(SplitName{1,1});

%% StateSpace

dt = 0.001;
tstart = 0;
tend = Tplot(length(Tplot),1);
Vinit = 0;
Vend = 0;
Vs = 1.3;

Z = 1.553807*10^(-6);     %Mass inflow component
R = 0.00005;                %Theoretical radius
% gamma = pi*R^4/(8*1.802*10^(-5)*0.003); %Mass outflow component


Res = 10;   %Armature Motor Resistance
L = 0.509;
 
 
Rg = 287.058;   %Specific gas constant air
T = 293.15;     %Absolute temperature
V0 = 7.658796956e-5;         %Starting Volume

%% Params for 2.7 V
     Bm = 0.0040665
    F = 6.3647e-07
    Jm = 0.00030736
    Vr = 5.48
    gamma = 8.9133e-10;
    tau0 = 0.53226
    
    

init = [Pplot(1,1)/(Rg*T/V0) ;0 ;0];
A = [-gamma*Rg*T/V0  0                   Z;                      %Mass
     0               -Res/L              -Res*tau0/(L*Vr);       %Current
     -(F/Jm)*(Rg*T/V0)   Res*tau0/(Jm*Vr)    -Bm/Jm;] ;              %Omega

B = [0; 1/L; 0];
C = [Rg*T/V0 0 0];
D = 0;
eigenvalues = eig(A)
sim('Model2');


plot(Req)
hold on
plot(Tplot, Pplot)
ylabel('Pressure Difference (Pa)')
xlabel('Time (s)')
