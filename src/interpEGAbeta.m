function EG = interpEGAbeta(EG,translation)

n = size(EG.A,1);
nodeXY = EG.nodeXY;

if nargin>1
    nodeXY = nodeXY + translation;
end

for i = 1:n
    for j = i+1:n
        if EG.A(i,j)>0
            EG.Abeta(:,:,i,j) = shape2curve(EG.Abeta(:,:,i,j),nodeXY(:,i),nodeXY(:,j));
        end
    end
end
    