function y = Vmin(V)
z = 15000;
if V >= 1.1
elseif V<1.1
    V = 0;
elseif V<-1.1
    V = -V;
end

if V >= 1.35
if V<= 2.2
        V = z*(V-1.35)^2;
        if V < 0
            V = 0;
        end
elseif V<= 5
        x = 38000;
        V = x*V - x*2.2 + z*(2.2-1.35)^2;
end
end
V = V *(5/80000);
y = V;
