close all; clear all;
%% Variables
addpath('Data');
addpath('Data/Verwerkt');
FileName = '32V.txt';
Div = 0.1;
Tsignal = 15.75;
margin = 5;


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

while l == 0
    for i = k:length(Time)
        if Pressure(i,1)<= Pstart + margin
            if Time(i,1)-Time(k,1) >= Tsignal
            l = i;
            break
            end
        end
    end
end

%% Set up new Vectors
Start = k - 5;
End   = l + 5;
Pplot = Pressure(Start:End);
Tplot = Time(Start:End) - Time(Start,1);

%% Setup Step function
Step = zeros(length(Tplot),1);
for i = 1:length(Tplot)
    Step(i) = Pplot(1);
    if i >= k-Start+1
        if Tplot(i) - Tplot(k-Start+1) <= Tsignal  
         %if i <= length(Tplot) -11
            Step(i) = max(Pplot);
        end
    end
end

%% Recover Voltage signal
SplitName = split(FileName, 'V');

V = Div*str2double(SplitName{1,1});
SignalMessage = ['Signal (' num2str(V) 'V)'];
Figurename = ['Response for ' num2str(V) 'V'];
%% Plot
figure('Name', Figurename)
xlabel('Time (s)');
ylabel('Pressure difference (Pa)');
xlim([0 Tplot(length(Tplot),1)]);
ylim([-500 1.3*max(Pplot)]);
hold on
plot(Tplot, Step, '--');
plot(Tplot, Pplot);
legend(SignalMessage, 'Pressure Response');
max(Pplot)
%% Save plot
plotname = split(FileName, '.');
print(['Verwerkt\' plotname{1,1}], '-depsc')