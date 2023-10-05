clc;
clear all;

%%Problem Setup
M=20;
N=20;
dx=M/20;
dy=N/20;
h=37; %W/m2k
k=386; %wm-1K-1
q=500000; %w/m2
C0=100000; %W/m2
Tinf=20+273;
T=zeros(20);

%%Boundary
Tw=50+273; %K
Tn=0;
Te=0;
Ts=0;

h1=37:10:1027;
iterplot=100;
r=1;
lim=10000;
limend=2;
forplot=1:lim-limend;
Tmin=[0];
iter = lim;

while(r~=iterplot+1)
   h=10+h;
  
while(iter>limend)
    
    iter=iter-1;
    
T(1,1)= (T(2,1)+T(1,2)+(T(1,1)*(1-dy*h/k)+dy*Tinf*h/k)+(T(1,1)*(1-dy*h/k)+dy*Tinf*h/k))/4;
T(1,N)= (T(2,N)+T(1,N-1)+(T(1,N)*(1-dy*h/k)+dy*Tinf*h/k)+(T(M,1)*(1-dy*h/k)+dy*Tinf*h/k))/4;
T(M,1)= (T(M-1,1)+T(M,2)+(T(M,1)*(1-dy*h/k)+dy*Tinf*h/k)+(T(M,1)*(1-dy*h/k)+dy*Tinf*h/k))/4;
T(M,N)= (T(M-1,N)+T(M,N-1)+(T(M,N)*(1-dy*h/k)+dy*Tinf*h/k)+(T(M,N)*(1-dy*h/k)+dy*Tinf*h/k))/4;


for i=0:M/2-1;
    for j=0:N/2-1;
        if (i==0 )
            if(j==0)
                T(M/2,N/2)= (T(M/2+1,N/2)+T(M/2,N/2-1)+T(M/2-1,N/2)+T(M/2,N/2+1)+(q/k))/4;
            else
      
            T(M/2,N/2+j)= (T(M/2+1,N/2+j)+T(M/2,N/2+j-1)+T(M/2-1,N/2+j)+T(M/2,N/2+j+1))/4;
            if( j ~= N/2-1)
                T(M/2,N/2-j)= (T(M/2+1,N/2-j)+T(M/2,N/2-1-j)+T(M/2-1,N/2-j)+T(M/2,N/2+1-j))/4;
            end
            end
        else
            if(j==0)
                T(M/2+i,N/2)= (T(M/2+1+i,N/2)+T(M/2+i,N/2-1)+T(M/2+i-1,N/2)+T(M/2+i,N/2+1))/4;
                if(i ~= M/2-1)
                   T(M/2-i,N/2)= (T(M/2+1-i,N/2)+T(M/2-i,N/2-1)+T(M/2-i-1,N/2)+T(M/2-i,N/2+1))/4; 
                end
            else
                T(M/2+i,N/2+j)= (T(M/2+1+i,N/2+j)+T(M/2+i,N/2-1+j)+T(M/2-1+i,N/2+j)+T(M/2+i,N/2+1+j))/4;
                if( j ~= N/2-1)
                    T(M/2+i,N/2-j)= (T(M/2+1+i,N/2-j)+T(M/2+i,N/2-1-j)+T(M/2-1+i,N/2-j)+T(M/2+i,N/2+1-j))/4;
                end
                if(i ~= M/2-1)
                    T(M/2-i,N/2+j)= (T(M/2+1-i,N/2+j)+T(M/2-i,N/2-1+j)+T(M/2-1-i,N/2+j)+T(M/2-i,N/2+1+j))/4;
                    if(j ~= N/2-1)
                         T(M/2-i,N/2-j)= (T(M/2+1-i,N/2-j)+T(M/2-i,N/2-1-j)+T(M/2-1-i,N/2-j)+T(M/2-i,N/2+1-j))/4;
                        
                end
                
        end
    end
        end
        
    end
    
for i = 2:M-1
    T(i,1)= (T(i+1,1)+T(i,1+1)+T(i-1,1)+(T(i,1)*(1-dy*h/k)+dy*Tinf*h/k))/4;
    T(i,N)= (T(i+1,N)+T(i,N-1)+T(i-1,N)+(T(i,N)*(1-dy*h/k)+dy*Tinf*h/k))/4;
    
end
for j = 2:N-1
    T(1,j)= (T(1+1,j)+T(1,j-1)+T(1,j+1)+(T(1,j)*(1-dy*h/k)+dy*Tinf*h/k))/4;

    T(M,j)= (T(M-1,j)+T(M,j-1)+T(M,j+1)+(T(M,j)*(1-dy*h/k)+dy*Tinf*h/k))/4;
    
end
end

end

Tmin(r)=T(M/2,N/2);
iter=lim;
 r=r+1;
end

  
  


   
plot(h1,Tmin);
x=1:M;
y=1:N;
colormap(jet);

contourf(x,y,T');
colorbar;


    
        


