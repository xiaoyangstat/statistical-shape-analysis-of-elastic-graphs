function [EG1s, EG2s] = addTwoWayNullNodes(EG1,EG2)
% add n1 null nodes to EG2 and n2 null nodes to EG1

n1 = size(EG1.A,1);
n2 = size(EG2.A,1);

EG1s = addNullNodes(EG1,n2);
EG2s = addNullNodes(EG2,n1);