link = 54*10^6;
timegap = 10*10^(-6);

fcs = 4;
header = 36;

datafield = linspace(1, 100, 100);
A = (datafield*8)/link;
B = timegap+A+((header*8)/link)+((fcs*8)/link);
datarate = 54*(A./B);

q = logspace(-8,-3,100);
i=0;
n= 140*8;
f = 1-(1-q).^n;

semilogx(q,f,'k')
grid on
xlabel('Bit Error Rate')
ylabel('Packet Discard probability')

hold on
n= 240*8;
f = 1-(1-q).^n;
semilogx(q,f,'r')

hold on
n= 1400*8;
f = 1-(1-q).^n;
semilogx(q,f,'b')

hold on
n= 8400*8;
f = 1-(1-q).^n;
semilogx(q,f,'g')
legend('n=140*8', 'n=240*8', 'n=1040*8', 'n=8040*8;')








