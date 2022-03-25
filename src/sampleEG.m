function EGs = sampleEG(EG,p)
% remove edges from EG according to the probability p

A = EG.A; Abeta = EG.Abeta; nodeXY = EG.nodeXY;
n = size(A,1);
d = size(Abeta,1);
nt = size(Abeta,2);

nullNodes = [];
k = 1;
for i = 1:n
    for j = i+1:n
        if A(i,j)>0
            if rand<p
                A(i,j) = 0;
                A(j,i) = 0;
                Abeta(:,:,i,j) = zeros(d,nt);
                Abeta(:,:,j,i) = zeros(d,nt);
                nullNodes = [nullNodes k];
            end
            k = k + 1;
        end
    end
end

%nodeXY(:,nullNodes) = [];
[G,H,~] = adj2GH(A);
EGs = struct('A',A,'Abeta',Abeta,'beta',adj2beta(Abeta,A),'G',G,'H',H,'nodeXY',nodeXY);