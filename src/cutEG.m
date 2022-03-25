function [EG1,EG2] = cutEG(EG,U_hard)
% cut elastic graph EG by binary vector U_hard

EG1 = EG;
EG2 = EG;

EG1.Abeta = EG1.Abeta(:,:,U_hard,U_hard);
EG1.A = EG1.A(U_hard,U_hard);
EG1.nodeXY = EG1.nodeXY(:,U_hard);
[G,H,~] = adj2GH(EG1.A);
EG1.G = G; EG1.H = H;
EG1.beta = adj2beta(EG1.Abeta,EG1.A);

U_hard = logical(1 - U_hard);
EG2.Abeta = EG2.Abeta(:,:,U_hard,U_hard);
EG2.A = EG2.A(U_hard,U_hard);
EG2.nodeXY = EG2.nodeXY(:,U_hard);
[G,H,~] = adj2GH(EG2.A);
EG2.G = G; EG2.H = H;
EG2.beta = adj2beta(EG2.Abeta,EG2.A);