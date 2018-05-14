
%os valores teoricos (os da tabela da alinea a) devem estar dentro do valor
%resultado do simulados ± o intervalo de confiança

N = 40; %número de simulações
results= zeros(1,N); %vetor com os N resultados de simulação
results2 = zeros(1,N);
subscribers = 3000*10 + 1500*25;
%lambda = 2 /(7*24);
%lambda = lambda * subscribers;
%lambda = [10 20 30 40 10 20 30 40 100 200 300 400 100 200 300 400];
lambda = [10 10 10 10 10 10 30 30 30 30 30 30];
C =  [100 100 100 100 100 100 100 100 1000 1000 1000 1000 1000 1000 1000 1000];
M = [4 4 4 4 10 10 10 10 4 4 4 4 10 10 10 10];
R=50000;
P = 0.3;

W = 4000;
S = 73;
MHD = 4;
M4K = 10;

% SIMULADOR 2 - EXERCICIO 3B
% valor para S=72 , W=3900 (resultado bhd0 = 1.40e+00 +- 1.38e-01;
% resultado b4k0 = 1.84e+00 +- 1.32e-01)
% valor para S=73, W = 4000; resultado bhd0 = 1.30e+00 +- 1.35e-01; resultado b4k0 = 1.01e+00 +- 1.59e-01
 %for it= 1:N
 %    [results(it), results2(it)] = simulator2(lambda,P,S,W,MHD,M4K,R);
 %end
 %confidence_interval90(results, N, "bhd", 0);
 %confidence_interval90(results2, N, "b4k", 0);


% for i = 1:16
%     for it= 1:N
%         [results(it), results2(it)] = simulator1(lambda(i),C(i),M(i),R);
%     end
%     confidence_interval90(results, N, "b", i);
%     confidence_interval90(results2, N, "o", i);
% end
% 
 %function [termo] = confidence_interval90(results, N, type, i)
 %    alfa= 0.1; %intervalo de confiança a 90%
 %    media = mean(results);
 %    termo = norminv(1-alfa/2)*sqrt(var(results)/N);
 %    fprintf('resultado %s%d = %.2e +- %.2e\n', type, i, vpa(media),vpa(termo))
%end


% SIMULADOR 2A)
% for i = 1:12
%     for it= 1:N
%         [results(it), results2(it)] = simulator2(lambda(i),P(i),S(i),W(i),MHD,M4K,R);
%     end
%     confidence_interval90(results, N, "bhd", i);
%     confidence_interval90(results2, N, "b4k", i);
% end
%  
% function [termo] = confidence_interval90(results, N, type, i)
%     alfa= 0.1; %intervalo de confiança a 90%
%     media = mean(results);
%     termo = norminv(1-alfa/2)*sqrt(var(results)/N);
%     fprintf('resultado %s%d = %.2e +- %.2e\n', type, i, vpa(media),vpa(termo))
% end

%o número de servidores (exemplo S=15) ideal tem que dar uma probabilidade menor que 0.1 
%o numero anterior (exemplo S=14) tem que dar menor que 1%
% SIMULADOR 2B)
%for i = 1:12
%    for it= 1:N
%        [results(it), results2(it)] = simulator2((20000/(24*7)),0.3,15,0,MHD,M4K,R);
%    end
%    confidence_interval90(results, N, "bhd", i);
%    confidence_interval90(results2, N, "b4k", i);
%end
 
%function [termo] = confidence_interval90(results, N, type, i)
%    alfa= 0.1; %intervalo de confiança a 90%
%    media = mean(results);
%    termo = norminv(1-alfa/2)*sqrt(var(results)/N);
%    fprintf('resultado %s%d = %.2e +- %.2e\n', type, i, vpa(media),vpa(termo))
%end



function [b o]= simulator1(lambda,C,M,R)
    %lambda = request arrival rate (in requests per hour) %C= Internet connection capacity (in Mbps)
    %M= throughput of each movie (in Mbps)
    %R= stop simulation on ARRIVAL no. R
    
    invlambda=60/lambda; %average time between requests (in minutes) 
    invmiu= load('movies.txt'); %duration (in minutes) of each movie 
    Nmovies= length(invmiu); % number of movies
    
    %Events definition:
    ARRIVAL= 0; %movie request
    DEPARTURE= 1; %termination of a movie transmission %State variables initialization:
    STATE= 0;
    
    %Statistical counters initialization:
    LOAD= 0;
    NARRIVALS= 0;
    BLOCKED= 0;
    
    %Simulation Clock and initial List of Events:
    Clock= 0;
    EventList= [ARRIVAL exprnd(invlambda)];
    while NARRIVALS < R + N
        event= EventList(1,1);
        Previous_Clock= Clock;
        Clock= EventList(1,2);
        EventList(1,:)= [];
        LOAD= LOAD + STATE*(Clock-Previous_Clock); 
        if event == ARRIVAL
            EventList= [EventList; ARRIVAL Clock+exprnd(invlambda)]; 
            NARRIVALS= NARRIVALS+1;
            if STATE + M <= C
                STATE= STATE+M;
                EventList= [EventList; DEPARTURE Clock+invmiu(randi(Nmovies))];
            else
                BLOCKED= BLOCKED+1;
            end
        else
            STATE= STATE-M;
        end
        EventList= sortrows(EventList,2);
    end
    b= 100*BLOCKED/NARRIVALS; % blocking probability in %   
    o= LOAD/Clock; % average connection occupation in Mbps
end

function [bhd, b4k]= simulator2(lambda,P,S,W,MHD,M4K,R)
    %lambda = request arrival rate (in requests per hour)
    %P = percentage of requests for 4K movies (in %)
    %S = number of servers (each server with a capacity of 100 Mbps)
    %W = resource reservation for high-definition movies (in Mbps)
    %MHD = throughput of movies in HD format (4 Mbps)
    %M4K = throughput of movies in 4K format (10 Mbps)
    %R= stop simulation on ARRIVAL no. R
    
    N_C=100; % node capacity
    C = S * N_C;
    
    invlambda=60/lambda; % average time between requests (in minutes) 
    invmiu= load('movies.txt'); % duration (in minutes) of each movie 
    Nmovies= length(invmiu); % number of movies
    
    %Events definition:
    %movie request
    ARRIVAL_HD= 0; 
    ARRIVAL_4K = 1;
    
    %termination of a movie transmission
    DEPARTURE_4K = 2;
    DEPARTURE_HD = 3; 
    
    %State variables initialization:
    STATE = zeros(1,S); %total throughput of the movies in transmission by server i (i = 1,...,S)
    STATE_HD = 0; %total throughput of HD movies in transmission
    
    %Statistical counters initialization:
    NARRIVALS = 0;
    NARRIVALS_HD = 0;
    NARRIVALS_4K = 0;
    BLOCKED_HD = 0;
    BLOCKED_4K = 0;
    if rand() < P
        EventList= [ARRIVAL_4K exprnd(invlambda) 0];
    else
        EventList= [ARRIVAL_HD exprnd(invlambda) 0];
    end
    
    EventList= sortrows(EventList,2);
    
    while NARRIVALS < R
        event= EventList(1,1);
        Clock= EventList(1,2);
        node = EventList(1,3);
        EventList(1,:)= [];
        
        if event == ARRIVAL_HD || event == ARRIVAL_4K
            % must choose the server with less load
            loadbalancer = find(STATE==min(STATE));
            server = loadbalancer(1);
            NARRIVALS= NARRIVALS+1;
            
            if rand() < P
                EventList= [EventList; ARRIVAL_4K Clock+exprnd(invlambda) 0];
            else
                EventList= [EventList; ARRIVAL_HD Clock+exprnd(invlambda) 0];
            end
            
            if event == ARRIVAL_HD % verify if it's a HD ARRIVAL
                NARRIVALS_HD = NARRIVALS_HD + 1;
            
                if STATE(server) + MHD <= N_C && STATE_HD + MHD <= (C - W)
                    STATE(server) = STATE(server) + MHD;
                    STATE_HD = STATE_HD + MHD;
                    EventList= [EventList; DEPARTURE_HD Clock+invmiu(randi(Nmovies)) server];   
                    
                else
                    BLOCKED_HD = BLOCKED_HD + 1;
                end
                
            else
                NARRIVALS_4K = NARRIVALS_4K + 1;

                if STATE(server) + M4K <= N_C % servidor tem que ter pelo menos banda Mh disponivel
                    STATE(server) = STATE(server) + M4K;
                    EventList= [EventList; DEPARTURE_4K Clock+invmiu(randi(Nmovies)) server];
                else
                    BLOCKED_4K = BLOCKED_4K + 1;
                end
                
            end
        else % it's a departure
            if event == DEPARTURE_HD
                STATE(node)= STATE(node) - MHD;
                STATE_HD = STATE_HD - MHD;
            else 
                STATE(node)= STATE(node) - M4K;
            end
        end
        EventList= sortrows(EventList,2);
    end
    bhd= 100*BLOCKED_HD/NARRIVALS_HD; % blocking probability in %   
    b4k= 100*BLOCKED_4K/NARRIVALS_4K; % blocking probability in %
end