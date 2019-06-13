close all; clear all;
Vin =   [0;
        0.02;
        0.07;
        0.15;
        0.24;
        0.36;
        0.55;
        0.75;
        0.93;
        1.17;
        1.28;
        1.39;
        1.52;
        1.61;
        1.73;
        1.82;
        1.94;
        2.03;
        2.15;
        2.23;
        2.35;
        2.43;
        2.54;
        2.61;
        2.74;
        2.81;
        2.94;
        3.01;
        3.14;
        3.22;
        3.43;
        3.64;
        3.83;
        4.05;
        4.25;
        4.45;
        4.57];
Pout =  [0; 
        0;
        3;
        4;
        6;
        6;
        7;
        7;
        7;
        100;
        150;
        500;
        800;
        1200;
        2250;
        3200;
        5100;
        6500;
        9600;
        11000;
        15000;
        18000;
        23400;
        27000;
        30400;
        34400;
        36250;
        41000;
        41640;
        41640;
        41640;
        41640;
        41640;
        41640;
        41640;
        41640;
        41640];
    
    Vinput = [0:0.01:3.3]';
    Pfit = zeros(length(Vinput),1);
    Pfit2 = zeros(length(Vinput),1);
    
    vExtra = [1.83;
              1.94;
              2.05;
              2.14;
              2.25;
              2.35;
              2.43;
              2.58;
              2.74;
              2.81;
              2.94;
              3.03];
          pextra = [2500;
                    4663;
                    6763;
                    8617;
                    10320;
                    14140;
                    17080;
                    20350;
                    26770;
                    30590;
                    34790;
                    37400];
                    
              
    
    
   for i = 1:length(Vinput)
    if Vinput(i) <= 1.1
       Pfit(i) = 0;
        j = i;
    elseif Vinput(i)<= 2.2
        Pfit(i) = 9900*(Vinput(i)-Vinput(j+15))^2;
        k = i;
    elseif Vinput(i)<= 5.0
        x = 37000;
        Pfit(i) = x*Vinput(i) - x*Vinput(k)+Pfit(k);
%         if Pfit(i) > 41640
%             Pfit(i) = 41640;
%         end
%     else
%         Pfit(i) = 41640;
    end
   end

   
V = [0:0.01:5];
V2 = V;
Vin1 = V;
       %% Robustness LAR
    
       p1 =    0.001971;
       p2 =     -0.0458;
       p3 =      0.4358;
       p4 =      -2.163;
       p5 =       5.875;
       p6 =      -8.336;
       p7 =       5.729;
       p8 =      -1.615;
       p9 =      0.1197;

for i = 1:length(V2)
  V2(i) = p1*V2(i)^8 + p2*V2(i)^7 + p3*V2(i)^6 + p4*V2(i)^5 + p5*V2(i)^4 + p6*V2(i)^3 + p7*V2(i)^2 + p8*V2(i) + p9;
  
end
   
   figure(1)
    hold on
    xlabel('Voltage (V)')
    ylabel('Pressure difference (Pa)')
    plot(Vinput, Pfit);
    scatter(Vin, Pout)
    scatter(vExtra, pextra);
    plot(Vin1, 80000*V2/5);
    ylim([0 42000])
    
    %legend('Fitted Curve','Measured PWM response', 'Recovered Pressure peaks', 'Location', 'Southeast')