clear all, close all
%% Starting values
t = 0;             % Time (s)
V0 = 1;            % Tank Volume (m^3)
R = 8.314472;      % Universal Gasconstant (J/(K*mol))
T = 293.15;        % Temperature (K)
P(1) = 101300;     % Starting Pressure (Pa)
Preq = 105000;     % Target Pressure (Pa)
M = 0.02897;       % Molar Mass (kg/mol)
mv = 0;            % Mass flow (kg/s) 
t_total = 100;      % Total Flow time (s)
t_step = 0.01;     % Time Step (s)
m(1) = 0;          % Starting Mass (kg)
t(1) = 0;          % Starting Time (s)
mvm = 0.01;        % Maximum mass flow velocity (kg/s)
ma = 0.002;        % Mass flow accelaration (kg/s^2)


sim('Model2')


%% Model

for ii = 2:(t_total/t_step)
if P(ii-1) < Preq
if mv < mvm
    mv = mv+ma*t_step;
end
else
    if P(ii-1) > Preq
     if mv > -1*mvm
    mv = mv-ma*t_step;
     end   
    end
end
m(ii) = m(ii-1) + mv * t_step;
P(ii) = P(ii-1)+ (m(ii)-m(ii-1))*R*T/(M*V0);
t(ii) = t(ii-1)+t_step;
end

%% Figures
figure(1)
plot (m, P)
xlabel('Inserted mass (kg)')
ylabel('Total Pressure (Pa)')

figure(2)
plot (t,P)
xlabel('Elapsed time (s)') 
ylabel('Total Pressure (Pa)')

figure(3)
plot (t, m)
xlabel('Elapsed time (s)')
ylabel('Inserted mass (kg)')