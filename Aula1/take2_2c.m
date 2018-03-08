% P(N) = p(1,2,3,4)
% P(I) = 1 - p(1,2,3,4)

errors_normal_state = 0.01/100; % P(E/N)
errors_interference_state = 50/100; % P(E/I)

n = [2 3 4 5];

for i=1:length(n)
    pN_n(i) = 1 - errors_normal_state^(n(i));
    pI_n(i) = 1 - errors_interference_state^(n(i));
    
end

p = [0.99 0.999 0.9999 0.99999];

for i=1:length(p)
    piE2_N(i) = (pI_n(1)*(1-p(i)))/(pN_n(1)*p(i) + pI_n(1)*(1-p(i)));
    piE3_N(i) = (pI_n(2)*(1-p(i)))/(pN_n(2)*p(i) + pI_n(2)*(1-p(i)));
    piE4_N(i) = (pI_n(3)*(1-p(i)))/(pN_n(3)*p(i) + pI_n(3)*(1-p(i)));
    piE5_N(i) = (pI_n(4)*(1-p(i)))/(pN_n(4)*p(i) + pI_n(4)*(1-p(i)));  
end

piE2_N
piE3_N
piE4_N
piE5_N
