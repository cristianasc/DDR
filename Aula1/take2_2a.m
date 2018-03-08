% I - estado de interferência
% N - estado normal
% E - recebida com erros

p = [0.99 0.999 0.9999 0.99999];

errors_normal_state = 0.01/100; % P(E/N)
errors_interference_state = 50/100; % P(E/I)

% P(N) = p(1,2,3,4)
% P(I) = 100 - p(1,2,3,4)

% calcular a probabilidade de estar em estado de interferencia dado que foi
% recebida uma frame com erros

% P(I/E) = P(E/I)*P(I)/P(E)
% P(E) = P(E/I)*P(I) + P(E/N)*P(N)

for i=1:length(p)

p_i(i) = errors_interference_state*(1-p(i))/(errors_interference_state*(1-p(i)) + errors_normal_state*p(i));
p_ni(i) = 1 - p_i(i);

end
% conclusao: quanto maior a probabilidade de estar em estado normal, menor
% a possibilidade de estar em estado de interferência dado que recebeu uma
% trama com erros

% agora vamos calcular a probabilidade de estar no estado normal dado que
% recebeu uma frame com erros

p_i
p_ni
