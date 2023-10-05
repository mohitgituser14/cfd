clear all
clc
%% Problem Statement

L = 1;
B = 1;
N = 10;
ux = 0.1;%m/s
alpha = 2.1;

dx = L/N;
dy = B/N;

nt = 1000;
dt = 0.001;

x = linspace(0,L,N);  
y = linspace(0,B,N);

err = 5e9;
conv = 1e-4;

%% Boundary Conditions
Th = 90;
Tc = 10;

T = zeros(N);

T(1,1:N) = Tc;
T(1:N,1) = Th;
T(1:N,N) = Th;

%% Iteration

T_o = T;
sol_time = dt;
e=0;
while(e<100)
for k = 1:nt
    for i = 2:N-1
        for j = 2:N-1
            
            T_o(N,1:N) = T(N-1,1:N);
            
            adv_term = 1*dy*ux*(T_o(i+1,j)-T_o(i-1,j));
            diff_term = alpha*(T_o(i+1,j)+T_o(i-1,j)+T_o(i,j+1)+T_o(i,j-1)-4*T_o(i,j));
            T(i,j) = (dt/(dx*dy))*(diff_term-adv_term);
            T_o = T;
        end
    end
end

%err = max(max(abs(T_o-T)));

e=e+1;


end
T=T'; 

figure(1);
    contourf(x,y,T);
    clabel(contourf(x,y,T));
    colorbar;
    colormap(jet);
    xlabel('X-Axis');
    ylabel('Y-Axis');






