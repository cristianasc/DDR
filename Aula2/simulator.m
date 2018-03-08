%Parameters initialization:
N= 30;       % Number of mobile nodes
W= 60;       % Radio range (in meters)
S= 6;        % Maximum speed (in Km/h)
delta= 1;    % Difference between consecutive time instants (in seconds)
T= 3600;     % No. of time instants of the simulation
AP = [75 100;225 100];   % Coordinates of each AP

nAP = size(AP,1);    %Number of APs
S= S/3.6;            % Conversion of maximum speed to m/s
results= zeros(1,T); % Initialization of the results array

plotar = 1;  % if plotar = 1, node movement is visualized
             % if plotar = 2, node movement and connectivity are visualized

% Generation of initial coordinates of each mobile node position and speed:
[pos,vel]= InitialRandom(N,S);
h= waitbar(0,'Running simulation...');
% Simulation cycle:
for iter= 1:T
    waitbar(iter/T,h);
    % Update coordinates of each mobile node position and speed:
    [pos,vel]= UpdateCoordinates(pos,vel,delta);
    % Compute the node pairs with direct wireless links:
    %L= ConnectedList(N,pos,W,AP);
    L = 0;
    % Compute the percentage number of connected node pairs:
    %results(iter)= AverageConnectedNodePairs(N,L);
    % Visualization of the simulation:
    if plotar==1
        visualize(pos,AP,L,plotar)
    end
end
delete(h)
% Plot the simulation results:
figure(1)
plot(1:T,results)
axis([0 T 0 110])
xlabel('Time (seconds)');
ylabel('No. of connected nodes (%)')
% Compute the final result: 
FinalResult= mean(results)

function [pos,vel]= InitialRandom(N,S)
%Computes a matrix �pos� of N rows and 2 columns with the coordinates of nodes (see Section 3.1) and a matrix �vel� of N rows and 2 columns with the initial horizontal and vertical components of the speed vector of each mobile node (see Section 3.2).
pos= [50*randi([0 6],N/2,1) 200*rand(N/2,1)]; %primeira metade
pos= [pos; 300*rand(N/2,1) 50*randi([0 4],N/2,1)]; %segunda metade
vel_abs= S*rand(N,1);
vel_angle= pi*randi([0 1],N/2,1) - pi/2; %primeira metade (de -pi/2 a pi/2)
vel_angle= [vel_angle; pi*randi([0 1],N/2,1)]; %segunda metade (de 0 a pi)
vel= [vel_abs.*cos(vel_angle) vel_abs.*sin(vel_angle)]; 
end

function [pos,vel]= UpdateCoordinates(pos,vel,delta)
%Updates the matrices �pos� and �vel� based on their input values and delta.

pos = pos+delta*vel;
%atualizar os valores se a posição for menor que 0
pos = pos + delta * vel;
pos_x=pos(:,1);  %vamos buscar os valors da primeira coluna
pos_y=pos(:,2);  %vamos buscar os valores da segunda coluna

%mudar o sinal das velocidades cuja as posições saíam fora dos limites
vel_x=vel(:,1);
vel_y=vel(:,2);
vel_x(pos_x<0 | pos_x>300)=-vel_x(pos_x<0 | pos_x>300);
vel_y(pos_y<0 | pos_y>200)=-vel_y(pos_y<0 | pos_y>200);

%devemos manter os valores dentro dos limites indicados
pos_x(pos_x<0)=0; 
pos_x(pos_x>300)=300;
pos_y(pos_y<0)=0;
pos_y(pos_y>200)=200;

%atualizar a matriz com os valores corretos
pos(:,1)=pos_x;
vel(:,1)=vel_x;
pos(:,2)=pos_y;
vel(:,2)=vel_y;

end

function L= ConnectedList(N,pos,W,AP)
%Computes a matrix �L� of 2 columns with the node pairs (mobile and AP nodes) such that their distance is not higher than W.
end

function o= AverageConnectedNodePairs(N,L)
%Computes a value �o� with the percentage number of connected node pairs based on the input matrix �L� of node pairs with direct links (see Section 4).
end

function visualize(pos,AP,L,plotar)
    N= size(pos,1);
    nAP= size(AP,1);
    plot(pos(1:N,1),pos(1:N,2),'o','MarkerEdgeColor','b','MarkerFaceColor','b')
    hold on
    plot(AP(1:nAP,1),AP(1:nAP,2),'s','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',10)
    if plotar==2
        for i=1:size(L,1)
            plot([pos(L(i,1),1) pos(L(i,2),1)],[pos(L(i,1),2) pos(L(i,2),2)])
        end
    end
    axis([0 300 0 200])
    grid on
    set(gca,'xtick',0:50:300)
    set(gca,'ytick',0:50:200)
    drawnow
    hold off
end