link = 54*10^6;
timegap = 10*10^(-6);
fcs = 4;
header = 36;

q = logspace(-8,-3,100);
datafield1= 100;
datafield2= 200;
datafield3= 1000;
datafield4= 8000;

A1 = (datafield1*8)/link;
A2 = (datafield2*8)/link;
A3 = (datafield3*8)/link;
A4 = (datafield4*8)/link;

B1 = timegap+A1+((header*8)/link)+((fcs*8)/link);
B2 = timegap+A2+((header*8)/link)+((fcs*8)/link);
B3 = timegap+A3+((header*8)/link)+((fcs*8)/link);
B4 = timegap+A4+((header*8)/link)+((fcs*8)/link);

datarate1 = 54*(A1/B1);
datarate2 = 54*(A2/B2);
datarate3 = 54*(A3/B3);
datarate4 = 54*(A4/B4);

f1 = ((1-q).^((datafield1+40)*8))*datarate1;
f2 = ((1-q).^((datafield2+40)*8))*datarate2;
f3 = ((1-q).^((datafield3+40)*8))*datarate3;
f4 = ((1-q).^((datafield4+40)*8))*datarate4;

semilogx(q,f1,q,f2,q,f3,q,f4)
grid on
xlabel('Bit Error Rate')
ylabel('Data Rate (Seconds)')
legend('B=100', 'B=200', 'B=1000', 'B=8000')
