 clear all; close all;
%% Variables
addpath('Data');
FileName = '230VTankAct.txt';
Div = 0.1;

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