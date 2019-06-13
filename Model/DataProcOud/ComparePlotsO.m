function [Tplot, Pplot] = ComparePlots(FileName, Div, margin)
%% Variables
addpath('Data');
addpath('Data/Verwerkt');

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
end