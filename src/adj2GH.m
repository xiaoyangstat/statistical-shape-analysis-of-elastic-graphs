function [G,H,temp] = adj2GH(A)
% convert binary adjacency matrix to G and H

Gph = graph(A);

temp = Gph.Edges.EndNodes';%edges of graph G
temp1 = [temp(2,:);temp(1,:)];
temp  = [temp temp1];

n = size(A,1);
m = size(temp,2);% number of edges
G = zeros(n,m);% starting nodes
H = zeros(n,m);% ending nodes

% edge matrix
for i=1:m
    G(temp(1,i),i) = 1;
    H(temp(2,i),i) = 1;
end