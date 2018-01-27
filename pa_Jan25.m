%electron simulation 1D
x=0;
v=0;
F=1;
m=1;

dt=0.1;

nsteps=100;

Ps=0.05;
scat=rand(1,nsteps);

for i=1:nsteps
   vp=v;
    ip=i-1;
    dv=F*dt/m;
    v=v+dv;
    
     if scat(i)>Ps
         v=0;
     end 
   
    dx= v*dt;
    x = x+dx;
    
    plot([i-1 i],[v vp],'*')
    hold on
    pause(0.01)
    
end