% I - estado de interferência
% N - estado normal
% E - recebida com erros

p1 = 0.99;
p2 = 0.999;
p3 = 0.9999;
p4 = 0.99999;

errors_normal_state = 0.01/100; % P(E/N)
errors_interference_state = 50/100; % P(E/I)

% P(N) = p(1,2,3,4)
% P(I) = 100 - p(1,2,3,4)

% calcular a probabilidade de estar em estado de interferencia dado que foi
% recebida uma frame com erros

% P(I/E) = P(E/I)*P(I)/P(E)
% P(E) = P(E/I)*P(I) + P(E/N)*P(N)

p_i1 = errors_interference_state*(1-p1)/(errors_interference_state*(1-p1) + errors_normal_state*p1)
p_i2 = errors_interference_state*(1-p2)/(errors_interference_state*(1-p2) + errors_normal_state*p2)
p_i3 = errors_interference_state*(1-p3)/(errors_interference_state*(1-p3) + errors_normal_state*p3)
p_i4 = errors_interference_state*(1-p4)/(errors_interference_state*(1-p4) + errors_normal_state*p4)

% conclusao: quanto maior a probabilidade de estar em estado normal, menor
% a possibilidade de estar em estado de interferência dado que recebeu uma
% trama com erros

% agora vamos calcular a probabilidade de estar no estado normal dado que
% recebeu uma frame com erros

p_n1 = 1 - p_i1
p_n2 = 1 - p_i2
p_n3 = 1 - p_i3
p_n4 = 1 - p_i4