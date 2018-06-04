function r = BuildNeighbour(CurrentSolution, lambda, i)
    Matrizes;
    T(:,3:4)= T(:,3:4)*1e6/(8*1000);
    d= L*1e3/2e8;
    miu= R*1e9/(8*1000);
    nT= size(T,1);
    delay_flows = zeros(nT,1);
    Load= lambda./miu;
    origin= T(i,1);
 
    r = CurrentSolution(i,:);
    destination= T(i,2);
    
    j=1;
    while CurrentSolution(i, j)~= destination
        delay_flows(i) = delay_flows(i) - (1/(miu(CurrentSolution(i, j),CurrentSolution(i, j+1))-lambda(CurrentSolution(i, j),CurrentSolution(i, j+1))) + d(CurrentSolution(i, j),CurrentSolution(i, j+1)));
        delay_flows(i) = delay_flows(i) - (1/(miu(CurrentSolution(i, j+1),CurrentSolution(i, j))-lambda(CurrentSolution(i, j+1),CurrentSolution(i, j))) + d(CurrentSolution(i, j+1), CurrentSolution(i, j)));
        j= j+1;
    end
    
    r = ShortestPathSym(Load,origin,destination); 
    CurrentSolution(i,:)= r;
    
    j=1;
    while CurrentSolution(i, j)~= destination
        delay_flows(i) = delay_flows(i) + (1/(miu(CurrentSolution(i, j),CurrentSolution(i, j+1))-lambda(CurrentSolution(i, j),CurrentSolution(i, j+1))) + d(CurrentSolution(i, j),CurrentSolution(i, j+1)));
        delay_flows(i) = delay_flows(i) + (1/(miu(CurrentSolution(i, j+1),CurrentSolution(i, j))-lambda(CurrentSolution(i, j+1),CurrentSolution(i, j))) + d(CurrentSolution(i, j+1), CurrentSolution(i, j)));
        j= j+1;
    end
    
end
