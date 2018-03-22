close all 
clear all

n=200; %number of division of V

Is=0.01e-12; %A
Ib=-0.1e-12; %A
Vb=1.3; %V
Gp=0.1; %mhos

I = zeros(1,n);
Inoisy = zeros(1,n);
it=0;
V = linspace(-1.95,0.7,n);
for a=V
    it=it+1;
    
    idealdiode=Is*(exp(1.2*a/0.025)-1);
    parallelR=Gp*a;
    breakdown=Ib*exp(-1.2/0.025*(a +Vb));
    
    I(it)=idealdiode+parallelR+breakdown;
    
    Inoisy(it)= randn()*I(it)*0.2 + I(it);
 
end


four=polyfit(V,I,4);
Ifour = polyval(four,V);

eight=polyfit(V,I,8);
Ieight = polyval(eight,V);

figure
plot(V,I)
hold on;
plot(V,Inoisy)
xlabel('Input Voltage')
ylabel('A')


figure
semilogy(V,abs(I));
hold on
semilogy(V,abs(Inoisy));
xlabel('Input Voltage')
ylabel('A')


figure
plot(V,I)
hold on;
plot(V, Ifour,'o')
plot(V,Ieight,'*')

fo=fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3))');
ff=fit(V.',I.',fo);
If=ff(V);

figure
plot(V,I)
hold on;
plot(If, V,'*')

fo=fittype('A.*(exp(1.2*x/25e-3)-1) +Gp.*x - C*(exp(1.2*(-(x+Vb))/25e-3))');
ff2=fit(V.',I.',fo);
If2=ff2(V);

figure
plot(I,V)
hold on;
plot(If2, V,'*')

inputs = V.';
targets = I.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)
view(net)
Inn = outputs
