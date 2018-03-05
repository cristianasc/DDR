% 10^-3 or higher -> estado 3 e 4
% probabilidade do estado estar em interferencia pi3 + pi4

pi3 = pi0*(((1*5*5)/(200*50*50)));
pi4 = pi0*(((1*5*5*10)/(200*50*50*10)));

p_interference = pi3 + pi4

% calcular o tempo até que ele saia dos estados 3 e 4

t3 = (1/(50+10))*60
t4 = (1/10)*60

p32 = 50/60;
p34 = 10/60;
p43 = 1;

c=0

for i = 0:10
    c = c + p32*(p34^i) * (i*t4 + (i+1)*t3);
end