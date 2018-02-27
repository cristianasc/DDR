% falsos negativo é quando uma estação decide erradamente que o link está
% em estado normal

% P(N) = p(1,2,3,4)
% P(I) = 100 - p(1,2,3,4)

% numero de frames que se analisam para verificar se há erros ou nao
n1 = 2;
n2 = 3;
n3 = 4;
n4 = 5;

errors_normal_state = 0.01/100; % P(E/N)
errors_interference_state = 50/100; % P(E/I)

pN_n1 = errors_normal_state^2;  % P(N/E)
pN_n2 = errors_normal_state^3;  % P(N/E)
pN_n3 = errors_normal_state^4;  % P(N/E)
pN_n4 = errors_normal_state^5;  % P(N/E)

pI_n1 = errors_interference_state^2;  % P(I/E)
pI_n2 = errors_interference_state^3;  % P(I/E)
pI_n3 = errors_interference_state^4;  % P(I/E)
pI_n4 = errors_interference_state^5;  % P(I/E)

% P(E) => probabilidade de serem recebidas frames com erros
% P(E/I) = P(I/E)*P(E)/(P(I/E)*P(E) + P(N/E)*P(E))
% P(E) = P(E/I)*P(I) + P(E/N)*P(N)

p1 = 99/100;
p2 = 99.9/100;
p3 = 99.99/100;
p4 = 99.999/100;

p_E_p1 = (errors_interference_state*(1-p1) + errors_normal_state*p1);
p_E_p2 = (errors_interference_state*(1-p2) + errors_normal_state*p2);
p_E_p3 = (errors_interference_state*(1-p3) + errors_normal_state*p3);
p_E_p4 = (errors_interference_state*(1-p4) + errors_normal_state*p4);

% P1
% para n = 2
p1E2_N = vpa((pI_n1*p_E_p1^2)/(pN_n1*p_E_p1^2 + pI_n1*p_E_p1^2))

% para n = 3
p1E3_N = (pI_n2*p_E_p1^3)/((pN_n2*p_E_p1^3) + pI_n2*p_E_p1^3)

% para n = 4
p1E4_N = (pI_n3*p_E_p1^4)/((pN_n3*p_E_p1^4) + pI_n3*p_E_p1^4)

%para n = 5
p1E5_N = (pI_n4*p_E_p1^5)/((pN_n4*p_E_p1^5) + pI_n4*p_E_p1^5)

% P2
% para n = 2
p2E2_N = (pN_n1*p_E_p2)/((pN_n1*p_E_p2^2) + pI_n1*p_E_p2^2);

% para n = 3
p2E3_N = (pN_n2*p_E_p2)/((pN_n2*p_E_p2^3) + pI_n2*p_E_p2^3);

% para n = 4
p2E4_N = (pN_n3*p_E_p2)/((pN_n3*p_E_p2^4) + pI_n3*p_E_p2^4);

%para n = 5
p2E5_N = (pN_n4*p_E_p2)/((pN_n4*p_E_p2^5) + pI_n4*p_E_p2^5);

% P3
% para n = 2
p3E2_N = (pN_n1*p_E_p3)/((pN_n1*p_E_p3^2) + pI_n1*p_E_p3^2);

% para n = 3
p3E3_N = (pN_n2*p_E_p3)/((pN_n2*p_E_p3^3) + pI_n2*p_E_p3^3);

% para n = 4
p3E4_N = (pN_n3*p_E_p3)/((pN_n3*p_E_p3^4) + pI_n3*p_E_p3^4);

%para n = 5
p3E5_N = (pN_n4*p_E_p3)/((pN_n4*p_E_p3^5) + pI_n4*p_E_p3^5);

% P4
% para n = 2
p4E2_N = (pN_n1*p_E_p4)/((pN_n1*p_E_p4^2) + pI_n1*p_E_p4^2);

% para n = 3
p4E3_N = (pN_n2*p_E_p4)/((pN_n2*p_E_p4^3) + pI_n2*p_E_p4^3);

% para n = 4
p4E4_N = (pN_n3*p_E_p4)/((pN_n3*p_E_p4^4) + pI_n3*p_E_p4^4);

%para n = 5
p4E5_N = (pN_n4*p_E_p4)/((pN_n4*p_E_p4^5) + pI_n4*p_E_p4^5);


