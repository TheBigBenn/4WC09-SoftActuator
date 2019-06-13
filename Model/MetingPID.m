clear all; close all;
%% Variables
addpath('Data');
addpath('Data/Verwerkt');
FileName = '30000PaFF.txt';
Div = 0.1;
Tsignal = 15.75;
margin = 5;
SampleRate = 0.025;

%% Read data and convert to 1x2 cell 
fileID = fopen(FileName);
formatSpec = '%f %f %f';
Data = textscan(fileID, formatSpec);
fclose(fileID);
%% Convert cell to arrays
Time = zeros(length(Data),1);
TimeCell = Data{(1)};
Signal = Data{1,2};
Pressure = Data{1,3};

%% Convert Duration to seconds
for i = 1:length(TimeCell)
   Time(i) = TimeCell(i)*SampleRate; 
end
Time = Time - Time(1);
%% Plot
figure(1)
title('Response for 30000 Pa')
xlabel('Time (s)');
ylabel('Pressure difference (Pa)');
xlim([0 max(Time)]);
ylim([-500 1.3*max(Pressure)]);
hold on
plot(Time, Signal, '--');
plot(Time, Pressure);
hold off
legend('Signal', 'Response')


% figure(2)
% zerot = [0 0];
% trange = [0 Time(length(Time))];
% x = -3411;
% y = 3754;
% upperbound = [y y];
% lowerbound = [x x];
% hold on
% plot(Time, Signal - Pressure)
% plot(trange, zerot, '--')
% plot(trange, [upperbound', lowerbound'], '--r')
% xlabel('Time (s)')
% ylabel('Error (Pa)')
% hold off
% legend('Error without tank','Error with normal tank','Error with large tank')

%% Save plot
 plotname = split(FileName, '.');
 print(['Verwerkt\' plotname{1,1}], '-depsc')