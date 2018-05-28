function [AverageDelay,max_delay]  = Evaluate(CurrentSolution, lambda)
    Matrizes;
    miu= R*1e9/(8*1000);
    T(:,3:4)= T(:,3:4)*1e6/(8*1000);
    gama= sum(sum(T(:,3:4)));
    d= L*1e3/2e8;
    nT= size(T,1);
    
    % Kleinrock aproximation => network average delay
    AverageDelay = (lambda./(miu-lambda)+lambda.*d);
    AverageDelay(isnan(AverageDelay)) = 0;
    AverageDelay = sum(sum(AverageDelay))/gama;
    AverageDelay = AverageDelay*2; %ida e volta => descomentar para ver o resultado

    delay_flows = zeros(nT,1);

    for i=1:nT
        origin= T(i,1);
        destination= T(i,2);
        r= ShortestPathSym(d,origin,destination); 
        CurrentSolution(i,:)= r;
        j=1;
        while CurrentSolution(i, j)~= destination
            delay_flows(i) = delay_flows(i) + (1/(miu(CurrentSolution(i, j),CurrentSolution(i, j+1))-lambda(CurrentSolution(i, j),CurrentSolution(i, j+1))) + d(CurrentSolution(i, j),CurrentSolution(i, j+1)));
            delay_flows(i) = delay_flows(i) + (1/(miu(CurrentSolution(i, j+1),CurrentSolution(i, j))-lambda(CurrentSolution(i, j+1),CurrentSolution(i, j))) + d(CurrentSolution(i, j+1), CurrentSolution(i, j)));
            j= j+1;
        end
    end
    
    max_delay = max(delay_flows);
end
