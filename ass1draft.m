L=200e-9;
W=100e-9;
n=10; %change
nsteps =1000; %change


ang=randn(1,n)*2*pi;

pscat=0.05;

m0=9.109e-31;
mn=0.26*m0;
T=300;
k=1.38e-23;
tau=0.2e-9; %sec
 
vth = sqrt(2*k*T/mn)
% d=tau*vf; 
% (d=mean free path)
% is fermi velocity the same as thermal velocity? if not, are they related? 

x=rand(1,n)*L;
y=rand(1,n)*W;

vx=vth*rand(1,n).*cos(ang);
vy=vth*rand(1,n).*sin(ang);

dt=(L/vth)/100;

for i=1:nsteps

    xp=x;
    yp=y;

    dx=vx*dt;
    dy=vy*dt;
git commit -m "update"
    x=x+dx;
    y=y+dy;

    xpath=abs(x-xp); %xpath calc before bounday adjustment
    
    %scattering
    if (pscat > rand())
        q=round(rand())*n;
        if (q==0)
            q=1;
        end
        vx(q)=vth*rand();
        vy(q)=vth*rand();
    end
    
    %periodic boundaries for walls
     for a=1:n
        if (x(a)>L)
            x(a)=x(a)-L;
        elseif x(a)<0
            x(a) = x(a)+L;
        end
    %specular boundaries for ceiling and floor
        if y(a)>=W
            vy(a) = -vy(a);
         elseif y(a)<=0
            vy(a) = -vy(a);
        end
     end

 

     

    ypath=abs(y-yp); %ypath calc after boundary adjustment

    

    path = sqrt(xpath.*xpath + ypath.*ypath);

    

    plot(x,y,'*')
    hold on
    xlim([0 L])

    ylim([0 W])

    pause(0.01);

        

end

 

meanfreepath = mean(path)

Temp = abs(mean(vx)+mean(vy))*mn/(2*k) %why doesn't this work?

