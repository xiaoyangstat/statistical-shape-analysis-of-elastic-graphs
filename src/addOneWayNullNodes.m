function [EG1s, EG2s] = addOneWayNullNodes(EG1,EG2)
% add abs(n1-n2) null nodes to the smaller graph

n1 = size(EG1.A,1);
n2 = size(EG2.A,1);

if n1<=n2
    EG1s = addNullNodes(EG1,n2-n1);
    EG2s = EG2;
else
    EG2s = addNullNodes(EG2,n1-n2);
    EG1s = EG1;
end
