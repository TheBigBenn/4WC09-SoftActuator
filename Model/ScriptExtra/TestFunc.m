close all; clear all;

V = [0:0.01:5];
V2 = [-3:0.001:7.327];
Vin2 = V2;
Vin = V;
for i = 1:length(V)
z = 15000;
if V(i) >= 1.1
elseif V(i)<1.1
    V(i) = 0;
elseif V(i)<-1.1
    V(i) = -V;
end

if V(i) >= 1.35
if V(i)<= 2.2
        V(i) = z*(V(i)-1.35)^2;
        if V(i) < 0
            V(i) = 0;
        end
elseif V(i)<= 5
        x = 38000;
        V(i) = x*V(i) - x*2.2 + z*(2.2-1.35)^2;
end
end
V(i) = V(i) *(5/80000);


end      

for i = 1:length(V2)
    if V2(i) <= 0
        V2(i) = 0;
    elseif V2(i) <= 0.6773
        V2(i) =  1.032295606*sqrt(V2(i))+1.35;
    elseif V2(i) <= 7.5
    V2(i) = (1/2.375)*V2(i)+ 1.9149;
    end
end

figure(1)
%plot(Vin, V)
hold on
plot(Vin2, V2)
%plot(V, Vin)
xlabel('Vin(V)')
ylabel('Vout(V)')
xlim([min(Vin2), max(Vin2)]);

