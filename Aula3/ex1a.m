lambda = [10 20 30 40 10 20 30 40 100 200 300 400 100 200 300 400];
C =  [100 100 100 100 100 100 100 100 1000 1000 1000 1000 1000 1000 1000 1000];
M = [4 4 4 4 10 10 10 10 4 4 4 4 10 10 10 10];
u = 86.3; 

for i= 1:16
    ro = (lambda(i)*u)/60;
    N=C(i)/M(i);
    prob(ro, N);
    media = L(ro, N)*M(i)
end



function [p] = prob (ro,N)
    a= 1; p= 1;
    for n= N:-1:1
        a= a*n/ro;
        p= p+a;
    end
    p= (1/p)*100
end 
    
function [o] = L (ro, N)
    a= N;
    numerator= a;
    for i= N-1:-1:1
        a= a*i/ro;
        numerator= numerator+a;
    end
    a= 1;
    denominator= a;
    for i= N:-1:1
        a= a*i/ro;
        denominator= denominator+a;
    end
    o= numerator/denominator;
end 



    
    

