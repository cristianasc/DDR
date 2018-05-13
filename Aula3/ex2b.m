N = 10; %número de simulações
results= zeros(1,N); %vetor com os N resultados de simulação
results2 = zeros(1,N);
lambda = [10 20 30 40 10 20 30 40 100 200 300 400 100 200 300 400];
C =  [100 100 100 100 100 100 100 100 1000 1000 1000 1000 1000 1000 1000 1000];
M = [4 4 4 4 10 10 10 10 4 4 4 4 10 10 10 10];
R=5000;


for i = 1:16
    for it= 1:N
        [results(it), results2(it)] = simulator1(lambda(i),C(i),M(i),R);
    end
    confidence_interval90(results, N, "b", i);
    confidence_interval90(results2, N, "o", i);
end

function [termo] = confidence_interval90(results, N, type, i)
    alfa= 0.1; %intervalo de confiança a 90%
    media = mean(results);
    termo = norminv(1-alfa/2)*sqrt(var(results)/N);
    fprintf('resultado %s%d = %.2e +- %.2e\n', type, i, vpa(media),vpa(termo))
end

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
    while NARRIVALS < R
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