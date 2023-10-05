clc ;
clear all ;
close all ; 



M = 302 ; % X axis
N = 302 ; % Y axis
L = 100 ; % less than either side
L_x = 5 ; % length in meters
L_y = 1 ; % length in meters

dx = L_x/M;
dy = L_y/N;

b = dx/dy;

Vx = 1; %in m/s
Vy = 2; %in m/s
Re = 100;

w = zeros(M,N);
psi = zeros(M,N);
w_n = zeros(M,N);
psi_n = zeros(M,N);
u = zeros(M,N);
v = zeros(M,N);

% Boundary conditions

v(100:200,1) = Vy;
v(100:200,302) = Vy;
u(1,100:200) = Vx;

w(1,1:99) = 2*(psi(1,1:99)-psi(2,1:99))/dx/dx ;

w(1,201:302) = 2*(psi(1,201:302)-psi(2,201:302))/dx/dx ;


w(1:99,1) = 2*(psi(1:99,1)-psi(1:99,2))/dy/dy ;

w(201:302,1) = 2*(psi(201:302,1)-psi(201:302,2))/dy/dy ;

w(1:99,302) = 2*(psi(1:99,302)-psi(1:99,301))/dy/dy ;

w(201:302,302) = 2*(psi(201:302,302)-psi(201:302,301))/dy/dy ;
