N = 20;
T = zeros(20);
Told = zeros(20);
X = zeros(20);
R = zeros(20);

a = zeros(20);
b = zeros(20);
c = zeros(21);
for i = 50:70;
    a(i-49)=i;
    b(i-49)=i-10;
    c(i-49)=i-20;
end

for i = 2:N
    for j = 2:N
        if(i==j)
            T(i,j)=a(i);
            T(i+1,j)=c(i+1);
            T(i-1,j)=b(i-1);
        end
    end
end
T(1,1)=4;
T(2,1)=4;
Told=T;




%TDMA ALGORITHM

for i = 2:N-1
    for j = 2:N-1
        if(i==j)
               T(i,j)= T(i,j) - T(i,j+1)*(T(i-1,j)/T(i-1,j-1));
        end
    end
end

for i = 2:N-1
    for j = 2:N-1
        if(i==j)
T(i-1,j)=0;
        end
    end
end
%remove this later just for show!!!!
T=T';
            




            
        
        