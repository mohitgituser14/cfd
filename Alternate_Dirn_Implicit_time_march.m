%%Problem Statement
clear all
clc

T = zeros(5);
T1 = zeros(5);
T2 = zeros(5);
%M,N must be odd
M = 5;
N = 5;
dx = M/5;
dy = N/5;
alpha = 10;
del_t = 0.01;
t = 500;
time_step = t*del_t;
q = alpha*del_t/(dx^2);
Tw=100;
Tn=100;
Te=100;
Ts=100;


%%Solving BC

T(1:M,1) = Ts;
T(1:M,N) = Tn;
T(1,1:N) = Tw;
T(M,1:N) = Te;

n=0;
E(1) = T(1,2) + T(2,1);
n=2:M-3;
E(n) = T(1,3:M-2); 
n=n+1;
E(n) = T(1,N-1) + T(2,N);
n=n+1:n+M-3;
E(n) = T(3:M-2,1);
n=n+1:n+M-4;
E(n)=0;
n=n+1:n+M-3;
E(n) = T(3:M-2,N);
n=n+1;
E(n) = T(M-1,1)+T(M,2);
n;
E(n) = T(M,3:N-2);
n;
E(n) = T(M,N-1)+T(M-1,N);



%%Generating matrices
%B be a column vector for unknown values of temperature
%D be a column vector for known values of temperature
%E be a column vector for boundary values of temperature

for i = 2:M-1
    for j = 2:N-1
        B(i+j-2-2+1) = T2(i,j);
        C(i+j-2-2+1) = T1(i,j);
    end
end

        
   




