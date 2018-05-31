% average delay for menor ou igual, e neste caso se for igual entao o max
% delay tem de ser também menor
Counter = 0;
GlobalBest = Inf;
while Counter < 20
    [CurrentSolution, lambda] = GreedyRandomized(); 
    [CurrentObjective1, CurrentObjective2] = Evaluate(CurrentSolution, lambda);  %AverageDelay
    repeat= true;
    while repeat
         NeighbourBest= Inf;
         for i=1:size(CurrentSolution,1)
             NeighbourSolution= BuildNeighbour(CurrentSolution,lambda, i); 
             [NeighbourSolution1, NeighbourSolution2] = Evaluate(NeighbourSolution, lambda);
             if NeighbourSolution1 < NeighbourBest 
                 CurrentObjective2 = NeighbourSolution2;
                 CurrentObjective1 = NeighbourSolution1;
                 NeighbourBestSolution = NeighbourSolution;  
             elseif NeighbourSolution1 == NeighbourBest
                 if NeighbourSolution2 < CurrentObjective2
                    CurrentObjective2 = max_delayNeighbor;
                    CurrentObjective1 = NeighbourSolution1;
                    NeighbourBestSolution= NeighbourSolution;
                 end
             end
         end
         if NeighbourBest < CurrentObjective1 || (NeighbourBest == CurrentObjective1 && CurrentObjective2 < NeighbourSolution2)
             CurrentObjective1 = NeighbourBest;
             CurrentSolution = NeighbourBestSolution;
         else
             repeat= false;
         end
     end
     if CurrentObjective1 < GlobalBest || (CurrentObjective1 == GlobalBest &&  NeighbourSolution2 < CurrentObjective2) 
         GlobalBestSolution = CurrentSolution;
         GlobalBest = CurrentObjective1
         Counter = 0;
     else
         Counter = Counter + 1;
     end
end