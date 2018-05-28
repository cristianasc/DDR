% average delay for menor ou igual, e neste caso se for igual entao o max
% delay tem de ser também menor
Counter = 0
GlobalBest = Inf;
while Counter < 20
    [CurrentSolution, lambda] = GreedyRandomized(); 
    [AverageDelay, max_delay] = Evaluate(CurrentSolution, lambda); 
    repeat= true;
    while repeat
         NeighbourBest= Inf;
         for i=1:size(CurrentSolution,1)
             NeighbourSolution= BuildNeighbour(CurrentSolution,lambda, i); 
             [AverageDelayNeighbor, max_delayNeighbor] = Evaluate(NeighbourSolution, lambda);
             if AverageDelayNeighbor <= NeighbourBest
                 if AverageDelayNeighbor == NeighbourBest
                     if max_delayNeighbor < max_delay
                        max_delay = max_delayNeighbor;
                        AverageDelay = AverageDelayNeighbor;
                        %NeighbourBest= NeighbourObjective;
                        NeighbourBestSolution= NeighbourSolution;
                     end
                 else
                     max_delay = max_delayNeighbor;
                     AverageDelay = AverageDelayNeighbor;
                     %NeighbourBest= NeighbourObjective;
                     NeighbourBestSolution= NeighbourSolution;
                 end
             end
         end
         if NeighbourBest < CurrentObjective 
             CurrentObjective = NeighbourBest; 
             CurrentSolution= NeighbourBestSolution;
         else
             repeat= false;
         end
     end
     if CurrentObjective < GlobalBest
         GlobalBestSolution= CurrentSolution;
         GlobalBest= CurrentObjective;
         Counter = 0;
     else
         Counter = Counter + 1;
     end
end