link = 54*10^6;
timegap = 10*10^(-6);
fcs = 4;
header = 36;

q = logspace(-8,-3,100);
datafield1= 100;
datafield2= 1500;

A1 = (datafield1*8)/link;
B1 = timegap+A1+((header*8)/link)+((fcs*8)/link);
datarate1 = 54*(A1/B1);

A2 = (datafield2*8)/link;
B2 = timegap+A2+((header*8)/link)+((fcs*8)/link);
datarate2 = 54*(A2/B2);

f1 = ((1-q).^((datafield1+40)*8))*datarate1;
f2 = ((1-q).^((datafield2+40)*8))*datarate2;

total = 0.3*f1 + 0.7*f2;

semilogx(q,total)
grid on
xlabel('Bit Error Rate')
ylabel('Data Rate (Seconds)')