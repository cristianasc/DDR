GlobalBest= Inf;
for iter=1:Iterations
    [CurrentSolution, lambda] = GreedyRandomized(); 
    [AverageDelay, max_delay] = Evaluate(CurrentSolution, lambda); 
    repeat= true;
%     while repeat<=20 
%         NeighbourBest= Inf;
%         for i=1:size(CurrentSolution,1)
%             NeighbourSolution= BuildNeighbour(CurrentSolution,i); 
%             NeighbourObjective = Evaluate(NeighbourSolution, lambda);
%             if NeighbourObjective < NeighbourBest
%                 NeighbourBest= NeighbourObjective;
%                 NeighbourBestSolution= NeighbourSolution;
%             end
%         end
%         if NeighbourBest < CurrentObjective 
%             CurrentObjective= NeighbourBest; 
%             CurrentSolution= NeighbourBestSolution;
%         else
%             repeat= 0;
%         end
%           repeat = repeat+1;
%     end
%     if CurrentObjective < GlobalBest
%         GlobalBestSolution= CurrentSolution;
%         GlobalBest= CurrentObjective;
%     end
end