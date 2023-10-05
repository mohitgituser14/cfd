clc ;
clear all ;
close all ; 

%% Problem Domain

n = 101;
length_domain = 1 ;%1m
dx = length_domain / (n-1) ;
x = 0:dx:length_domain;
y = 0:dx:length_domain;

dt = 0.001;
mu = 1.0016;
ro = 997;
U = 50 ;

%% Variables

u = zeros(n+1,n) ;
u_next = zeros(n,n) ;
u_pred = zeros(n,n) ;
v = zeros(n,n+1) ;
v_next = zeros(n,n) ;
v_pred = zeros(n,n) ;

p(n+1,n+1) = 1 ;
p_(n+1,n+1) = 1 ;




%% Boundary Conditions

u(1,:) = 2 ;
 
%% Iteration
bll =2;

for k = 1:10^3
    for i = 2:n
        for j = 2:n-1
           % x-momentum equation
           
           diff_1 = (u(i-1,j) -2*u(i,j) + u(i+1,j))/dx/dx ;
           diff_2 = (u(i,j-1) -2*u(i,j) + u(i,j+1))/dx/dx ;
           diff = (mu)*(diff_1 + diff_2) ;
           
           press = -(p(i+1,j)-p(i,j))/dx ;
           advec = u(i,j)*(u(i+1,j)-u(i-1,j))/2/dx;
           u_pred = u(i,j) + dt*(1/ro)*(press+diff-advec) ;
           
           diff_1 = (v(i-1,j) -2*v(i,j) + v(i+1,j))/dx/dx ;
           diff_2 = (v(i,j-1) -2*v(i,j) + v(i,j+1))/dy/dy ;
           diff = (mu)*(diff_1 + diff_2) ;
           
           press = -(p(i,j+1)-p(i,j))/dx ;
           advec = v(i,j)*(v(i,j+1)-v(i,j-1))/2/dx;
           v_pred = v(i,j) + dt*(1/ro)*(press+diff-advec) ;
           
           K = (u_pred(i+1,j)-u_pred(i,j))/dx + (v_pred(i,j+1)-v_pred(i,j))/dx  ;
           
           
           
            
            
            
        end
    end

end

for k = 1:10^3
    for i = 2:n
        for j = 2:n-1
            p_(i,j) = (p_(i+1,j)+p_(i-1,j)+p_(i,j+1)+p_(i,j-1)-(dx*dx*K/dt))/4;
        end
    end
end
for k = 1:10^3
    for i = 2:n
        for j = 2:n-1
                  u_next(i,j) =  (-(dt/ro)*(p_(i+1,j)-p_(i,j))/dx) + u_pred;
                  v_next(i,j) =  (-(dt/ro)*(p_(i,j+1)-p_(i,j))/dx) + v_pred;

        end
    end
end
