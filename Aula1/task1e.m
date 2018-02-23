link = 54*10^6;
timegap = 10*10^(-6);
fcs = 4;
header = 36;

q=logspace(-8,-3,7900);
p=0.025;

A = (((0:7900)+100)*8)/link;
B = timegap+A+((header*8)/link)+((fcs*8)/link);
datarate = 54*(A/B);

f = ((1-q).^((((0:7900)+100)+40)*8))*datarate;

% probabilidades para bytes de 100 a 8000 
% parece que as probabildades dão 0, mas são é muito pequenas, no total dá 1
pTotal = f.*[p*(1-p).^(0:1:7900)];

pTotal = sum(pTotal);

semilogx(q,pTotal)
grid on
xlabel('Data Field (Bytes)')
ylabel('Data Rate (Seconds)')
