function EG = filterEG(EG,threshold)
% filter EG by dropping out the edges lower than the threshold
% 
EG.A(EG.A<threshold) = 0;
EG.Abeta(EG.A>threshold) = 0;
[G,H,~] = adj2GH(EG.A);
EG.G = G;
EG.H = H;
EG.beta = adj2beta(EG.Abeta,EG.A);