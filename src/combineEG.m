function EG = combineEG(EG1,EG2)
% concatinate EG1 and EG2 into EG

EG = EG1;

d = size(EG1.Abeta,1);T = size(EG1.Abeta,2);
n1 = size(EG1.Abeta,3);n2 = size(EG2.Abeta,3);

Abeta = zeros(d,T,n1+n2);
Abeta(:,:,1:n1,1:n1) = EG1.Abeta;
Abeta(:,:,n1+1:n1+n2,n1+1:n1+n2) = EG2.Abeta;
EG.Abeta = Abeta;

A = zeros(n1+n2,n1+n2);
A(1:n1,1:n1) = EG1.A;
A(n1+1:n1+n2,n1+1:n1+n2) = EG2.A;
EG.A = A;

nodeXY = zeros(d,n1+n2);
nodeXY(:,1:n1) = EG1.nodeXY;
nodeXY(:,n1+1:n1+n2) = EG2.nodeXY;
EG.nodeXY = nodeXY;

[G,H,~] = adj2GH(A);
EG.G = G; EG.H = H;
EG.beta = adj2beta(Abeta,A);

