function [y] = optimization(h)
h = [4,6];
%[joints,coordinates:angles]
%[j1 j2 j3 j4, x y z : a b c]

l = zeros(3);
l(1) = 1;
l(2) = 1.5;
l(3) = 1.2;

h(1,1:6) = 0 ; % origin
for i = 1:3
    
        (h(i+1,1)-h(i,1))^2 + (h(i+1,2)-h(i,2))^2 + (h(i+1,3)-h(i,3))^2 = l(i) 
    end
    
y =;
end
