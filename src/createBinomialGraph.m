function A = createBinomialGraph(n,p)
% create a symmetric adjacency matrix

A = rand(n,n) < p;
A = triu(A,1);
A = A + A';
