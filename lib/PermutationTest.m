function [S,p,Sn] = PermutationTest(D,k)


%D = DisMatrix_within_ani1;
%D{i,j} is the distance matrix between cell i and cell j

if nargin < 2
    k = 1;
end

v = diag(cellfun('length',D));
E = cell2mat(D).^k;
D=mat2cell(E,v,v);

S = EnergyStatksample(D);

B = 30000;
for i = 1:B
    loc =  randperm(sum(v));
    
    M = E(loc,loc);
    D_new=mat2cell(M,v,v);
    Sn(i) = EnergyStatksample(D_new);
end

id= find(Sn > S); 
p =length(id)/B;