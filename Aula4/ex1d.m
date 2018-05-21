Matrizes;
miu= R*1e9/(8*1000);
NumberLinks= sum(sum(R>0));
T(:,3:4)= T(:,3:4)*1e6/(8*1000);
gama= sum(sum(T(:,3:4)));
d= L*1e3/2e8;
nT= size(T,1);
lambda= zeros(20);
routes= zeros(nT,20);

for i=1:nT
    Load= lambda./miu;
    origin= T(i,1);
    destination= T(i,2);
    lambda_od= T(i,3);
    lambda_do= T(i,4);
    r= ShortestPathSym(Load,origin,destination); 
    routes(i,:)= r;
    j= 1;
    while r(j)~= destination
        lambda(r(j),r(j+1))= lambda(r(j),r(j+1)) + lambda_od; 
        lambda(r(j+1),r(j))= lambda(r(j+1),r(j)) + lambda_do; 
        j= j+1;
    end
end

Load = lambda./miu;
Load(isnan(Load))= 0;
MaximumLoad = max(max(Load))
AverageLoad = sum(sum(Load))/NumberLinks

% Kleinrock aproximation => network average delay
RTDelay = (lambda./(miu-lambda)+lambda.*d);
RTDelay(isnan(RTDelay)) = 0;
RTDelay = sum(sum(RTDelay))/gama;
RTDelay = RTDelay*2 %ida e volta => descomentar para ver o resultado

% o máximo delay médio de todos os fluxos
delay_flows = zeros(nT,1);

for i=1:nT
    origin= T(i,1);
    destination= T(i,2);
    r= ShortestPathSym(d,origin,destination); 
    routes(i,:)= r;
    j=1;
    while r(j)~= destination
        delay_flows(i) = delay_flows(i) + (1/(miu(r(j),r(j+1))-lambda(r(j),r(j+1))) + d(r(j),r(j+1)));
        delay_flows(i) = delay_flows(i) + (1/(miu(r(j+1),r(j))-lambda(r(j+1), r(j))) + d(r(j+1), r(j)));
        j= j+1;
    end
end

delay_flows = sortrows(delay_flows, -1); %ordenar de forma decrescente
max_delay = delay_flows(1) %ir buscar o pior valor

subplot(1,2,1)
plot(delay_flows)
grid on
title('Average packet round-trip delay of each flow') 

subplot(1,2,2)
graph_load = sortrows(Load(:), -1);  %ordenar de forma decrescente
graph_load = graph_load(1:NumberLinks);
plot(graph_load)
grid on
title('Load of each link') 