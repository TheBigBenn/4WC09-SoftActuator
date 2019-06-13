clear all; close all


[T1, P1] = ComparePlotsN('286VActS2.txt', 0.01, 30);
[T2, P2] = ComparePlotsN('286VTankActS1.txt', 0.01, 5);
%[T3, P3] = ComparePlotsN('272VTankAct.txt', 0.01, 5);

figure()
hold on
plot(T1, P1)
plot(T2, P2)
%plot(T3, P3)

xlabel('Time (s)')
ylabel('Pressure Difference (Pa)')

%legend('Soft actuator', 'Air tank', 'Air tank and soft actuator', 'Location', 'Southeast')
legend('Soft actuator','Combined system','Location', 'Southwest')