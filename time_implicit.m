clc;
clear all;

N=20;
dx=N/20;

%Boundary

Tw=10;
Te=0;



alpha=5;
deltt=0.01;		

r=alpha*deltt/(dx*dx);

ap=1+2*r;
ae=r;
aw=r;
ap0=1;

A=zeros(20);
A(1,1)=ap-aw;
A(N,N)=ap-aw;

X=zeros(20);
for i = 1:N;
    T(i)
B=zeros(20);

%iteration Land


iter=10000;
while(iter>2)
    iter=iter-1;
    for i = 2:N-1
        for j = 2:N-1
            if(i==j)
                A(i,j)=ap;
            end
            if(i=j+1)
                A(i,j)=aw;
            end
            if(j=i+1)
                A(i,j)=ae;
            end
        end
        B()
        
        
      

end

x=1:M;
y=1:N;
colormap(jet);
contourf(x,y,T');
colorbar;


    
        


