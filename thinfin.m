clear all;
clc;

Tl = 60;
Tr = 30;
Ta = 25;
n = 20;
L = 0.1;
dx=L/n;
x = dx/2:dx:L-dx/2;
alpha = 0.001;

t_f = 120;
r = 1000;
dt = t_f/r;

t = 0:dt:t_f;

T = zeros(n,1);
dTdt = zeros(n,1);

k=25;
ro=8050;
C=420;
h=0.024;
p=0.2;
A=0.16;

for j=1:100
    for i = 2:n-1
        dTdt(i) = (k/(ro*C*dx^2))*(T(i-1)+T(i+1)-2*T(i))-(h*p*dx/(ro*C*A))*(T(i)-Ta);
    end
    dTdt(1) = (k/(ro*C*dx^2))*(2*Tl-T(i))-(h*p*dx/(ro*C*A))*(T(i)-Ta);
    dTdt(n) = (k/(ro*C*dx^2))*(2*Tr-T(i))-(h*p*dx/(ro*C*A))*(T(i)-Ta);
    
    T = T + dTdt*dt;
    
    
    
end

  
        
