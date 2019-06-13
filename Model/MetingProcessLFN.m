 clear all; close all;
%% Variables
addpath('Data');
FileName = 'test.txt';
Div = 0.1;
SampleRate =0.025;

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

%% Recover Voltage signal
SplitName = split(FileName, 'V');
V = Div*str2double(SplitName{1,1});

%% Plot

figure()
hold on
plot(Time, Pressure);
xlabel('Time (s)');
ylabel('Pressure difference (Pa)');
xlim([0 Time(length(Time),1)]);
hold off

%% Save plot
plotname = split(FileName, '.');
print(['Verwerkt\' plotname{1,1}], '-depsc')