function [S,T] =EnergyStatksample(D)

%D = DisMatrix_within_ani1;
%D{i,j} is the distance matrix between cell i and cell j
N = size(cell2mat(D),1);
g = size(D,1);
for i = 1:g
    for j = i+1:g
        D2sample{1,1} = D{i,i};
        D2sample{1,2} = D{i,j};
        D2sample{2,1} = D{i,j}';
        D2sample{2,2} = D{j,j};
        ni = size(D{i,i},1);
        nj = size(D{j,j},1);
        T(i,j) = (ni+nj)/(2*N)*EnergyStat2sample(D2sample);
    end
end

 
T = T(find(T));
S = sum(T);
