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


%%Iterative Work
for i = 1:1:5;
    for j = 1:1:5;
        if (i==1)
            if (j==1)
                T(i,j)= (T(i+1,j)+T(i,j+1)+(2*Ts-T(i,j))+(2*Tw-T(i,j)))/4;
               
            
            elseif (j==N)
                T(i,j)= (T(i+1,j)+T(i,j-1)+(2*Tn-T(i,j))+(2*Tw-T(i,j)))/4;
                
            else
                T(i,j)= (T(i+1,j)+T(i,j+1)+T(i,j-1)+(2*Tw-T(i,j)))/4;
            end
        else
            T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+T(i,j+1))/4;
            
        end
        
        if (i==M)
            if (j==1)
                T(i,j)= (T(i-1,j)+T(i,j+1)+(2*Te-T(i,j))+(2*Ts-T(i,j)))/4;
            
            elseif (j==N)
                T(i,j)= (T(i-1,j)+T(i,j-1)+(2*Tn-T(i,j))+(2*Te-T(i,j)))/4;
                
            else
                T(i,j)= (T(i+1,j)+T(i,j+1)+T(i,j-1)+(2*Te-T(i,j)))/4;
            end
        else
            T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+T(i,j+1))/4;
            
        end
        if (j==1 && (i~=1) && (i~=M))
             T(i,j)= (T(i+1,j)+T(i,j+1)+T(i-1,j)+(2*Ts-T(i,j)))/4;
        else
            T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+T(i,j+1))/4;
            
        end
        if (j==N && (i~=1) && (i~=M))
             T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+(2*Tn-T(i,j)))/4;
        else
            T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+T(i,j+1))/4;
            
        end
    %T(i,j)= (T(i+1,j)+T(i,j-1)+T(i-1,j)+T(i,j+1))/4;
    end
end
plot(T);

        
                
            
            
                
