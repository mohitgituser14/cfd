clear all
close all
clc

%% Problem Statement
N = 10;
L = 1;

k = 1000;
alpha = 1.4;

c = 5;
nt = 500;
dt = 0.001;

dx = L/N;

error = 5e9;                   
convergence_criteria = 1e-4;

T = zeros(N);


%% Boundary Conditions

T_N = 600;
T_S = 900;
T_E = 800;


T(1:N,1) = T_S;
T(1:N,N) = T_N;
T(N,1:N) = T_S;


T(1,end) = (T_N + T_E)/2;
T(end,end) = (T_S + T_E)/2;

%% SOR Scheme
solution_time = 0;
T_prev_iter = T;
T_prev_time = T;


r = alpha*dt/(dx^2);
beta = 1.5;

iter = 1;

    
for k = 1:nt
    T_W = 500*sin(c*k);
    T(1,1:N) = T_W;
    
    T(1,1) = (T_N + T_W)/2;
    T(end,1) = (T_S + T_W)/2;
    
    while(error > convergence_criteria)
        for i = 2:N-1
            
            for j = 2:N-1
                T_gs = ((1/(4*r+1))*T_prev_time(i,j)) + (r/(1+4*r))*(T_prev_iter(i+1,j)+T(i-1,j)+T_prev_iter(i,j+1)+T(i,j-1));
                
                T(i,j) = T_prev_iter(i,j)*(1-beta) + (T_gs*beta);
            end
        end
        error = max(max(abs(T_prev_iter-T)));
        T_prev_iter = T;
        iter = iter +1;
    end
    error = 1;
    T_prev_time = T;
    
    
   
    
end
    error2 = max(max(abs(T))); 
end


figure(1);
    x = linspace(0,L,N);  
    y = linspace(0,L,N);
    contourf(x,y,T);
    clabel(contourf(x,y,T));
    colorbar;
    colormap(jet);
    xlabel('X-Axis');
    ylabel('Y-Axis');
    
    solution_time = dt + solution_time;
    
    title_text = sprintf('2D Implicit Unsteady Heat Diffusion, SOR, Solution Time: %.3f s',solution_time);
    title(title_text);
    
    set(gca,'ydir','reverse')



        


