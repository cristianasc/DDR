% P(N) = p(1,2,3,4)
% P(I) = 1 - p(1,2,3,4)


errors_normal_state = 0.01/100; % P(E/N)
errors_interference_state = 50/100; % P(E/I)

pN_n1 = 1 - errors_normal_state^2;  % P(E/N)
pN_n2 = 1 - errors_normal_state^3;  % P(E/N)
pN_n3 = 1 - errors_normal_state^4;  % P(E/N)
pN_n4 = 1 - errors_normal_state^5;  % P(E/N)

pI_n1 = 1 - errors_interference_state^2;  % P(E/I)
pI_n2 = 1 - errors_interference_state^3;  % P(E/I)
pI_n3 = 1 - errors_interference_state^4;  % P(E/I)
pI_n4 = 1 - errors_interference_state^5;  % P(E/I)


% P(E) => probabilidade de serem recebidas frames com erros
% P(I/E) = P(E/I)*P(I)/(P(E/I)*P(I) + P(E/N)*P(N))
% P(E) = P(E/I)*P(I) + P(E/N)*P(N)

p1 = 0.99;
p2 = 0.999;
p3 = 0.9999;
p4 = 0.99999;


% P1
% para n = 2
p1E2_N = (pI_n1*(1-p1))/(pN_n1*p1 + pI_n1*(1-p1))

% para n = 3
p1E3_N = (pI_n2*(1-p1))/((pN_n2*p1) + pI_n2*(1-p1))

% para n = 4
p1E4_N = (pI_n3*(1-p1))/((pN_n3*p1) + pI_n3*(1-p1))

%para n = 5
p1E5_N = (pI_n4*(1-p1))/((pN_n4*p1) + pI_n4*(1-p1))

% P2
% para n = 2
p2E2_N = (pI_n1*(1-p2))/((pN_n1*p2) + pI_n1*(1-p2));

% para n = 3
p2E3_N = (pI_n2*(1-p2))/((pN_n2*p2) + pI_n2*(1-p2));

% para n = 4
p2E4_N = (pI_n3*(1-p2))/((pN_n3*p2) + pI_n3*(1-p2));

%para n = 5
p2E5_N = (pI_n4*(1-p2))/((pN_n4*p2) + pI_n4*(1-p2));

% P3
% para n = 2
p3E2_N = (pI_n1*(1-p3))/((pN_n1*p3) + pI_n1*(1-p3));

% para n = 3
p3E3_N = (pI_n2*(1-p3))/((pN_n2*p3) + pI_n2*(1-p3));

% para n = 4
p3E4_N = (pI_n3*(1-p3))/((pN_n3*p3) + pI_n3*(1-p3));

%para n = 5
p3E5_N = (pI_n4*(1-p3))/((pN_n4*p3) + pI_n4*(1-p3));

% P4
% para n = 2
p4E2_N = (pI_n1*(1-p4))/((pN_n1*p4) + pI_n1*(1-p4));

% para n = 3
p4E3_N = (pI_n2*(1-p4))/((pN_n2*p4) + pI_n2*(1-p4));

% para n = 4
p4E4_N = (pI_n3*(1-p4))/((pN_n3*p4) + pI_n3*(1-p4));

%para n = 5
p4E5_N = (pI_n4*(1-p4))/((pN_n4*p4) + pI_n4*(1-p4));



