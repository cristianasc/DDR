x = logspace(0,3,100);
f=1./(x.^2+1);
plot(x,f,'k');
semilogx(x,f,'k');
grid on
xlabel('x')
ylabel('y')
hold on
g = 1./(x+1);
semilogx(x,g,'b');
legend('f(x)=1./(x.^2+1)', 'g(x)=1./(x+1)');