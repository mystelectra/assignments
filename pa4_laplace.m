clear all
close all

X=50;
Y=100;
delta = 1; % deltax = deltay = delta
iterations = 100;
BC_left = 1;
BC_right = 1;
BC_top = 0;
BC_bottom = 0;

% d^2/dx^2 *(V) + d^2/dy^2 *(V) = 0
% d^2/dx^2 = (Vm+1 - 2Vm + Vm_1)/(delta*delta)

V = zeros(X,Y);
V(:,1) = BC_left;
V(:,Y) = BC_right;
V(1,[2:(Y-1)]) = BC_top;
V(X,[2:(Y-1)]) = BC_bottom;

for it=1:iterations
    for m=1:X
        for n=1:Y
            mm = m-1;
            mp = m+1;
            nm = n-1;
            np = n+1;
            
            % left boundary (adiabatic = no heat flow)
            if ((m==1&n==1)|(m==X&n==Y)|(m==1&n==Y)|(m==X&n==1)) 
                %corner conditions
                V(:,1) = BC_left;
                V(:,Y) = BC_right;
                V(1,[2:(Y-1)]) = BC_top;
                V(X,[2:(Y-1)]) = BC_bottom;
            elseif (m==1)
                %left side
                V(m,n) = (V(mp,n)+ V(m,np) + V(m,nm))/3;
                V(:,1) = BC_left;
            elseif (m==X)
                %right side
                V(m,n) = (V(mm,n)+ V(m,np) + V(m,nm))/3;
                V(:,Y) = BC_right;
            elseif (n==1)
                %top
                V(m,n) = (V(mp,n)+ V(mm,n) + V(m,np))/3;
                V(1,[2:(Y-1)]) = BC_top;
            elseif (n==Y)
                %bottom
                V(m,n) = (V(mp,n)+ V(mm,n) + V(m,nm))/3;
                V(X,[2:(Y-1)]) = BC_bottom;
            else 
                V(m,n) = (V(mp,n)+ V(mm,n) + V(m,nm)+ V(m,np))/4;
            end
        end    
    end
    
    figure(1)
    mesh(V);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    pause(0.01);
end
