link = 54*10^6;
timegap = 10*10^(-6);
fcs = 4;
header = 36;

q=logspace(-8,-3,100);

aux = zeros(7900,100);

p=0.025;

for n=0:7900
    A = (((n)+100)*8)/link;
    B = timegap+A+((header*8)/link)+((fcs*8)/link);
    datarate = 54*(A/B);
    x = ((1-q).^(n+100*8)).*datarate;
    aux(n+1,:) = x*p*((1-p)^n);
end
res = sum(aux);

semilogx(q,res,'k')
grid on
xlabel('Bit Error Rate')
ylabel('Data Rate (Seconds)')

