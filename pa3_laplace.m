clear all

X=5;
Y=10;
delta = 1; % deltax = deltay = delta
iterations = 100;

% d^2/dx^2 *(V) + d^2/dy^2 *(V) = 0
% d^2/dx^2 = (Vm+1 - 2Vm + Vm_1)/(delta*delta)

V = zeros(X,Y);
V(:,1) = 1;

for it=0:iterations
    for m=1:X
        for n=1:Y
            mm = m-1;
            mp = m+1;
            nm = n-1;
            np = n+1;
            
            % left boundary (adiabatic = no heat flow)
            if (mm<=0)
                V(:,1) = 1;
                V(m,n) = (V(mp,n)+ V(m,np) + V(m,nm))/3;
            end
            if (mp>X)
                V(:,X) = 0;
                V(m,n) = (V(mm,n)+ V(m,np) + V(m,nm))/3;
            end
            if (nm<=0)
                V(m,n) = (V(mp,n)+ V(mm,n) + V(m,np))/3;
            end
            if (np>Y)
                V(m,n) = (V(mp,n)+ V(mm,n) + V(m,nm))/3;
            else 
                V(m,n) = (V(mp,n)+ V(mm,n) + V(m,nm)+ V(m,np))/4;
            end
            
            
        end
        
    end
    
    surf(V);
    pause(0.01);
end







