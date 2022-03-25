function EG1s = addNullNodes(EG1,n2)
% add n2 null nodes to EG1

if n2==0
    EG1s = EG1;
    return
end

n1 = size(EG1.A,1);
m = size(EG1.G,2);

%% EG1s
A1s = zeros(n1+n2);
A1s(1:n1,1:n1) = EG1.A;

Abetas = zeros(size(EG1.Abeta,1),size(EG1.Abeta,2),n1+n2,n1+n2);
Abetas(:,:,1:n1,1:n1) = EG1.Abeta;

Gs = cat(1,EG1.G,zeros(n2,m));
Hs = cat(1,EG1.H,zeros(n2,m));

EG1s = EG1;
EG1s.A = A1s;
EG1s.Abeta = Abetas;
EG1s.G = Gs;
EG1s.H = Hs;
EG1s.nodeXY = [EG1.nodeXY zeros(size(EG1.nodeXY,1),n2)];