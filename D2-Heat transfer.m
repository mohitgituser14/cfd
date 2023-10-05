clc;
clear all;

%%Problem Setup
M=1;
N=1;
dx=M/5;
dy=N/5;

T=zeros(4);

%%Boundary
Tw=1;
Tn=0;
Te=0;
Ts=0;
T(0,N)= (T(0,N)+T(1,N)+2)/6;
T(0,0)= (T(0,1)+T(1,0)+2)/6;
T(M,N)= (T(M-1,N)+T(M,N-1))/6;
T(M,0)= (T(M-1,0)+T(M,1)+2)/6;

%%Iterative Work
for i = 0:M;
    for j = 0:N;
        if (i==0)
            if (j==0)
                T(i,j)= (T(i+1,j)+T(i,j+1)+(2*Ts-T(i,j))+(2*Tw-T(i,j)))/4;
            
            elseif (j==N)
                T(i,j)= (T(i+1,j)+T(i,j-1)+(2*Tn-T(i,j))+(2*Tw-T(i,j)))/4;
                
            else
                T(i,j)= (T(i+1,j)+T(i,j+1)+T(i,j-1)+(2*Tw-T(i,j)))/4;
            end
            
        end
        
        if (i==M)
            if (j==0)
                T(i,j)= (T(i-1,j)+T(i,j+1)+(2*Te-T(i,j))+(2*Ts-T(i,j)))/4;
            
            elseif (j==N)
                T(i,j)= (T(i-1,j)+T(i,j-1)+(2*Tn-T(i,j))+(2*Te-T(i,j)))/4;
                
            else
                T(i,j)= (T(i+1,j)+T(i,j+1)+T(i,j-1)+(2*Te-T(i,j)))/4;
            end
            
        end
        if (j==0 && (i~=0) && (i~=M))
             T(i,j)= (T(i+1,j)+T(i,j+1)+T(i-1,j)+(2*Ts-T(i,j)))/4;
          
            
        end
        if (j==N && (i~=0) && (i~=M))
             T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+(2*Tn-T(i,j)))/4;
          
            
        end
    T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+T(i,j+1))/4;
    end
end
plot(T);

        
                
            
            
                
