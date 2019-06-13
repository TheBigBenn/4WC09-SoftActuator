close all; clear all;
PWM = [0:10:250 255]';
Vin = 5.00;

Vout = [0    0    0    0    0   ;
        0.03 0.03 0.03 0.03 0.03;
        0.09 0.09 0.09 0.09 0.09;
        0.16 0.16 0.16 0.16 0.16;
        0.25 0.25 0.25 0.25 0.25;
        0.40 0.40 0.40 0.40 0.40;
        0.60 0.60 0.59 0.59 0.59;
        0.81 0.80 0.80 0.79 0.80;
        1.01 1.00 1.00 1.00 0.99;
        1.25 1.21 1.24 1.24 1.21;
        1.47 1.47 1.47 1.47 1.46;
        1.70 1.68 1.68 1.68 1.68;
        1.90 1.90 1.90 1.90 1.90;
        2.12 2.11 2.12 2.12 2.12;
        2.34 2.33 2.33 2.33 2.33;
        2.54 2.54 2.55 2.54 2.53;
        2.75 2.75 2.75 2.74 2.74;
        2.97 2.95 2.96 2.95 2.95;
        3.18 3.16 3.16 3.17 3.16;
        3.40 3.37 3.38 3.38 3.38;
        3.61 3.59 3.59 3.59 3.58;
        3.82 3.80 3.81 3.80 3.79;
        4.03 4.01 4.00 4.00 4.00;
        4.25 4.21 4.22 4.22 4.22;
        4.43 4.43 4.43 4.43 4.43;
        4.67 4.64 4.64 4.64 4.63;
        4.77 4.75 4.74 4.75 4.75];
    
    PWMAct = [0:1:255]';
    Vexp = zeros(length(PWMAct), 1);
    for k = 1:length(PWMAct)
        Vexp(k) = (Vin/255)*PWMAct(k);
    end
    figure(1)
    hold on
   plot((PWMAct/255)*100, Vexp);
    
    PWMAct = [0:1:255]';
    Vfit = zeros(length(PWMAct),1);
    for k = 1:length(PWMAct)
        if PWMAct(k) <= 60
            Vfit(k) = 0.000163*PWMAct(k).^2;
        else
            Vfit(k) = 0.02128205128205128205128205128205*PWMAct(k)- 0.02128205128205128205128205128205*PWMAct(61)+Vfit(61);
        end
    end
    plot ((PWMAct/255)*100, Vfit);
    
    for i = 1:size(Vout,2)
       scatter((PWM/255)*100, Vout(:,i)) 
    end
    xlabel('Duty Cycle (%)')
    ylabel('Output Voltage (V)')
    hold off
    
    legend('Expected Voltage', 'Fitted Voltage Curve', 'Measured Voltage', 'Location','Southeast')
    %legend('Expected Voltage', 'Measured Voltage', 'Location','Southeast')
   
    Vdiffit = zeros(length(PWMAct),1);
    Vdifreal = zeros(length(PWM),1);
    Vexps = zeros(length(PWM), 1);
    for k = 1:length(PWM)
        Vexps(k) = (Vin/255)*PWM(k);
        Vdifreal(k) = Vexps(k) - mean(Vout(k,:));
    end
    
    for k = 1:length(PWMAct)
        Vdiffit(k) = Vexp(k) - Vfit(k);
    end
    figure(2)
    hold on
    plot((PWMAct/255)*100, Vdiffit);
    plot((PWM/255)*100, Vdifreal)
    legend('Difference for fitted curve', 'Difference for measured points')
    xlabel('Duty Cycle (%)')
    ylabel('Difference in voltage (V)')
    hold off
    Verror = zeros(length(PWM), 1);
    for k = 1:length(PWM)
        if PWM(k) <= 60
            Vfit2(k) = 0.000163*PWM(k).^2;
            Verror(k) = mean(Vout(k,:)) - Vfit2(k);
        else
            Vfit2(k) = 0.02128205128205128205128205128205*PWM(k)- 0.02128205128205128205128205128205*61+0.000163*61.^2;
            Verror(k) = mean(Vout(k,:)) - Vfit2(k);
        end
    end
    
    figure(3)
    plot((PWM/255)*100, Verror)
    xlabel('Duty Cycle (%)')
    ylabel('Difference in voltage (V)')
    legend('Error between measurements and fitted curve', 'Location', 'Southeast')