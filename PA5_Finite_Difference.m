nx=50; %change
ny=55; %change
BC_left=0;
BC_right=0;
BC_top=0;
BC_bottom=0;

G=sparse(nx*ny);
B=zeros(1,nx*ny);

for a=1:nx
    for b=1:ny
        n=a+(b-1)*nx;
        
        if a==1 
            %Left Side
            G(n,:) = 0; 
            G(n,n) = 1;
            B(n)=1;
        elseif a==nx
            %Right Side
            G(n,:) = 0; 
            G(n,n) = 1;
        elseif b==1   
            % Top
            G(:,n) = 0; 
            G(n,n) = 1;
        elseif b==ny
            %Bottom
            G(:,n) = 0; 
            G(n,n) = 1;
        elseif (a>20&a<30&b>10&b<20)
            % Interference Window (Bottleneck)
            nxm= a-1 +(b-1)*nx;
            nxp= a+1 +(b-1)*nx;
            nym= a +(b-2)*nx;
            nyp= a +(b)*nx;
            
            G(n,n) = -2;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        else
            %All Central Nodes
            nxm= a-1 +(b-1)*nx;
            nxp= a+1 +(b-1)*nx;
            nym= a +(b-2)*nx;
            nyp= a +(b)*nx;
            
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
    end
end
figure(1)
grid on
spy(G)
[E,D]=eigs(G,9,'SM')

figure(2)
plot(D)

figure(3)
mesh(E)
 

Sol=zeros(nx,ny,9);

for c=1:9
    Sol(:,:,c)= reshape(E(:,c),nx,ny);
end


figure(4)
subplot(3,3,1)
surf(Sol(:,:,1))
subplot(3,3,2)
surf(Sol(:,:,2))
subplot(3,3,3)
surf(Sol(:,:,3))
subplot(3,3,4)
surf(Sol(:,:,4))
subplot(3,3,5)
surf(Sol(:,:,5))
subplot(3,3,6)
surf(Sol(:,:,6))
subplot(3,3,7)
surf(Sol(:,:,7))
subplot(3,3,8)
surf(Sol(:,:,8))
subplot(3,3,9)
surf(Sol(:,:,9))
colormap spring
 

