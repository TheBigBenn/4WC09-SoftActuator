function [Tplot, Pplot] = ComparePlotsN(FileName, Div, margin)
%% Variables
addpath('Data');
addpath('Data/Verwerkt');
SampleRate = 0.025

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
end