clc;
clear all;

%%Problem Setup
M=10;
N=10;
dx=M/10;
dy=N/10;
h=37; %W/m2k
k=386; %wm-1K-1
C0=100000; %W/m2
Tinf=20+273;
T=zeros(10);

%%Boundary
Tw=50+273; %K

iter=10000;
while(iter>2)
    iter=iter-1;
T(1,1)= (T(2,1)+T(1,2)+T(1,1)+(2*Tw-T(1,1)))/4;
T(1,N)= (T(2,N)+T(1,N-1)+(2*Tw-T(1,N))+(C0*dy-T(1,N)))/4;
T(M,1)= (T(M-1,1)+T(M,2)+T(M,1)+(T(M,1)*(1-dy*h/k)+dy*Tinf*h/k))/4;
T(M,N)= (T(M-1,N)+T(M,N-1)+(C0*dy-T(M,N))+(T(M,N)*(1-dy*h/k)+dy*Tinf*h/k))/4;



for i = 2:M-1
    for j = 2:N-1
        T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+T(i,j+1))/4;
    end
end
for i = 2:M-1
    T(i,1)= (T(i+1,j)+T(i,j+1)+T(i-1,j)+(T(i,1)))/4;
    T(i,N)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+(C0*dy-T(i,N)))/4;
    
end
for j = 2:N-1
    T(1,j)= (T(i+1,j)+T(i,j-1)++T(i,j+1)+(2*Tw-T(i,1)))/4;

    T(M,j)= (T(i-1,j)+T(i,j-1)++T(i,j+1)+(T(M,j)*(1-dy*h/k)+dy*Tinf*h/k))/4;
    
end
end

x=1:M;
y=1:N;
colormap(jet);
contourf(x,y,T');
colorbar;


    
        


