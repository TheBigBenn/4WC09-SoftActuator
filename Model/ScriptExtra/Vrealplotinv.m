close all; clear all;
PWM = [0:10:250 255]';
    PWMAct = [0:1:255]';
    Vexp = zeros(length(PWMAct), 1);
    
    figure(1)
    hold on
    PWMAct = [0:1:255]';
    Vfit = zeros(length(PWMAct),1);
    for k = 1:length(PWMAct)
        if PWMAct(k) <= 60
            Vfit(k) = 0.000163*PWMAct(k).^2;
        else
            Vfit(k) = 0.02128205128205128205128205128205*PWMAct(k)- 0.02128205128205128205128205128205*PWMAct(61)+Vfit(61);
        end
    end
    Vin = [-0.5:0.01:5];
    CalcPWM = zeros(length(Vin),1);
    
    for k = 1:length(Vin)
        if Vin(k)<=0
            CalcPWM(k) = 0;
        elseif Vin(k) <= 0.5868
            CalcPWM(k) = sqrt(Vin(k)/0.000163);
        elseif Vin(k) <= 5
            CalcPWM(k) = (Vin(k) + 0.6901)/0.02128205128205128205128205128205;
            if CalcPWM(k) >= 255
                CalcPWM(k) = 255;
            end
        elseif Vin(k) > 5
                CalcPWM(k) = 255;
        end
    end
    plot(Vfit, (PWMAct/255)*100);
    plot(Vin, (CalcPWM/255)*100);
    xlim([-0.5 5])
    legend('Original Fit with changed axes', 'New calculated fit', 'Location', 'Southeast')
    xlabel('Voltage (V)')
    ylabel('Duty Cycle (%)')
    hold off
    
  