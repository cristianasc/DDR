G= [ 1 2
    1 3
    1 4
    1 5
    1 6
    1 14
    1 15
    2 3
    2 4
    2 5
    2 7
    2 8
    3 4
    3 5
    3 8
    3 9
    3 10
    4 5
    4 10
    4 11
    4 12
    4 13
    5 12
    5 13
    5 14
    6 7
    6 16
    6 17
    6 18
    6 19
    7 19
    7 20
    8 9
    8 21
    8 22
    9 10
    9 22
    9 23
    9 24
    9 25
    10 11
    10 26
    10 27
    11 27
    11 28
    11 29
    11 30
    12 30
    12 31
    12 32
    13 14
    13 33
    13 34
    13 35
    14 36
    14 37
    14 38
    15 16
    15 39
    15 40
    20 21];

%Nº Tiers
N = 40;
%OPEX cost of connecting a server farm to AS i
c = zeros(1,N);
for i = 6:N
    if i <= 15 
        c(1,i) = 10; % Tier-2
    else 
        c(1,i) = 8; %Tier-3 
    end 
end

I = distance(G);
file = fopen('/Users/Daniela/Desktop/UA/4ano/2semestre/ddr/practical/Aula3/lp_file.lp', 'w');                   
fprintf(file, 'Minimize\n');                        % expression to minimize
for i = 6:N
    fprintf(file, ' + %d x%d', c(i), i);            % sum ci*xi
end

fprintf(file, '\nSubject To\n');
for i = 6:N
    for j = 6:size(I,2)
        if (I(i,j) ~= 0)                            % eliminar zeros
            fprintf(file, ' + y%d,%d', i, j);  
        end                                         
    end
    fprintf(file, ' = %d\n', 1); 
end

for i = 6:N
    for j = 6:size(I,2)
        if (I(i,j) ~= 0)                            % eliminar zeros
            fprintf(file, ' + y%d,%d - x%d', i, j, j);                    
            fprintf(file, ' <= %d\n', 0);           
        end                                       
    end
end

fprintf(file, 'Binary\n');
for i = 6:N
    fprintf(file, ' x%d', i);                       
end
fprintf(file, '\n');

for i = 6:N
    for j = 6:size(I,2)
        if (I(i,j) ~= 0)                            % eliminar zeros
            fprintf(file, ' y%d,%d', i, j);    
        end
    end
end
fprintf(file, '\nEnd\n');
fclose(file);
