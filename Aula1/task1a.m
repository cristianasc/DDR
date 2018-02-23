link = 54*10^6;
timegap = 10*10^(-6);
q = 0;
fcs = 4;
header = 36;

datafield = linspace(100,8000,100);
A = (datafield*8)/link;
B = timegap+A+((header*8)/link)+((fcs*8)/link);
datarate = 54*(A./B);
plot(datafield,datarate,'k');
grid on
xlabel('Data Field (Bytes)')
ylabel('Data Rate (Seconds)')
legend('54*(A/B)');


