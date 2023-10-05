clc;
clear all;

%%Problem Setup
M=5;
N=5;
dx=M/5;
dy=N/5;

T=zeros(5);

%%Boundary
Tw=1;
Tn=0;
Te=0;
Ts=0;

iter=10000;
while(iter>2)
    iter=iter-1;
T(1,1)= (T(2,1)+T(1,2)+(2*Ts-T(1,1))+(2*Tw-T(1,1)))/4;
T(1,N)= (T(2,N)+T(1,N-1)+(2*Tn-T(1,N))+(2*Tw-T(1,N)))/4;
T(M,1)= (T(M-1,1)+T(M,2)+(2*Te-T(M,1))+(2*Ts-T(M,1)))/4;
T(M,N)= (T(M-1,N)+T(M,N-1)+(2*Tn-T(M,N))+(2*Te-T(M,N)))/4;



for i = 2:M-1
    for j = 2:N-1
        T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+T(i,j+1))/4;
    end
end
for i = 2:M-1
    T(i,1)= (T(i+1,j)+T(i,j+1)+T(i-1,j)+(2*Ts-T(i,1)))/4;
    T(i,N)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+(2*Tn-T(i,1)))/4;
    
end
for j = 2:N-1
    T(1,j)= (T(i+1,j)+T(i,j-1)++T(i,j+1)+(2*Tw-T(i,1)))/4;
    T(M,j)= (T(i-1,j)+T(i,j-1)++T(i,j+1)+(2*Te-T(i,1)))/4;
    
end
end

x=1:M;
y=1:N;
colormap(jet);
contourf(x,y,T');
colorbar;


    
        


