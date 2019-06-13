clear all; close all; 
%% Variables
addpath('Data');
addpath('Data/Verwerkt');
FileName = '256VTankAct3.txt';
Div = 0.01;
Tsignal = 15;
margin = 10;
Period = 20.9;

%% Read data and convert to 1x2 cell 
fileID = fopen(FileName);
formatSpec = '%{hh:mm:ss.SSS}T %f';
Data = textscan(fileID, formatSpec);
fclose(fileID);
%% Convert cell to arrays
Time = zeros(length(Data),1);
TimeCell = Data{(1)};
Pressure = Data{1,2};

%% Convert Duration to seconds
for i = 1:length(TimeCell)
   Time(i) = seconds(TimeCell(i,1)); 
end

%% Determine start of plot
Pstart = Pressure(1,1);
k = 0;
l = 0;
while k == 0
    for i = 1:length(Time)
        if Pressure(i,1) >= Pstart + margin
            k = i; 
            break
        end
    end
end

% while l == 0
%     for i = k:length(Time)
%         if Pressure(i,1)<= Pstart + margin
%             if Time(i,1)-Time(k,1) >= Tsignal
%             l = i;
%             break
%             end
%         end
%     end
% end

% while l == 0
%     for i = k:length(Time)
%         if Time(i,1)-Time(k,1) >= Tsignal
%             l = i;
%             break 
%         end
%     end
% end
%% Set up new Vectors
Start = k;
%End   = l + 5;
End = length(Time);
Pplot = Pressure(Start:End) - Pressure(1,1);
Tplot = Time(Start:End) - Time(Start,1);

%% Recover Voltage signal
SplitName = split(FileName, 'V');

V = Div*str2double(SplitName{1,1});

%% Setup Step function
Step = zeros(length(Tplot),1);
for i = 1:length(Tplot)
    if i >= k-Start+1
        if i <= length(Tplot) -11  
            Step(i) = V;
        end
    end
end

%% StateSpace

dt = 0.001;
tstart = Tplot(k-Start+1,1);
tend = Tplot(length(Tplot),1);
Vinit = 0;
Vend = V;
Vs = 1.3;

Z = 1.553807*10^(-6);     %Mass inflow component
% gamma = 8.9133e-10;       %Old Gamma Act
gamma = 1.4811e-09;         %Gamma for Tank and Actuator

Res = 10;   %Armature Motor Resistance
L = 0.509;  %Motor Inductance 


Rg = 287.058;   %Specific gas constant air
T = 293.15;     %Absolute temperature

%V0 = 1.3199717478164160156616666324604e-5;         %Starting Volume Act
V0 = 7.658796956e-5;                               %Volume both
%V0 =  6.615329955999999e-05;                        %Volume Tank


    Bm = 0.00024882
    F = 2.6812e-07
    Jm = 9.2078e-07
    Vr = 122.93
    tau0 = 2.075


%% Setting up matrices    
    
init = [0 ;0 ;0];
A = [-gamma*Rg*T/V0     0                   Z;                      %Mass
     0                  -Res/L              -Res*tau0/(L*Vr);       %Current
     -(F/Jm)*(Rg*T/V0)  Res*tau0/(Jm*Vr)    -Bm/Jm;] ;              %Omega

B = [0; 1/L; 0];
C = [Rg*T/V0 0 0];
D = 0;
eigenvalues = eig(A)

%% Plot
sim('Model2');
hold on
plot(Tplot, Pplot)
plot(Req)
hold off
xlabel('Time (s)');
ylabel('Pressure difference (Pa)');
legend('Measurements', 'Model', 'Location', 'Southeast')
