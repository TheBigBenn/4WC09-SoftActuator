clear all; close all


[T1, P1] = ComparePlots('272VAct.txt', 0.01, 10);
[T2, P2] = ComparePlots('272VTank.txt', 0.01, 5);
[T3, P3] = ComparePlots('272VTankAct.txt', 0.01, 5);

figure()
hold on
plot(T1, P1)
plot(T2, P2)
plot(T3, P3)

xlabel('Time (s)')
ylabel('Pressure Difference (Pa)')

legend('Soft actuator', 'Air tank', 'Air tank and soft actuator', 'Location', 'Southeast')