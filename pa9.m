close all
clear all

R1=1;
c=0.25;
R2=2;
L=0.2;
R3=10;
a=100;
R4=0.1;
R0=1000;

F = [1 0 0 0 0 0];
C=[0 0 0 0 0 0; 
    0 0 0 L 0 0; 
    0 0 0 0 0 0;
    -c c 0 0 0 0; 
    0 0 0 0 0 0;
    0 0 0 0 0 0];
G=[1 0 0 0 0 0; 
    0 1 -1 0 0 0; 
    0 0 1/R3 -1 0 0;
    -1/R1 ((R1+R2)/(R1*R2)) 0 1 0 0; 
    0 0 0 -a 1 0;
    0 0 0 0 -R0 (R0+R4)];

% DC case
out= zeros(21,6);
in= zeros(1,21);
it=0;
for vin= -10:1:10
    it=it+1;
    F(1)=vin;
    V=G\F';
    
    out(it,:)=V;
    in(it) = vin;
end

plot(in,out(:,6))
title('Vout')
xlabel('Vin sweep from -10V to 10V')

figure
plot(in,out(:,3))
title('V3')
xlabel('Vin sweep from -10V to 10V')

%AC case - frequency sweep
out= zeros(1001,6);
in= zeros(1,1001);
it=0;
for w= 1:1:1000
    it=it+1;
  
    V=(G+1j*w*C)\F';
    
    out(it,:)=V;
    in(it) = w;
end

figure
semilogx(in,out(:,6))
title('Vout')
xlabel('frequency sweep from 1Hz to 1kHz')


figure
semilogx(in,20*log10(out(:,6)/out(:,1)))
title('gain over frequency (BODE)')
xlabel('frequency sweep from 1Hz to 1kHz')

%AC case - capacitance sweep
n=1000;
out= zeros(n,6);
gain= zeros(1,n);
it=0;
w=pi;
 cs=0.25+0.05*randn(1,n);
for a=1:n
   c=cs(a);
  C=[0 0 0 0 0 0; 
    0 0 0 L 0 0; 
    0 0 0 0 0 0;
    -c c 0 0 0 0; 
    0 0 0 0 0 0;
    0 0 0 0 0 0];
    
    V=(G+1j*w*C)\F';
     out(a,:)=V;
    gain(a) = (abs(V(6))/abs(V(1)));
  
end


figure
histogram(gain,100)
title('gain as a function of capacitance')
xlabel('gain')

