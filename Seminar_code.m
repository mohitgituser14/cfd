clear all
clc
%% Problem Statement

L = 100;
B = 10;
N = 5000;
M = 500;

b = 2 ;
l = 4 ;

mu = 0.001; %Pa s

dx = L/N;
dy = B/N;

nt = 1000;
dt = 0.001;

err = 5e9;
conv = 1e-4;


%% Variables

w_n = zeros(N+2,M+2);
w = zeros(N+2,M+2);
u = zeros(N+2,M+2);
v = zeros(N+2,M+2);
phi = zeros(N+2,M+2);

%% Terms 

Conv_term_1 = u(i,j)*((w(i+1,j)+w(i,j))/2)*dy - u(i-1,j)*((w(i,j+1)+w(i,j))/2)*dy ;% u>0 x dirn
Conv_term_2 = u(i+1,j)*((w(i+1,j)+w(i,j))/2)*dy - u(i,j)*((w(i,j+1)+w(i,j))/2)*dy ;% u<0

Conv_term_3 = v(i,j)*((w(i,j+1)+w(i,j))/2)*dx - v(i,j-1)*((w(i,j)+w(i,j-1))/2)*dx ;% v>0 y dirn
Conv_term_4 = v(i,j+1)*((w(i,j+1)+w(i,j))/2)*dx - v(i,j)*((w(i,j)+w(i,j-1))/2)*dx ;% v<0

Diff_term = mu((dy/dx)*((w(i+1,j)-w(i,j)+w(i-1,j)-w(i,j))+(dx/dy)*((w(i,j+1)-w(i,j)+w(i,j-1)-w(i,j)));

psi_term = (psi(i+1,j) - 2*psi(i,j) + psi(i-1,j))/(dx*dx)  +  (psi(i,j+1) - 2*psi(i,j) + psi(i,j-1))/(dy*dy) ;

%% Boundary Conditions

%velocity incoming
u(1,5*(2*b):5*b) = 5; %m/s
v(50*(2*b):50*b,1) = 5;  %m/s
v(50*(2*b):50*b,M+1) = 5;  %m/s

psi(1,5*(2*b):5*b) = (4*psi(2,5*(2*b):5*b) - 3*psi(3,5*(2*b):5*b) + 2*dy*u(1,5*(2*b):5*b))/3;

%add in iteration%%%%%%%%%%%%%%%%
psi(50*(2*b):50*b,1) = (4*psi(50*(2*b):50*b,2) - 3*psi(50*(2*b):50*b,3) + 2*dx*v(50*(2*b):50*b,1))/3;
psi(50*(2*b):50*b,M+1) = (4*psi(50*(2*b):50*b,M) - 3*psi(50*(2*b):50*b,M-1) + 2*dx*v(50*(2*b):50*b,M+1))/3;

%zero velocity boundary
u(1,1:5*(2*b)) = 0;
u(1,5*(3*b):M+1) = 0;

u(1:50*(2*b),1) = 0;
u(1:50*(2*b),M+1) = 0;

u(50*(3*b):N+1,1) = 0;
u(50*(3*b):N+1,M+1) = 0;


v(1,1:5*(2*b)) = 0;
v(1,5*(3*b):M+1) = 0;

v(1:50*(2*b),1) = 0;
v(1:50*(2*b),M+1) = 0;

v(50*(3*b):N+1,1) = 0;
v(50*(3*b):N+1,M+1) = 0;

w(1,1:5*(2*b)) = 0;
w(1,5*(3*b):M+1) = 0;

w(1:50*(2*b),1) = 0;
w(1:50*(2*b),M+1) = 0;

w(50*(3*b):N+1,1) = 0;
w(50*(3*b):N+1,M+1) = 0;

psi(1,1:5*(2*b)) = 0;
psi(1,5*(3*b):M+1) = 0;

psi(1:50*(2*b),1) = 0;
psi(1:50*(2*b),M+1) = 0;

psi(50*(3*b):N+1,1) = 0;
psi(50*(3*b):N+1,M+1) = 0;

%% Iteration

T_o = T;
sol_time = dt;
e=0;
while(e<100)
for k = 1:nt
    for i = 2:N
        for j = 2:M
            
            
            w_o(i,j) = (dt/(dx*dy))*(Diff_term-Conv_term_1)+w(i,j);
            
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
% seminar code and GENETIC OPT ARE THE FILES FOR CFD SUBMISSIOPN





