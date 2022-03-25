function [EG1r, EG2r, E, p] = matchEG(EG1,EG2,nodeFlag,KP,two_way)
% High level function to match two elastic graphs. 
% It will permute EG1's node order to match EG2
%
% Args:
%   EG1
%   EG2
%   nodeFlag: int. The weight of using node attributes for matching.
%   KP
%   two_way


if nargin<3
    nodeFlag = 0;
    KP = [];
    two_way = false;
end
if nargin<4
    KP = [];
    two_way = false;
end
if nargin<5
    two_way = false;
end

n1 = size(EG1.A,1); n2 = size(EG2.A,1);

if two_way
    fprintf('two way null node padding\n')
    [EG1s, EG2s] = addTwoWayNullNodes(EG1,EG2);
else
    fprintf('one way null node padding\n')
    [EG1s, EG2s] = addOneWayNullNodes(EG1,EG2);
end

KQ = computeKQ(EG1.beta,EG2.beta);

[p, E] = fgmEG(EG1s,EG2s,KQ,nodeFlag,KP);

if E(end)<=E(1)
    fprintf('bad matching, using original node order\n');
    [EG1s, EG2s] = addOneWayNullNodes(EG1,EG2);
    p = 1:max([n1 n2]);
    EG1p = permutateElasticGraphs(EG1s,p,EG2s);
    [EG1r,EG2r] = assignNullNodes(EG1p,EG2s,p,n1,n2);
    EG1r = interpEGAbeta(EG1r);
    return
else
    EG1p = permutateElasticGraphs(EG1s,p,EG2s);
    if two_way
        [EG1r,EG2r] = removeNullNodes(EG1p,EG2s,p,n1,n2);
    else
        [EG1r,EG2r] = assignNullNodes(EG1p,EG2s,p,n1,n2);
    end
    EG1r = interpEGAbeta(EG1r);
    return
end