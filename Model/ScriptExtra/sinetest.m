t = [0:0.01:10];
for i = 1:length(t)
    y = 10000/2*(sin(t)+sin(2*t - 1)+sin(3*t+2.3))/3 + 5000;
end
plot(t, y)