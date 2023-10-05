%% INPUT VALUES
M=input('Enter the number of cells in a row: '); N=input('\nEnter the number of cells in a column: '); 
L=input('\nEnter the length of grid: '); B=input('\nEnter the width of grid: ');
l=input('\nEnter the distance from left wall after which vertical velocity is introduced:');
b=input('\nEnter the diameter of hole on left wall: ');
a=input('\nEnter the diameter of hole on top & bottom wall: '); 
Uo=input('\nEnter the value of horizontal velocity: '); 
Vo=input('\nEnter the value of Vertical velocity: ');
del_t = input('\nEnter the value of time difference: ');
gama=input('\nEnter the value of gama: ');
del_x=L/M;
t=del_t/(del_x*del_x);

wi=zeros(M,N); 
w=zeros(M,N); 
P=zeros(M,N); 
u=zeros(M,N); 
v=zeros(M,N); 
vx=zeros(M,N); 
vy=zeros(M,N); 
werror=zeros(M,N); 
Vf=zeros(M,N); 
e_w=1; 
e_threshold=1e-6; 
iter=0; R=zeros(M,N); 
cor=zeros(M,N); 
z=0;
countr=0; 
RMS=1;

y_centre=zeros(1,N);
for i=1:N
y_centre(1,i)= del_x/2 + (i-1)*del_x;
end
x_centre=zeros(1,M);
for i=1:M
x_centre(1,i)= del_x/2 + (i-1)*del_x;
end

%% STEP-1
%% VORTICITY FORMULATION

while e_w>e_threshold iter=iter+1;
for i=1:M
for j=1:N
%             ue = (u(i+1,j) + u(i,j))/2;
%             uw = (u(i-1,j) + u(i,j))/2;
%             vn = (v(i,j+1) + v(i,j))/2;
%             vs = (v(i,j-1) + v(i,j))/2;

if i==1 && j==1 
ue = (u(i+1,j) + u(i,j))/2; 
vn = (v(i,j+1) + v(i,j))/2; 
w3=-2*u(i,1)/del_x; 
w4=2*v(1,j)/del_x;
w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + (2*w4-wi(i,j)) + wi(i,j+1) + (2*w3-wi(i,j)) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))+vn*(wi(i,j)+wi(i,j+1)));
elseif i==1 && j==N
ue = (u(i+1,j) + u(i,j))/2;
vs = (v(i,j-1) + v(i,j))/2; 
w6=2*v(1,j)/del_x; 
w7=2*v(i,j)/del_x;
w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + (2*w6-wi(i,j)) + (2*w7-wi(i,j)) + wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))- vs*(wi(i,j)+wi(i,j-1)));
elseif i==M && j==N
uw = (u(i-1,j) + u(i,j))/2; 
vs = (v(i,j-1) + v(i,j))/2; 
w9=2*v(i,j)/del_x;
w(i,j) = wi(i,j) + gama*t*(wi(i,j) + wi(i-1,j) + (2*w9-wi(i,j)) +wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(u(i,j)*(wi(i,j)+wi(i,j))-uw*(wi(i,j)+wi(i-1,j))-vs*(wi(i,j)+wi(i,j-1)));
elseif i==M && j==1
uw = (u(i-1,j) + u(i,j))/2; 
vn = (v(i,j+1) + v(i,j))/2; 
w1=-2*u(i,1)/del_x;
w(i,j) = wi(i,j) + gama*t*(wi(i,j) + wi(i-1,j) + wi(i,j+1) + (2*w1- wi(i,j)) - 4*wi(i,j)) - t*del_x*0.5*(u(i,j)*(wi(i,j)+wi(i,j))-uw*(wi(i,j)+wi(i-1,j))+vn*(wi(i,j)+wi(i,j+1)));
elseif i==1
ue = (u(i+1,j) + u(i,j))/2; 
vn = (v(i,j+1) + v(i,j))/2; 
vs = (v(i,j-1) + v(i,j))/2;

%%uw=U
N1=(B-b)/(2*del_x); 
N2=b/del_x;

if (2<=j)&&(j<=N1)
%%uw=0 
w4=2*v(1,j)/del_x;

w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + (2*w4-wi(i,j)) + wi(i,j+1) + wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))+vn*(wi(i,j)+wi(i,j+1))-vs*(wi(i,j)+wi(i,j-1)));
elseif (N1<j)&&(j<=N1+N2)
%%uw=Uo 
w5=0;

w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + (-wi(i,j)) + wi(i,j+1) + wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))+vn*(wi(i,j)+wi(i,j+1))-vs*(wi(i,j)+wi(i,j-1)));
elseif (j>N1+N2)&&(j<=N-1)
%%uw=0
w6=2*v(1,j)/del_x; 
w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + (2*w6-wi(i,j)) + wi(i,j+1) + wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))+vn*(wi(i,j)+wi(i,j+1))-vs*(wi(i,j)+wi(i,j-1)));
end 

elseif i==M
uw = (u(i-1,j) + u(i,j))/2; 
vn = (v(i,j+1) + v(i,j))/2; 
vs = (v(i,j-1) + v(i,j))/2;

%%ue=u(i,j)
w(i,j) = wi(i,j) + gama*t*(wi(i,j) + wi(i-1,j) + wi(i,j+1) + wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(u(i,j)*(wi(i,j)+wi(i,j))-uw*(wi(i,j)+wi(i-1,j))+vn*(wi(i,j)+wi(i,j+1))-vs*(wi(i,j)+wi(i,j-1)));
elseif j==1
ue = (u(i+1,j) + u(i,j))/2;
uw = (u(i-1,j) + u(i,j))/2;
vn = (v(i,j+1) + v(i,j))/2;


%%vs=0

M1=l/del_x; 
M2=a/del_x;

if (2<=i)&&(i<=M1)
%%vs=0
w3=-2*u(i,1)/del_x;

w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + wi(i-1,j) + wi(i,j+1) + (2*w3-wi(i,j)) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))- uw*(wi(i,j)+wi(i-1,j))+vn*(wi(i,j)+wi(i,j+1)));
elseif (M1<i)&&(i<=M1+M2)
%%vs=Vo w2=0;

w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + wi(i-1,j) + wi(i,j+1) + (- wi(i,j)) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))-uw*(wi(i,j)+wi(i-1,j))+vn*(wi(i,j)+wi(i,j+1)));
elseif (i>M1+M2)&&(i<=M-1)
%%vs=0
w1=-2*u(i,1)/del_x;

w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + wi(i-1,j) + wi(i,j+1) + (2*w1-wi(i,j)) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))- uw*(wi(i,j)+wi(i-1,j))+vn*(wi(i,j)+wi(i,j+1)));
end

elseif j==N
ue = (u(i+1,j) + u(i,j))/2;
uw = (u(i-1,j) + u(i,j))/2;
vs = (v(i,j-1) + v(i,j))/2;

%%vn=0

M1=l/del_x; 
M2=a/del_x;

if (2<=i)&&(i<=M1)
%%vn=0
w7=2*v(i,N)/del_x;
w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + wi(i-1,j) + (2*w7-wi(i,j)) + wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))-uw*(wi(i,j)+wi(i-1,j))-vs*(wi(i,j)+wi(i,j-1)));
elseif (M1<i)&&(i<=M1+M2)

%%vn=-Vo
w8=2*v(i,N)/del_x;
w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + wi(i-1,j) + (2-w8-wi(i,j)) + wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))-uw*(wi(i,j)+wi(i-1,j))-vs*(wi(i,j)+wi(i,j-1)));

elseif (i>M1+M2)&&(i<=M-1)

%%vn=0
w9=2*v(i,N)/del_x;
w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + wi(i-1,j) + (2*w9-wi(i,j)) + wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))-uw*(wi(i,j)+wi(i-1,j))-vs*(wi(i,j)+wi(i,j-1)));

end
 
else
 

w(i,j) = wi(i,j) + gama*t*(wi(i+1,j) + wi(i-1,j) + wi(i,j+1) + wi(i,j-1) - 4*wi(i,j)) - t*del_x*0.5*(ue*(wi(i,j)+wi(i+1,j))-uw*(wi(i,j)+wi(i-1,j))+vn*(wi(i,j)+wi(i,j+1))-vs*(wi(i,j)+wi(i,j-1)));
end
end
end




%% STEP-2 GSSOR
%% STREAM FUNCTION


while RMS>10^(-5)

for i=1:M
for j=1:N


if i==1 && j==1
P3=0;
P4=0;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + (-P(i,j)) + P(i,j+1) + (- P(i,j)) - 4*P(i,j));

elseif i==1 && j==N 
P6=Uo*b; 
P7=Uo*b;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + (2*P6-P(i,j)) + (2*P7-P(i,j)) + P(i,j-1) - 4*P(i,j));

elseif i==M && j==N 
P9=Uo*b;
R(i,j) = -w(i,j)*del_x*del_x - (P(i,j) + P(i-1,j) + (2*P9-P(i,j)) + P(i,j-1) - 4*P(i,j));
elseif i==M && j==1 
P1=-Vo*a;
R(i,j) = -w(i,j)*del_x*del_x - (P(i,j) + P(i-1,j) + P(i,j+1) + (2*P1-P(i,j)) - 4*P(i,j));
elseif i==1
%%uw=U
N1=(B-b)/(2*del_x);
N2=b/del_x;

if (2<=j)&&(j<=N1)
%%uw=0
P4=0;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + (-P(i,j)) + P(i,j+1) + P(i,j-1) - 4*P(i,j));

elseif (N1<j)&&(j<=N1+N2)
%%uw=Uo
P5=Uo*(-N1-0.5+j)*del_x;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + (2*P5-P(i,j)) + P(i,j+1) + P(i,j-1) - 4*P(i,j));
elseif (j>N1+N2)&&(j<=N-1)
%%uw=0
P6=Uo*b;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + (2*P6-P(i,j)) + P(i,j+1) + P(i,j-1) - 4*P(i,j));

end

%
elseif i==M
%%ue=u(i,j)
R(i,j) = -w(i,j)*del_x*del_x - (P(i,j) + P(i-1,j) + P(i,j+1) + P(i,j-1) - 4*P(i,j));
elseif j==1
%%vs=0

M1=l/del_x; 
M2=a/del_x;

if (2<=i)&&(i<=M1)
%%vs=0
P3=0;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + P(i-1,j) + P(i,j+1) + (-P(i,j)) - 4*P(i,j));


elseif (M1<i)&&(i<=M1+M2)
%%vs=Vo
P2=-Vo*(-M1-0.5+i)*del_x;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + P(i-1,j) + P(i,j+1) + (2*P2-P(i,j)) - 4*P(i,j));
elseif (i>M1+M2)&&(i<=M-1)
%%vs=0
P1=-Vo*a;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + P(i-1,j) + P(i,j+1) + (2*P1-P(i,j)) - 4*P(i,j));
end

elseif j==N
%%vn=0 
M1=l/del_x; 
M2=a/del_x;

if (2<=i)&&(i<=M1)
%%vn=0
P7=Uo*b;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + P(i-1,j) + (2*P7- P(i,j)) + P(i,j-1) - 4*P(i,j));

elseif (M1<i)&&(i<=M1+M2)
%%vn=-Vo
P8=Uo*b;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + P(i-1,j) + (2*P8- P(i,j)) + P(i,j-1) - 4*P(i,j));

elseif (i>M1+M2)&&(i<=M-1)
%%vn=0
P9=Vo*a + Uo*b;
R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + P(i-1,j) + (2*P8-P(i,j)) + P(i,j-1) - 4*P(i,j));

end
 
else
 

R(i,j) = -w(i,j)*del_x*del_x - (P(i+1,j) + P(i-1,j) + P(i,j+1) + P(i,j-1) - 4*P(i,j));
end
end 
end

sum=0;
for i=1:M
for j=1:N cor(i,j)=R(i,j)*0.3/(-4); P(i,j)=P(i,j)+cor(i,j); sum=sum+cor(i,j); 

end
 
end 
countr=countr+1; 
RMS=sum/(M*N); 
end



%% STEP-3 VELOCITY CALCULATION

for i=1:M
for j=1:N


if i==1 && j==1
P3=0;
P4=0;
vx(i,j) = (P(i,j+1)-(2*P3-P(i,j)))/(2*del_x);
vy(i,j) = ((2*P4-P(i,j))-P(i+1,j))/(2*del_x);
elseif i==1 && j==N 
P6=Uo*b; 
P7=Uo*b;
vx(i,j) = ((2*P7-P(i,j))-P(i,j-1))/(2*del_x);
vy(i,j) = ((2*P6-P(i,j))-P(i+1,j))/(2*del_x); 
elseif i==M && j==N 
P9=Uo*b;
vx(i,j) = ((2*P9-P(i,j))-P(i,j-1))/(2*del_x);
vy(i,j) = (P(i-1,j)-P(i,j))/(2*del_x);
elseif i==M && j==1
P1=-Vo*a;
vx(i,j) = (P(i,j+1)-(2*P1-P(i,j)))/(2*del_x);
vy(i,j) = (P(i-1,j)-P(i,j))/(2*del_x);
elseif i==1
%%uw=U
N1=(B-b)/(2*del_x);
N2=b/del_x;

if (2<=j)&&(j<=N1)
%%uw=0
P4=0;
vx(i,j) = (P(i,j+1)-P(i,j-1))/(2*del_x);
vy(i,j) = ((2*P4-P(i,j))-P(i+1,j))/(2*del_x);

elseif (N1<j)&&(j<=N1+N2)
%%uw=Uo
P5=Uo*(-N1-0.5+j)*del_x;
vx(i,j) = (P(i,j+1)-P(i,j-1))/(2*del_x);
vy(i,j) = ((2*P5-P(i,j))-P(i+1,j))/(2*del_x);
elseif (j>N1+N2)&&(j<=N-1)
%%uw=0
P6=Uo*b;
vx(i,j) = (P(i,j+1)-P(i,j-1))/(2*del_x);
vy(i,j) = ((2*P6-P(i,j))-P(i+1,j))/(2*del_x);

end

%
elseif i==M
%%ue=u(i,j)
vx(i,j) = (P(i,j+1)-P(i,j-1))/(2*del_x);
vy(i,j) = (P(i-1,j)-P(i,j))/(2*del_x);
elseif j==1
%%vs=0

M1=l/del_x; M2=a/del_x;

if (2<=i)&&(i<=M1)
%%vs=0
P3=0;
vx(i,j) = (P(i,j+1)-(2*P3-P(i,j)))/(2*del_x);
vy(i,j) = (P(i-1,j)-P(i+1,j))/(2*del_x);


elseif (M1<i)&&(i<=M1+M2)
%%vs=Vo
P2=-Vo*(-M1-0.5+i)*del_x;
vx(i,j) = (P(i,j+1)-(2*P2-P(i,j)))/(2*del_x);
vy(i,j) = (P(i-1,j)-P(i+1,j))/(2*del_x);
elseif (i>M1+M2)&&(i<=M-1)
%%vs=0
P1=-Vo*a;
vx(i,j) = (P(i,j+1)-(2*P1-P(i,j)))/(2*del_x); 

end
 
vy(i,j) = (P(i-1,j)-P(i+1,j))/(2*del_x); 

elseif j==N
%%vn=0

M1=l/del_x; M2=a/del_x;

if (2<=i)&&(i<=M1)
%%vn=0
P7=Uo*b;
vx(i,j) = ((2*P7-P(i,j))-P(i,j-1))/(2*del_x);
vy(i,j) = (P(i-1,j)-P(i+1,j))/(2*del_x);

elseif (M1<i)&&(i<=M1+M2)
%%vn=-Vo
P8=Uo*b;
vx(i,j) = ((2*P8-P(i,j))-P(i,j-1))/(2*del_x);
vy(i,j) = (P(i-1,j)-P(i+1,j))/(2*del_x);

elseif (i>M1+M2)&&(i<=M-1)
%%vn=0
P9=Uo*b;
vx(i,j) = ((2*P9-P(i,j))-P(i,j-1))/(2*del_x);
vy(i,j) = (P(i-1,j)-P(i+1,j))/(2*del_x);

end
 
else
vx(i,j) = (P(i,j+1)-P(i,j-1))/(2*del_x);
vy(i,j) = (P(i-1,j)-P(i+1,j))/(2*del_x);


end
%         uerror(i,j) = vx(i,j)-u(i,j);
%         verror(i,j) = vy(i,j)-v(i,j);
end
end
%     ex=max(max(uerror));
%     ey=max(max(verror));
for i=1:M
for j=1:N
werror(i,j)=w(i,j)-wi(i,j);
end
end
e_w=max(max(werror));

u=vx; 
v=vy; 
wi=w;
if iter==1 e_w=1;
end 
end
for i=1:M
for j=1:N Vf(i,j)=sqrt((vx(i,j)*vx(i,j))+(vy(i,j)*vy(i,j))); 

end
 
end 
disp(iter); 
disp(countr); 
u=u';
v=v';

figure(1)
colormap("jet"); 
contourf(Vf',20,'edgecolor','none'); 
colorbar;
title("Velocity Distribution");

figure(2) [X_loc,Y_loc]=meshgrid(x_centre,y_centre); 
streamslice(X_loc,Y_loc,u,v) 
